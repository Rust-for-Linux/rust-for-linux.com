# Unstable features

## Introduction

The Rust language is stable, i.e. it promises [backwards compatibility](https://blog.rust-lang.org/2014/10/30/Stability.html) within the same [edition](https://doc.rust-lang.org/edition-guide/editions/), with a few exceptions, such as reserving the right to patch safety holes. The kernel currently uses Edition 2021, which is the latest.

On top of that, the kernel uses some Rust unstable features. These features can only be accessed by opting into them. They are typically used as a way to introduce new features into the language, library and toolchain to allow end users to experiment with them and provide feedback before committing to them.

"Unstable" in this context means the feature may change in future versions, i.e. backwards compatibility is not promised for those features. It does not imply that the features are broken. For instance, unstable features may be production-ready and ready for stabilization or they may be experimental, incomplete or internal to the compiler.

When unstable features are deemed mature enough, they may get promoted into stable Rust. In other cases, they may get dropped altogether. Some features are internal to the compiler or perma-unstable.

There are ongoing discussions around stability within the Rust project, such as potentially defining [extra phases](https://smallcultfollowing.com/babysteps/blog/2023/09/18/stability-without-stressing-the-out/). These finer-grained levels could be useful for the kernel.

## Usage in the kernel

The unstable features used in the kernel are tracked at [issue #2](https://github.com/Rust-for-Linux/linux/issues/2).

Removing the need for these is a priority in order to be able to eventually declare a [minimum Rust version for the kernel](Rust-version-policy.md).

Therefore, the set of unstable features used in the kernel needs to be carefully considered. Typically, for each of them, we need to consider:

  - Whether there is no other way around the issue they help with, or whether the alternative is considered to have bigger downsides than using the unstable feature.

  - Whether they would be required to build the kernel.

  - Whether stabilization is likely, whether they are internal to the compiler and whether they are used in the standard library.

  - Whether other features that are on the critical path will likely take longer to get stabilized anyway.

Moreover, most of the features are only allowed within the `kernel` crate, i.e. for abstractions. Elsewhere (e.g. drivers), only a minimal set is allowed (see the `rust_allowed_features` variable in [`scripts/Makefile.build`](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.build)).

If you would like to use a new Rust unstable feature in the kernel, then please [contact us](Contact.md).

## Rust for Linux in the Rust pre-merge CI

Rust for Linux is currently being built-tested in Rust's pre-merge CI, i.e. the process that checks every change that is attempting to land into the Rust project in order to always keep it in a valid state.

This allows both Rust for Linux and the Rust project to catch very early any unexpected changes that would break the kernel's usage of unstable features, as well as any other change that may affect it.

The CI job may still need to be temporarily disabled for different reasons, but the intention is to help bring Rust for Linux into stable Rust.

Thanks to the Rust project for adding the Linux kernel to their CI!

### `alloc` (older releases)

[`alloc`](https://doc.rust-lang.org/alloc/) is part of the Rust standard library and its implementation uses many unstable features. Normally, this library (as well as [`core`](https://doc.rust-lang.org/core/) and others) is provided by the compiler, and thus those unstable features do not break users' code.

In older releases, the kernel contained a fork of `alloc` (matched to the supported Rust version by the kernel) with some additions on top. This complicated compiling the kernel with a different compiler version due to those unstable features, but this fork was meant to be temporary, and eventually it got dropped in v6.10. The original plan for `alloc` discussed with upstream Rust (and others) was documented in-tree in the [`rust/alloc/README.md`](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/alloc/README.md?h=v6.6) file.
