# Tyr GPU Driver

## What is Tyr?

Tyr is a new Rust-based DRM driver for CSF-based Arm Mali GPUs. It is a Rust
reimplementation of Panthor — a driver written in C for the same hardware —
developed jointly by Collabora, Arm, and Google engineers.

Tyr aims to eventually implement the same userspace API offered by Panthor for
compatibility reasons, so that it can be used as a drop-in replacement by the
[PanVK](https://gitlab.freedesktop.org/mesa/mesa/-/tree/main/src/panfrost/vulkan?ref_type=heads) Vulkan driver.

## Where is Tyr developed?

Tyr is developed both upstream and downstream.

### Upstream

The initial skeleton of the Tyr driver is now [upstream](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/tyr). Submissions against
the upstream Tyr driver should go to the [`dri-devel`](https://lore.kernel.org/dri-devel/)
and [`rust-for-linux`](https://lore.kernel.org/rust-for-linux/) mailing lists.

Tyr commits should usually apply cleanly to [`drm-rust-next`](https://gitlab.freedesktop.org/drm/rust/kernel.git).

### Downstream

Patches that are close to going upstream are collected for convenience in the
[`tyr-for-upstream`](https://gitlab.freedesktop.org/panfrost/linux/-/tree/tyr-for-upstream) branch.

A work-in-progress implementation of the full Tyr driver is also available in the
[`tyr-dev`](https://gitlab.freedesktop.org/panfrost/linux/-/tree/tyr-dev) branch.


## What is the current status of the driver?

The current upstream driver can probe and register an Arm Mali Valhall CSF GPU,
currently tested on RK3588 systems. During probe it enables the required clocks
and regulators, maps the GPU registers, issues a soft reset, powers on the L2
block, reads the GPU identification and feature registers, and exposes that
information to userspace through `DRM_IOCTL_PANTHOR_DEV_QUERY`.

The next major milestone is the Microcontroller Unit (MCU) firmware bring-up.
Until that is in place, the upstream driver is limited to device probing and
basic GPU information queries.

## Can I try it out?

Anyone with an RK3588 SoC can test Tyr, but the driver is not capable of
replacing Panthor yet. A good candidate device is Radxa's
[ROCK 5B](https://radxa.com/products/rock5/5b/) Single Board Computer.

A good starting point is to experiment with the Panthor [IGT
tests](https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/tree/master/tests/panthor).

If you would like to contribute, check our [issue
board](https://gitlab.freedesktop.org/panfrost/linux/-/issues/?label_name%5B%5D=tyr)
to look for open tasks.

Happy hacking!
