# Out-of-tree modules

The Linux kernel supports [building out-of-tree modules](https://docs.kernel.org/kbuild/modules.html). Both C and Rust modules can be developed as out-of-tree ones, and we provide a [basic template](https://github.com/Rust-for-Linux/rust-out-of-tree-module) for an out-of-tree Linux kernel module written in Rust.

However, please note that the Rust for Linux project is part of the kernel and has always focused its efforts towards getting code into the mainline kernel.

In particular, this means that Rust [internal APIs can be changed at any time](https://docs.kernel.org/process/4.Coding.html#internal-api-changes), just like C ones, when the need arises. Similarly, code present at any point in our different [branches](Branches.md) is not intended to form a stable base for out-of-tree development.

In addition, patches submitted to the mailing list should generally focus on in-tree development efforts. In particular, Rust abstractions submitted upstream require in-tree users. Abstractions intended for out-of-tree users cannot be merged. Even if those abstractions may be obviously useful for future in-tree users, there needs to be an agreed upon in-tree user.

For these reasons and others, please consider [submitting](Contributing.md) your use cases upstream — see [the importance of getting code into the mainline](https://docs.kernel.org/process/1.Intro.html#the-importance-of-getting-code-into-the-mainline).

Having said that, we understand that some module development is done out-of-tree and may not be possible to upstream. Even in those cases, if your company, organization or team has a use case for Rust, please [contact us](Contact.md), since it is important to highlight those use cases early on in order to showcase the [interest from industry and academia](Industry-and-academia-support.md) in Rust.
