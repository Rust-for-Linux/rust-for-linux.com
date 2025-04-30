# Unstable features

## Introduction

The Rust language is stable, i.e. it promises [backwards compatibility](https://blog.rust-lang.org/2014/10/30/Stability.html) within the same [edition](https://doc.rust-lang.org/edition-guide/editions/), with a few exceptions, such as reserving the right to patch safety holes. The kernel currently uses Edition 2021.

On top of that, the kernel uses some Rust unstable features. These features can only be accessed by opting into them. They are typically used as a way to introduce new features into the language, library and toolchain to allow end users to experiment with them and provide feedback before committing to them.

"Unstable" in this context means the feature may change in future versions, i.e. backwards compatibility is not promised for those features. It does not imply that the features are broken. For instance, unstable features may be production-ready and ready for stabilization or they may be experimental, incomplete or internal to the compiler.

When unstable features are deemed mature enough, they may get promoted into stable Rust. In other cases, they may get dropped altogether. Some features are internal to the compiler or perma-unstable.

## Usage in the kernel

The unstable features used in the kernel are tracked at [issue #2](https://github.com/Rust-for-Linux/linux/issues/2).

Most of the features are only allowed within the `kernel` crate, i.e. for abstractions. Elsewhere (e.g. drivers), only a minimal set is allowed (see the `rust_allowed_features` variable in [`scripts/Makefile.build`](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.build)).

Removing the need for unstable features is a priority in order to ensure the kernel can be built with future Rust compiler versions without major changes on the kernel side. To that end, we are working with upstream Rust to get the Linux kernel into stable Rust. On top of that, the kernel is build-tested in the pre-merge CI of the Rust and `bindgen` projects. Please see the [Rust version policy](Rust-version-policy.md) page for more details.
