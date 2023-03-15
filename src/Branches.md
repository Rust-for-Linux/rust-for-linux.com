# Branches

Currently we maintain the following branches.

## `rust-next`

[`rust-next`](https://github.com/Rust-for-Linux/linux/tree/rust-next) is the branch that contains new Rust features to be submitted during the next merge window of the Linux kernel.

Changes to this branch land via patches sent to the mailing list.

It is part of [`linux-next`](https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/).

## `rust-fixes`

[`rust-fixes`](https://github.com/Rust-for-Linux/linux/tree/rust-fixes) is the branch that contains Rust fixes for the current cycle of the Linux kernel.

Changes to this branch land via patches sent to the mailing list.

It is part of [`linux-next`](https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/).

## `rust`

[`rust`](https://github.com/Rust-for-Linux/linux/tree/rust) was the original branch where development happened for two years before Rust support was merged into the kernel.

It contains most of the abstractions that the project worked on as a prototype/showcase. Some of those will eventually land upstream, others may be reworked with feedback from upstream, and a few may be dropped if unneeded.

The branch is now effectively frozen, and generally the only changes that are merged into it are intended to minimize the difference with respect to mainline. When the diff is small enough, the branch will be archived/removed. Until then, the branch is useful to see what is left to upstream, and for some downstream projects to base their work on top.

However, please feel free to submit new PRs for this branch. This is useful so that others are aware of [what you are working on](Contributing.md). Even if you cannot submit a PR, please consider [telling us](Contact.md) about it.

Changes to this branch land via [GitHub PRs](https://github.com/Rust-for-Linux/linux/pulls). GitHub Actions is used as a pre-merge CI, compiling the kernel and booting it under QEMU for different toolchains, architectures and configurations. It also checks that some tests passed (e.g. loading sample modules, KUnit tests...) as well as building the PR under Clippy, building the docs, checking `rustfmt`, etc. [KernelCI](https://linux.kernelci.org/job/rust-for-linux/branch/rust/) tests it. Finally, in the past, the [Ksquirrel](Ksquirrel.md) bot checked the PRs sent to it.
