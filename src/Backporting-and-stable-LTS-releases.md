# Backporting and stable/LTS releases

The [_stable_ and _longterm_ (LTS) kernel releases](https://www.kernel.org/category/releases.html) only receive fixes, and thus [do not accept new features](https://docs.kernel.org/process/stable-kernel-rules.html). Therefore, it is generally not possible to backport new Rust features or abstractions from mainline. However, exceptions may apply.

We do our best to maintain the existing Rust support in Linux v6.1 LTS, v6.6 LTS and v6.12 LTS:

  - Linux v6.1 LTS and v6.6 LTS have the Rust compiler version pinned, i.e. a single version of Rust works with each of those releases.

  - Linux v6.12 LTS is the first LTS that had a minimum supported Rust version, i.e. unpinned.

    We will do our best to avoid having to establish a maximum Rust version for that LTS, i.e. to support future Rust releases. However, given the use of unstable features back then, we cannot guarantee it.
