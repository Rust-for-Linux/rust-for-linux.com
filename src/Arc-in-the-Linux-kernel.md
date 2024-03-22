# `Arc` in the Linux kernel

This document outlines how the Linux kernel is using the unstable features [`arbitrary_self_types`](https://github.com/rust-lang/rust/issues/44874) and `dispatch_from_dyn`/[`unsize`](https://github.com/rust-lang/rust/issues/18598).

But first, an introduction to the custom types that the kernel is using.

## The kernel's custom `Arc`

The Linux kernel needs to use a [custom implementation of `Arc`](https://rust-for-linux.github.io/docs/v6.8/kernel/sync/struct.Arc.html). The most important reason is that we need to use the kernel's `refcount_t` type for the atomic instructions on the refcount. There are two reasons for this:

  1. The [standard Rust `Arc`](https://doc.rust-lang.org/std/sync/struct.Arc.html) will call `abort` on overflow. This is not acceptable in the kernel; instead we want to saturate the count when it hits `isize::MAX`. This effectively leaks the `Arc`.

  2. Using Rust atomics raises various issues with the memory model. We are using the LKMM rather than the usual C++ model, which means that all atomic operations should be implemented with an `asm!` block or similar that matches what kernel C does, rather than an LLVM intrinsic.

We also make a few other changes to our `Arc`:

  1. We need to interact with a lot of different C types that need to be pinned, so our custom `Arc` is implicitly pinned.

  2. We do not need weak references, so our refcount can be half the size.

Our `Arc` also comes with two utility types:

  1. [`ArcBorrow<'a, T>`](https://rust-for-linux.github.io/docs/v6.8/kernel/sync/struct.ArcBorrow.html). Similar to `&'a Arc<T>`, but only one level of indirection.

  2. [`UniqueArc<T>`](https://rust-for-linux.github.io/docs/v6.8/kernel/sync/struct.UniqueArc.html). Mutable access to an `Arc`. Used to split allocation and initialization into two steps, which is important since we cannot allocate memory while holding a spinlock.

## Intrusive linked lists

The kernel uses a lot of intrusive linked lists, which are extremely rare in userspace Rust. This is a consequence of a unique limitation in kernel code related to memory allocations:

  1. Memory allocations are always fallible and failures must be handled gracefully.

  2. When you are in an atomic context (e.g. when holding a spinlock), you are not allowed to allocate memory at all.

(Technically there are special ways to allocate memory in atomic context, but it should be used sparingly.)

These limitations greatly affect how we design code in the kernel. There are some functions where having a failure path is not acceptable (e.g. destroying something), and other places where we cannot allocate at all. This means that we need data structures that do not need to allocate. Or where the allocation and insert steps are separate. Imagine a map protected by a spinlock. How do you implement that if `insert` simply cannot allocate memory?

One answer to this is to use a linked list (and similar, e.g. a red/black tree can work with the same idea). The value you wish to insert takes this form:

```rust
struct MyValue {
    // In practice, these are wrapped into one field using a struct.
    next: *mut MyValue,
    prev: *mut MyValue,
    foo: Foo,
    bar: Bar,
}
```

Then, given an `Arc<MyValue>`, you can insert that into a linked list without having to allocate memory. The only thing you have to do is adjust the `next`/`prev` pointers.

Additionally, there are a bunch of C APIs that work using the same principle, so we are also forced into this pattern when we want to use those C APIs. For example, this includes the workqueue which stores the list of tasks to run in a linked list.

### The `ListArc` type

You may have noticed one problem with the above design: The value we are inserting is an `Arc<MyValue>`, so how can you get mutable access to `next`/`prev`? And how do you know that it's not already in a linked list? What about data races — someone could attempt to push (two clones of) the same `Arc<MyValue>` to two different linked lists, which would constitute a data race on the `next`/`prev` fields.

You could solve these issues by adding an `AtomicBool` for keeping track of whether it is in a list, but this isn't great. We really want to avoid the `AtomicBool`.

Our answer is another custom smart pointer type: `ListArc`. The `ListArc` type is just a newtype wrapper around `Arc` with the invariant that each `MyStruct` has at most one `ListArc` reference. However, unlike `UniqueArc`, you are allowed to have `Arc` references to a value that also has an `ListArc`. This way, the `ListArc` reference can be given exclusive access to the `next`/`prev` fields, which is enough to design a safe API for intrusive linked lists containing reference counted values.

One consequence of this is that (unlike `Arc`), we are using a smart pointer where ownership of the pointer is extremely important. You cannot just `clone` a `ListArc`.

Our `ListArc` type also has a second generic parameter, which allows you to have multiple `next`/`prev` pairs. So `ListArc<T, 1>` has exclusive access to the first `next`/`prev` pair, and `ListArc<T, 2>` has exclusive access to the second such pair. This means that you can have multiple list arcs as long as their parameter is different (one per value of the extra generic parameter).

### `next`/`prev` pointers and dynamic dispatch

We want to be able to use linked lists with `dyn Trait`. However, the offset of the `next`/`prev` fields needs to be uniform no matter what the concrete type is. To do that, we use a wrapper type:

```rust
struct Wrapper<T: ?Sized> {
    next: *mut Wrapper<T>,
    prev: *mut Wrapper<T>,
    value: T,
}
```

And the actual type ends up being `Arc<Wrapper<dyn Trait>>`.

## Arbitrary self types

We wish to use arbitrary self types in various places. Some examples:

  1. Many methods need to call `self.clone()` and get a new `Arc` to the current struct. To do that, we need `self: &Arc<T>` or `self: ArcBorrow<'_, T>`.

  2. We often need to do `linked_list.push(self)`. To do that, we need `self: ListArc<T>`.

For the struct methods, we _could_ work around this by not using `self` parameters, and calling `MyStruct::foo(my_arc)`. However, we also need to do these things in traits where we perform dynamic dispatch on the value. For example:

```rust
trait WorkItem {
    fn run1(self: ListArc<Self>);

    // or, actually:
    fn run2(self: ListArc<Wrapper<Self>>);
}
```

This use-case needs both arbitrary self types and the dynamic dispatch feature mentioned in the next section. Arbitrary self types are needed because dynamic dispatch is only performed on self parameters.

## Dynamic dispatch

We wish to use these linked lists to store dynamic trait objects. This is used for a "todo list" of events that need to be delivered to userspace. There are many different event types, and we use a trait object to store a queue of them.

There is a need to have both `Arc<MyStruct>` and `Arc<dyn MyTrait>` references to the same object.

All of the smart pointers that we want to use dynamic dispatch with are newtype wrappers around either `NonNull` or other smart pointers (e.g. `ListArc` is a wrapper around `Arc`). They may also have a `PhantomData` field. These requirements match what is listed on [`DispatchFromDyn`](https://doc.rust-lang.org/stable/std/ops/trait.DispatchFromDyn.html).

A related feature is the [`Unsize`](https://doc.rust-lang.org/stable/std/marker/trait.Unsize.html) trait. Most likely, adding the `DispatchFromDyn` trait depends on also having `Unsize`, so we need it for that reason. But we do not otherwise need the `Unsize` trait.

### C-to-Rust dynamic dispatch

The kernel also has some other uses of dynamic dispatch that trait objects don't help with. Mainly, these are cases where C defines a vtable using a struct with function pointers. Here, we must match the vtable layout that C dictates, so we will manually implement the vtable unsafely to handle these cases. We still use a trait for providing a safe API to these things, but the implementation needs only generics and not trait objects.

However, for Rust-to-Rust dynamic dispatch, trait objects appear to satisfy our needs. As long as we are able to use them with our smart pointers, that is.
