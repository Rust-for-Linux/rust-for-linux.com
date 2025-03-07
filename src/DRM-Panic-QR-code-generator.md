# DRM Panic QR code generator

This is a simple QR code generator, to display the panic data as a QR code. It is specific to the DRM panic use case, and supports only some parts of the QR code specification.

## Why a QR code in a panic screen?

Kernel panic traces are usually displayed on the screen, but then it's hard to copy and paste them to a bug report, so that a developer can take a look, and fix the bug.

As QR code are now widespread, using that allows to easily copy and paste the panic traces in a bug report, which makes debugging much easier for both the user and the kernel developer.

The QR code has a better pixel density than text, that means you can put more debug data into a QR code, than you can see as text only on a standard monitor.

## Why Rust?

This project was written in rust, because memory safety is critical in a panic handler.

The QR code encoder is self-contained and only uses the provided memory buffer, so there is no need to add complex bindings, and it was easy to merge it in the kernel.

For this particular case, I found the Rust code to be cleaner, and easier to read than the C equivalent, even if I'm much more experienced in C.

## Availability

The code was [merged](https://git.kernel.org/linus/cb5164ac43d0fc37ac6b45cabbc4d244068289ef) into Linux kernel version v6.12-rc1. Arch Linux will enable it soon in its [kernel](https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/commit/39947637f309b0862a383733d5acf7ae55122d10).

## Side projects

An example web frontend to decode the panic data from the QR code: <https://github.com/kdj0c/panic_report>.

A few samples of a panic screen with a QR code are available here: <https://github.com/kdj0c/panic_report/issues/1>.

You can test the same code in a standalone rust app (outside the kernel): <https://gitlab.com/kdj0c/qr_panic>.

I try to keep it up-to-date with the latest Linux kernel.

## Maintenance

The main author of the QR code generator is Jocelyn Falempe <<jfalempe@redhat.com>>, with help from the Rust for Linux community.
