# Unstable features

## Introduction

The kernel uses some Rust unstable features. These features can only be accessed by opting into them. They are typically used as a way to introduce new features into the language, library and toolchain to allow end users to experiment with them and provide feedback before committing to them.

"Unstable" in this context means the feature may change in future versions, i.e. backwards compatibility is not promised for those features. It does not necessarily imply that the features are broken.

When unstable features are deemed mature enough, they may get promoted into stable Rust. In other cases, they may get dropped altogether. Some features are internal to the compiler or perma-unstable.

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
