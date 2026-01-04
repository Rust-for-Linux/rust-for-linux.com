# Branches

## Main branches

Currently we maintain the following main branches. There are, of course, other trees that also land Rust code via their own trees. For the latest information, please check the [`MAINTAINERS` file](https://docs.kernel.org/process/maintainers.html).

They are all part of [`linux-next`](https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/).

### `rust-next`

[`rust-next`](https://github.com/Rust-for-Linux/linux/tree/rust-next) is the branch that contains new Rust features to be submitted during the next merge window of the Linux kernel. That is, it is the development branch of the ["RUST" entry](https://docs.kernel.org/process/maintainers.html#rust) in the `MAINTAINERS` file.

Changes to this branch land via patches sent to the mailing list, or through pulls of one of the subtrees (please see below).

It is part of [`linux-next`](https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/).

### `rust-fixes`

[`rust-fixes`](https://github.com/Rust-for-Linux/linux/tree/rust-fixes) is the branch that contains Rust fixes for the current cycle of the Linux kernel.

Changes to this branch land via patches sent to the mailing list.

It is part of [`linux-next`](https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/).

## Subtree branches

These are the branches of the Rust subtrees that land into mainline via the main `rust-next` branch.

Changes to these branches land via patches sent to the mailing list.

They are all part of [`linux-next`](https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/). Fixes for these branches land through `rust-fixes`.

### `alloc-next`

[`alloc-next`](https://github.com/Rust-for-Linux/linux/tree/alloc-next) is the branch for the ["RUST [ALLOC]" entry](https://docs.kernel.org/process/maintainers.html#rust-alloc) and the ["DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" entry](https://docs.kernel.org/process/maintainers.html#dma-mapping-helpers-device-driver-api-rust) in the `MAINTAINERS` file.

### `pin-init-next`

[`pin-init-next`](https://github.com/Rust-for-Linux/linux/tree/pin-init-next) is the branch for the ["RUST [PIN-INIT]" entry](https://docs.kernel.org/process/maintainers.html#rust-pin-init) in the `MAINTAINERS` file.

### `timekeeping-next`

[`timekeeping-next`](https://github.com/Rust-for-Linux/linux/tree/timekeeping-next) is the branch for the ["DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]" entry](https://docs.kernel.org/process/maintainers.html#delay-sleep-timekeeping-timers-rust) in the `MAINTAINERS` file.

### `xarray-next`

[`xarray-next`](https://github.com/Rust-for-Linux/linux/tree/xarray-next) is the branch for the ["XARRAY API [RUST]" entry](https://docs.kernel.org/process/maintainers.html#xarray-api-rust) in the `MAINTAINERS` file.

## Past branches

These branches are unmaintained, archived, deprecated, frozen or do not exist anymore in the repository.

### `rust`

[`rust`](https://github.com/Rust-for-Linux/linux/tree/rust) was the original branch where development happened for two years before Rust support was merged into the kernel.

It contains most of the abstractions that the project worked on as a prototype/showcase. Some of those may eventually land upstream, others may be reworked with feedback from upstream, and a few may be dropped if unneeded.

The branch is now archived, thus no new changes are merged into it. While it may be deleted eventually, for the moment it is kept around since some of the code did not make it upstream and may be useful for others.

Similarly, its [Rust code documentation (2023-03-13)](https://rust-for-linux.github.io/docs/rust/kernel/) is archived as well.

Changes to this branch landed via [GitHub PRs](https://github.com/Rust-for-Linux/linux/pulls). GitHub Actions was used as a pre-merge CI, compiling the kernel and booting it under QEMU for different toolchains, architectures and configurations. It also checked that some tests passed (e.g. loading sample modules, KUnit tests...) as well as building the PR under Clippy, building the docs, checking `rustfmt`, etc. [KernelCI](https://linux.kernelci.org/job/rust-for-linux/branch/rust/) tests it. Finally, in the past, the [Ksquirrel](Ksquirrel.md) bot checked the PRs sent to it.

### `rust-dev`

[`rust-dev`](https://github.com/Rust-for-Linux/linux/tree/rust-dev) is an experimental branch for integration purposes. It is a queue for patches that "look good enough".

Its intended use cases are:

  - Finding merge/apply conflicts as early as possible.
  - Providing a common base for development that requires features that are not yet in mainline or `rust-next`, i.e. giving early access to features. This may include Rust-related changes from other subsystems, but it is not intended to cover our topic branches.
  - Providing extra testing to patches by making them easily available to more developers.

Note that this branch may be updated/rebased frequently and it might be gone in the future. Currently, it is on hold.

### Topic branches (`staging/*`)

These branches were focused on a particular topic and were meant to enable collaboration on code that is targeted for upstreaming but has not reached mainline yet.

Some of these branches may contain work-in-progress code (similar to [staging trees](https://docs.kernel.org/process/2.Process.html?highlight=staging#staging-trees)) that may not be suitable for upstreaming or general usage yet. Please check the details of each branch.

Changes to these branches land via GitHub PRs. Nevertheless, contributions should still follow the usual Linux kernel development process — see [Contributing](Contributing.md) for details.

If you are interested in maintaining a new topic branch, then please [contact us](Contact.md). Thank you!

#### `staging/rust-net`

[`staging/rust-net`](https://github.com/Rust-for-Linux/linux/tree/staging/rust-net) is dedicated to networking-related abstractions.

The branch is kept in a compilable state (rebased regularly on top of `rust-next` or mainline). Fixes and features are welcome.

It is maintained by Trevor Gross and Valentin Obst. Please contact them through [Zulip](Contact.md#zulip-chat).
