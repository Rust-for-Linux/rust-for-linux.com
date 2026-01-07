# Past branches

These branches are unmaintained, archived, deprecated, frozen or do not exist anymore in the repository. Historical details about them follow.

## `rust`

[`rust`](https://github.com/Rust-for-Linux/linux/tree/rust) was the original branch where development happened for two years before Rust support was merged into the kernel.

It contains most of the abstractions that the project worked on as a prototype/showcase. Some of those may eventually land upstream, others may be reworked with feedback from upstream, and a few may be dropped if unneeded.

The branch is now archived, thus no new changes are merged into it. While it may be deleted eventually, for the moment it is kept around since some of the code did not make it upstream and may be useful for others.

Similarly, its [Rust code documentation (2023-03-13)](https://rust-for-linux.github.io/docs/rust/kernel/) is archived as well.

Changes to this branch landed via [GitHub PRs](https://github.com/Rust-for-Linux/linux/pulls). GitHub Actions was used as a pre-merge CI, compiling the kernel and booting it under QEMU for different toolchains, architectures and configurations. It also checked that some tests passed (e.g. loading sample modules, KUnit tests...) as well as building the PR under Clippy, building the docs, checking `rustfmt`, etc. [KernelCI](https://linux.kernelci.org/job/rust-for-linux/branch/rust/) tests it. Finally, in the past, the [Ksquirrel](Ksquirrel.md) bot checked the PRs sent to it.

## `rust-dev`

[`rust-dev`](https://github.com/Rust-for-Linux/linux/tree/rust-dev) was an experimental branch for integration purposes. It was a queue for patches that "looked good enough".

Its intended use cases were:

  - Finding merge/apply conflicts as early as possible.
  - Providing a common base for development that requires features that are not yet in mainline or `rust-next`, i.e. giving early access to features. This may include Rust-related changes from other subsystems, but it was not intended to cover our topic branches.
  - Providing extra testing to patches by making them easily available to more developers.

This branch was intended to be updated/rebased frequently.

## Topic branches (`staging/*`)

These branches were focused on a particular topic and were meant to enable collaboration on code that is targeted for upstreaming but has not reached mainline yet. The intention was to make it easy to request/add new ones.

Some of these branches may contain work-in-progress code (similar to [staging trees](https://docs.kernel.org/process/2.Process.html?highlight=staging#staging-trees)) that may not be suitable for upstreaming or general usage yet. Please check the details of each branch.

Changes to these branches landed via GitHub PRs. Nevertheless, contributions should still follow the usual Linux kernel development process — see [Contributing](Contributing.md) for details.

### `staging/dev`

`staging/dev` was a branch intended to integrate the other topic branches (similar to the role of `rust-dev` for the main branches).

It was maintained by Danilo Krummrich and Philipp Stanner. You could contact them through [Zulip](Contact.md#zulip-chat).

### `staging/rust-device`

`staging/rust-device` was dedicated to device/driver-related abstractions.

The branch was kept in a compilable state (rebased regularly on top of `rust-next` or mainline). Fixes and features were welcome.

It was maintained by Danilo Krummrich and Philipp Stanner. You could contact them through [Zulip](Contact.md#zulip-chat).

### `staging/rust-net`

[`staging/rust-net`](https://github.com/Rust-for-Linux/linux/tree/staging/rust-net) was dedicated to networking-related abstractions.

The branch was kept in a compilable state (rebased regularly on top of `rust-next` or mainline). Fixes and features were welcome.

It was maintained by Trevor Gross and Valentin Obst. You could contact them through [Zulip](Contact.md#zulip-chat).

### `staging/rust-pci`

`staging/rust-pci` was dedicated to PCI-related abstractions, which were used by e.g. the [NVMe driver](NVMe-driver.md).

The branch was kept in a compilable state (rebased regularly on top of `rust-next` or mainline). Fixes and features were welcome.

It was maintained by Danilo Krummrich. You could contact him through [Zulip](Contact.md#zulip-chat).
