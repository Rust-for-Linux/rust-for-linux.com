# PuzzleFS filesystem driver

[PuzzleFS](https://github.com/project-machine/puzzlefs) is a container
filesystem designed to address the limitations of the existing OCI format. The
main goals of the project are reduced duplication, reproducible image builds,
direct mounting support and memory safety guarantees, some inspired by the
[OCIv2 design document](https://hackmd.io/@cyphar/ociv2-brainstorm).

Reduced duplication is achieved using the content defined chunking algorithm
FastCDC. This implementation allows chunks to be shared among layers. Building
a new layer starting from an existing one allows reusing most of the chunks.

Another goal of the project is reproducible image builds, which is achieved by
defining a canonical representation of the image format. Direct mounting
support is a key feature of puzzlefs and, together with fs-verity, it provides
data integrity.

Lastly, memory safety is critical to puzzlefs, leading to the decision to
implement it in Rust. Another goal is to share the same code between user space
and kernel space in order to provide one secure implementation.

## Resources

  - [PuzzleFS main repository](https://github.com/project-machine/puzzlefs)
  - [PuzzleFS kernel branch](https://github.com/ariel-miculas/linux/tree/puzzlefs)
  - [Issue tracking the development of the kernel driver](https://github.com/project-machine/puzzlefs/issues/78)
  - [Talk at Open Source Summit Europe](https://osseu2023.sched.com/event/b98e711a56261b4a892b5fdcdc29ca73)
  - [Kangrejos slides](https://kangrejos.com/2023/PuzzleFS.pdf)
  - [LWN article](https://lwn.net/Articles/945320/)

## Maintenance

The PuzzleFS driver is maintained by Ariel Miculas. Contact him at
[amiculas@cisco.com](mailto:amiculas@cisco.com) or through
[Zulip](Contact.md#zulip-chat).
