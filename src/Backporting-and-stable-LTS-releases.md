# Backporting and stable/LTS releases

The [_stable_ and _longterm_ (LTS) kernel releases](https://www.kernel.org/category/releases.html) only receive fixes, and thus [do not accept new features](https://docs.kernel.org/process/stable-kernel-rules.html). Therefore, it is generally not possible to backport new Rust features or abstractions from mainline. However, exceptions may apply.

We do our best to maintain the existing Rust support in Linux v6.1 LTS, v6.6 LTS and v6.12 LTS:

  - Linux v6.1 LTS and v6.6 LTS have the Rust compiler version pinned, i.e. a single version of Rust works with each of those releases.

  - Linux v6.12 LTS is the first LTS that had a minimum supported Rust version, i.e. unpinned.

    We will do our best to avoid having to establish a maximum Rust version for that LTS, i.e. to support future Rust releases. However, given the use of unstable features back then, we cannot guarantee it.

## Older LTS releases

There has been some interest over time in backported Rust support for Linux v5.10 LTS and v5.15 LTS.

In general, maintaining an LTS branch, even if based on an official one, requires substantial effort and a long-term commitment, as it should be consistently supported until reaching its End of Life. If we were to consider it, there would need to be a strong demand and/or additional resources provided. If your company, organization or team would be interested, then please [contact us](Contact.md).

There would be several points to consider:

  - The level of support and the security and scheduling implications.

  - Whether all new abstractions, drivers and overall features appearing in mainline are backported, and whether those that require extra backports on the C side to support them should be included.

  - Whether the Rust version policy would be different than the one in mainline, e.g. whether the Rust version would be fixed (like it is in older upstream LTS kernels).
