# Apple AGX GPU driver

As part of the [Asahi Linux](https://asahilinux.org/about/) project, the Apple
AGX GPU driver has been implemented in Rust for the Linux kernel, along with
creating DRM bindings and associated userspace pieces.

The driver lives [here](https://github.com/AsahiLinux/linux/tree/bits/210-gpu).
The current development team is:

  - [Alyssa Rosenzweig](https://social.treehouse.systems/@alyssa) is writing
    the OpenGL driver and compiler.
  - [Asahi Lina](https://vt.social/@lina) is writing the kernel driver and
    helping with OpenGL.
  - [Dougall Johnson](https://mastodon.social/@dougall) is reverse-engineering
    the instruction set with Alyssa.
  - [Ella Stanforth](https://tech.lgbt/@ella) is working on a Vulkan driver.

# References

  - [Apple GPU drivers now in Asahi Linux](https://asahilinux.org/2022/12/gpu-drivers-now-in-asahi-linux/)
  - [Tales of the M1 GPU](https://asahilinux.org/2022/11/tales-of-the-m1-gpu/)
