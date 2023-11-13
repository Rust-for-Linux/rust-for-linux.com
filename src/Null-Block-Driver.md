
# Null Block Driver

The Rust null block driver `rnull` is an effort to implement a drop in
replacement for `null_blk` in Rust.

A null block driver is a good opportunity to evaluate Rust bindings for the
block layer. It is a small and simple driver and thus should be simple to reason
about. Further, the null block driver is not usually deployed in production
environments. Thus, it should be fairly straight forward to review, and any
potential issues are not going to bring down any production workloads.

Being small and simple, the null block driver is a good place to introduce the
Linux kernel storage community to Rust. This will help prepare the community for
future Rust projects and facilitate a better maintenance process for these
projects.

[Statistics](https://lore.kernel.org/all/87y1ofj5tt.fsf@metaspace.dk/) from the
commit log of the [C `null_blk`
driver](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/block/null_blk?h=v6.1)
([before
move](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/block/null_blk_main.c?h=v6.1&id=ea17fd354ca8afd3e8962a77236b1a9a59262fdd))
show that the C null block driver has had a significant amount of memory safety
related problems in the past. 41% of fixes merged for the C null block driver
are fixes for memory safety issues. This makes the null block driver a good
candidate for rewriting in Rust.

The driver is implemented entirely in safe Rust, with all unsafe code fully
contained in the abstractions that wrap the C APIs.

## Features

Implemented features:

 - `blk-mq` support
 - Direct completion
 - SoftIRQ completion
 - Timer completion
 - Read and write requests
 - Optional memory backing

Features available in the C `null_blk` driver that are currently not implemented
in this work:

 - Bio-based submission
 - NUMA support
 - Block size configuration
 - Multiple devices
 - Dynamic device creation/destruction
 - Queue depth configuration
 - Queue count configuration
 - Discard operation support
 - Cache emulation
 - Bandwidth throttling
 - Per node hctx
 - IO scheduler configuration
 - Blocking submission mode
 - Shared tags configuration (for >1 device)
 - Zoned storage support
 - Bad block simulation
 - Poll queues

## Resources

 - [Latest patches](https://github.com/metaspace/linux/tree/null_blk)
 - [Original RFC Patches](https://github.com/metaspace/linux/tree/null_block-RFC)
 - [Mailing List Post](https://lore.kernel.org/all/20230503090708.2524310-1-nmi@metaspace.dk/)

# Performance September 2023 ([`null_blk-6.6`](https://github.com/metaspace/linux/tree/null_blk-6.6))

## Setup

 - 12th Gen Intel(R) Core(TM) i5-12600
 - 32 GB DRAM
 - 1x INTEL MEMPEK1W016GA (PCIe 3.0 x2)
 - Debian Bullseye userspace

## Results

- Plot shows `(mean_iops_r - mean_iops_c) / mean_iops_c`
- 40 samples
- Difference of means modeled with t-distribution
- P95 confidence intervals

![](rnull/null_blk-6.6.svg)

# Performance September 2023

## Setup

 - 12th Gen Intel(R) Core(TM) i5-12600
 - 32 GB DRAM
 - 1x INTEL MEMPEK1W016GA (PCIe 3.0 x2)
 - Debian Bullseye userspace

## Results

In most cases there is less than 2% difference between the Rust and C drivers.

![](./rnull/read-iops.svg)
![](./rnull/write-iops.svg)
![](./rnull/randread-iops.svg)
![](./rnull/randwrite-iops.svg)
![](./rnull/readwrite-iops.svg)
![](./rnull/randrw-iops.svg)

# Contact

Please contact Andreas Hindborg through
[Zulip](Contact.md#zulip-chat).
