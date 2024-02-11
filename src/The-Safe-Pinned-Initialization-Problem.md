# The Safe Pinned Initialization Problem

## Introduction to Pinning

In the kernel many data structures are not allowed to change address, since there exist external pointers to them that would then be invalidated. Since this could cause memory errors, Rust has to *somehow* guarantee that this cannot happen in safe code. Luckily there already exists the [`Pin<P>`] wrapper type for arbitrary pointer types `P`. For simplicity we will look at `P = Box<T>`. [`Box<T>`] is a smart pointer that owns a `T` (a generic parameter) allocated on the heap. When a [`Box<T>`] is dropped (destroyed) then it automatically frees the memory.

`Pin<Box<T>>` behaves similar to [`Box<T>`], it is also a smart pointer and allows you to have immutable access to the fields and functions of `T`. You can also store it just as easily, since it also has the same size as `Box<T>`.

One important difference compared to just `Box<T>` is that `Pin` prevents mutable access to the underlying [`Box<T>`] and thus makes it impossible to move the pointee. So users are unable to call e.g. [`mem::swap`]. This is of course a heavy restriction, so there exist `unsafe` functions that allow modification and access to `&mut T` and so called pin-projections to access fields of `T`. However, when using these functions, it is the caller's responsibility to uphold the pinning guarantee.

This guarantee also includes that the object is `drop`ed before the memory is deallocated or repurposed. At first glance, this requirement seems strange. But after this example it will hopefully seem very natural. Let's imagine that we want to design a Rust version of `list_head`[^1]:
```rust
/// # Invariants
///
/// `next` and `prev` always point to a valid `ListHead`.
struct ListHead {
    next: *mut ListHead,
    prev: *mut ListHead,
}
```
Then we need to ensure that as long as an element is in a list, it will stay alive, since it would cause a UAF (use after free) otherwise. A simple way to achieve this, is to remove it from the list, when it gets dropped:
```rust
impl Drop for ListHead {
    fn drop(&mut self) {
        let prev = self.prev;
        let next = self.next;
        // SAFETY: By the invariant, these pointers are valid.
        unsafe {
            (*next).prev = prev;
            (*prev).next = next;
        }
    }
}
```
And this is the important bit, if we were to just deallocate/reuse the memory of a `ListHead` without dropping it first, by e.g. using [`ptr::write`], then we are just begging for a UAF to happen.

Because the [`Box<T>`] smart pointer owns its memory, it cannot be used for a function which does not consume the value. For this reason the mutable reference `&mut T` is used. When dealing with `Pin<Box<T>>`, we cannot access `&mut T`. Instead we can access `Pin<&mut T>` which still upholds the pinning guarantee.

## Adding Initialization into the mix

What does initialization have to do with pinning? In the first paragraph nothing suggested that there would be a connection. One important feature of Rust forces this connection. In Rust all values have to be initialized at *all* times. This is a problem for creating our `ListHead` the usual Rust way; a `new()` function that returns the object by value. Since we first need to know its address before we can initialize `next` and `prev` to point to itself.

Rust has a way around the "values are vaild at all times" problem: `MaybeUninit<T>` is a wrapper that explicitly allows uninitialized values. `unsafe` functions are then used to access the `T` once initialized. For our `ListHead` we could simply allocate a `MaybeUninit<ListHead>` and then write its address using raw pointers into `next` and `prev`. However, as already said above, in Rust the normal way of creating an object is to return it by value. We cannot do this for the `ListHead`, since that would move it and invalidate its pointers. The alternative of allocating it on the heap, i.e. returning a `Pin<Box<ListHead>>` also does not work, since this list should be part of a bigger struct.

This is the reason why Rust-for-Linux chose a two-function approach:
```rust
impl ListHead {
    /// Creates a new [`ListHead`].
    ///
    /// # Safety
    ///
    /// Before using this [`ListHead`] the caller has to call [`ListHead::init`].
    unsafe fn new() -> Self {
        Self {
            next: ptr::null_mut(),
            prev: ptr::null_mut(),
        }
    }

    /// Initializes this [`ListHead`].
    ///
    /// # Safety
    ///
    /// This function is only called once.
    unsafe fn init(self: Pin<&mut Self>) {
        // SAFETY: We do not move `self`.
        let this: &mut Self = unsafe { self.get_unchecked_mut() };
        let ptr: *mut ListHead = this;
        unsafe {
            (*ptr).prev = ptr;
            (*ptr).next = ptr;
        }
    }
}
```
This approach avoids having to allocate and lets the user decide the memory location of the `ListHead`. It also ensures that a `ListHead` will be pinned in memory, since the `self` type of `init` is `Pin<&mut Self>`. Both functions have to be marked `unsafe`, since the safety preconditions cannot be enforced by the compiler. We also have to use two functions, since after a call to `new` the caller will have to pin the value in memory prior to calling `init`.

The biggest problem with this approach is that it exclusively relies on the programmer to ensure safety. It is very easy to forget such an `init` call when you have a struct with multiple fields that require this treatment. This problem is exacerbated by the fact that this API propagates to all structs that contain a `ListHead`:
```rust
struct DoubleList {
    list_a: ListHead,
    list_b: ListHead,
}

impl DoubleList {
    /// # Safety
    ///
    /// Before using this [`DoubleList`] the caller has to call [`DoubleList::init`].
    unsafe fn new() -> Self {
        Self {
            // SAFETY: We call `ListHead::init` in our own initializer.
            list_a: unsafe { ListHead::new() },
            // SAFETY: We call `ListHead::init` in our own initializer.
            list_b: unsafe { ListHead::new() },
        }
    }

    /// # Safety
    ///
    /// This function is only called once.
    unsafe fn init(self: Pin<&mut Self>) {
        // SAFETY: We structurally pin `list_a`.
        let list_a = unsafe { self.map_unchecked_mut(|s| &mut s.list_a) };
        // SAFETY: Our function is only called once.
        unsafe { ListHead::init(list_a) };
        // SAFETY: We structurally pin `list_b`.
        let list_b = unsafe { self.map_unchecked_mut(|s| &mut s.list_b) };
        // SAFETY: Our function is only called once.
        unsafe { ListHead::init(list_b) };
    }
}
```
So not only the `kernel` crate developers have to cope with this API, but *everyone* who dares to have a `Mutex<T>` in their struct, or use a struct that transitively contains a `Mutex<T>`.

## Pin Complications

The previous example also shows a different, but related issue: pin-projections. These are how we access the fields of pinned structs. And because one can break the pinning guarantee the `map_unchecked_mut` function has to be `unsafe`. The requirement for them is consistency, you are only allowed to either structurally pin a field, so you allow the access of `Pin<&mut Struct> -> Pin<&mut Field>`, or you do not structurally pin the field, i.e. allowing `Pin<&mut Struct> -> &mut Field`. As long as only one of those options is done, the pinning guarantee is upheld.

In userland Rust this problem is addressed by using the [`pin-project`] crate. This crate generates the pin-projections from the struct definition:
```rust
#[pin_project]
struct DoubleList {
    #[pin]
    list_a: ListHead,
    #[pin]
    list_b: ListHead,
}
```
Now both fields are structurally pinned and can be safely accessed.

This crate cannot be used in the kernel, since it relies on [`syn`] -- the de facto Rust code parsing library for proc-macros. The problem with including [`syn`] in the kernel is that it consists of over 50k lines of code.

There is also the [`pin-project-lite`] crate that achieves almost the same thing without a proc-macro. It has 5k lines of code and contains a very complex macro that would require further modification to serve this purpose, which would be hard to maintain.

These reasons ultimately resulted in not using any of the existing approaches. The problem of pin projections also prompted the creation of the [field projection RFC](https://github.com/rust-lang/rfcs/pull/3318).

If you now want to view how to use the API, then take a look at the [extensive documentation](https://rust-for-linux.github.io/docs/pinned-init/kernel/init/).

## Further Resources on Pinning

- Rust documentation: <https://doc.rust-lang.org/core/pin/index.html>
- Pinning and its problems outlined in the context of futures: <https://fasterthanli.me/articles/pin-and-suffering>
- Pinning in Rust -- Kangrejos Presentation <https://kangrejos.com> Slides: <https://kangrejos.com/Pinning%20in%20Rust.pdf>

[^1]: The example presented here, glosses over some very important details. The `next` and `prev`
    fields of the `ListHead` struct should actually be placed in [`Cell<T>`]s to allow modification
    through `&ListHead`, since we cannot have multiple `&mut ListHead`s at the same time. And we
    need to have multiple when iterating through a list. Also, `ListHead` should contain a
    `PhantomPinned` field to ensure it cannot be unpinned.

[`mem::swap`]: https://doc.rust-lang.org/core/mem/fn.swap.html
[`ptr::write`]: https://doc.rust-lang.org/core/ptr/fn.write.html
[`MaybeUninit<T>`]: https://doc.rust-lang.org/core/mem/union.MaybeUninit.html
[`assume_init()`]: https://doc.rust-lang.org/core/mem/union.MaybeUninit.html#method.assume_init
[`pin-project`]: https://crates.io/crates/pin-project
[`pin-project-lite`]: https://crates.io/crates/pin-project-lite
[`syn`]: https://crates.io/crates/syn
[`Box<T>`]: https://doc.rust-lang.org/alloc/boxed/struct.Box.html
[`Pin<P>`]: https://doc.rust-lang.org/core/pin/struct.Pin.html
[`Cell<T>`]: https://doc.rust-lang.org/core/cell/struct.Cell.html
