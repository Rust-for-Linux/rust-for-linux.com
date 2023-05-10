# Third-party crates

## Introduction

Rust provides a package manager and build system called [Cargo](https://doc.rust-lang.org/cargo/). Rust also provides [crates.io](https://crates.io), its default package registry. In userspace, all these form a solution that a lot of open-source Rust projects use.

Some of those open-source libraries are potentially usable in the kernel because they only depend on `core` and `alloc` (rather than `std`), or because they only provide macro facilities.

Thus it is natural to consider whether some of these libraries could be reused for the kernel.

## Suitability of a crate

Even if a library only depends on `core` and `alloc`, it may still not be usable within the kernel for other reasons.

For instance, its license may be incompatible, it may not support fallible allocations, the kernel may only need a very small subset of what it supports (even if it supports configuring out some of its features), the kernel may already provide the same functionality on the C side (which could be abstracted), etc.

On top of that, the code of a crate may require some changes to be adapted for the kernel anyway. For instance, adding SPDX license identifiers, removing a dependency, tweaking some code, enabling an unstable feature, etc.

Moreover, new code arriving to the kernel should be maintained; and thus somebody needs to step up for that role.

Therefore, in general, whether a third-party crate is suitable for the kernel needs to be decided on a case-by-case basis.

## Importing crates

The kernel currently integrates some dependencies (e.g. some of the compression algorithms or our Rust `alloc` fork) by importing the files into its source tree, adapted as needed. In other words, they are not fetched/patched on demand.

There have been discussions about potentially incorporating a system where crates/libraries are fetched dynamically given a list of crates, versions, hashes, etc.; however, it remains to be seen whether such a system would be preferred and accepted.

## Supporting out-of-tree modules

The project is focused on getting features upstreamed, i.e. available for everybody. Therefore, if mainline does not support third-party crates and/or a system to fetch them dynamically, then it is unlikely it will be supported for out-of-tree modules.

## Experiment

Experimental integration for a few popular crates has been provided for interested users, e.g. [PR #1007](https://github.com/Rust-for-Linux/linux/pull/1007) adds support for `proc-macro2`, `quote`, `syn`, `serde` and `serde_derive`.

## Feedback

We are looking for [feedback](Contact.md) from other kernel developers, maintainers and companies on which third-party crates would be most useful to have in the kernel.
