# Branches

## Main branches

Currently we maintain the following main branches.

### `rust-next`

[`rust-next`](https://github.com/Rust-for-Linux/linux/tree/rust-next) is the branch that contains new Rust features to be submitted during the next merge window of the Linux kernel.

Changes to this branch land via patches sent to the mailing list.

It is part of [`linux-next`](https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/).

### `rust-fixes`

[`rust-fixes`](https://github.com/Rust-for-Linux/linux/tree/rust-fixes) is the branch that contains Rust fixes for the current cycle of the Linux kernel.

Changes to this branch land via patches sent to the mailing list.

It is part of [`linux-next`](https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/).

### `rust-dev`

[`rust-dev`](https://github.com/Rust-for-Linux/linux/tree/rust-dev) is an experimental branch for integration purposes. It is a queue for patches that "look good enough".

Its intended use cases are:

  - Finding merge/apply conflicts as early as possible.
  - Providing a common base for development that requires features that are not yet in mainline or `rust-next`, i.e. giving early access to features. This may include Rust-related changes from other subsystems.
  - Providing extra testing to patches by making them easily available to more developers.

Note that this branch may be updated/rebased frequently and it might be gone in the future.

## Topic branches

These branches are focused on a particular topic and are meant to enable collaboration on code that is targeted for upstreaming but has not reached mainline yet.

Changes to these branches land via GitHub PRs. Nevertheless, contributions should still follow the usual Linux kernel development process — see [Contributing](Contributing.md) for details.

If you are interested in maintaining a new topic branch, then please [contact us](Contact.md). Thank you!

## Past branches

These branches are unmaintained, archived, deprecated, frozen or do not exist anymore in the repository.

### `rust`

[`rust`](https://github.com/Rust-for-Linux/linux/tree/rust) was the original branch where development happened for two years before Rust support was merged into the kernel.

It contains most of the abstractions that the project worked on as a prototype/showcase. Some of those may eventually land upstream, others may be reworked with feedback from upstream, and a few may be dropped if unneeded.

The branch is now archived, thus no new changes are merged into it. While it may be deleted eventually, for the moment it is kept around since some of the code did not make it upstream and may be useful for others.

Changes to this branch landed via [GitHub PRs](https://github.com/Rust-for-Linux/linux/pulls). GitHub Actions was used as a pre-merge CI, compiling the kernel and booting it under QEMU for different toolchains, architectures and configurations. It also checked that some tests passed (e.g. loading sample modules, KUnit tests...) as well as building the PR under Clippy, building the docs, checking `rustfmt`, etc. [KernelCI](https://linux.kernelci.org/job/rust-for-linux/branch/rust/) tests it. Finally, in the past, the [Ksquirrel](Ksquirrel.md) bot checked the PRs sent to it.
