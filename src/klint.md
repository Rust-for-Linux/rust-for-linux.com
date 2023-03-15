# `klint`

[`klint`](https://github.com/Rust-for-Linux/klint) is a tool that allows to introduce extra static analysis passes ("lints") in Rust kernel code, leveraging the Rust compiler as a library. One of the first lints available [validates that Rust code follows the kernel locking rules](https://www.memorysafety.org/blog/gary-guo-klint-rust-tools/) by tracking the preemption count at compile-time.

The main developer and maintainer is Gary Guo.
