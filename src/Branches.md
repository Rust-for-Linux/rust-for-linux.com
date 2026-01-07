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

There are also other branches that are unmaintained, archived, deprecated, frozen or do not exist anymore in the repository. For historical details about these, please see our [Past branches](Past-branches.md) page.
