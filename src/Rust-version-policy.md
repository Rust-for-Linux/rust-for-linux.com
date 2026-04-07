# Rust version policy

## Supported versions

The kernel documents the [minimal requirements](https://docs.kernel.org/process/changes.html) to compile it. Since v6.11, the kernel supports a minimum version of Rust. The initial minimum was Rust 1.78.0, and the next one will be Rust 1.85.0 (expected in Linux v7.1)[^stable-kernels], following Debian 13 (Trixie)'s Rust toolchain version — please see ["Minimum upgrade policy"](Rust-version-policy.md#minimum-upgrade-policy) below for details.

For the moment, we cannot guarantee newer Rust versions will always work due to the [unstable features](Unstable-features.md) in use[^rust-is-stable]. In practice, so far, it has worked with every version released since the initial minimum. Nevertheless, removing the need for the unstable features is a priority of the project.

To ameliorate that, the kernel is now being [build-tested](https://rustc-dev-guide.rust-lang.org/tests/rust-for-linux.html) in Rust's pre-merge CI. That is, every change that is attempting to land into the Rust compiler is tested against the kernel, and it is merged only if it passes. Similarly, the `bindgen` tool is also [build-testing](https://github.com/rust-lang/rust-bindgen/pull/2851) the kernel in their pre-merge CI.

Thus, with the pre-merge CIs in place, those projects hope to avoid unintentional changes to Rust and `bindgen` that break the kernel. This means that, in general, apart from intentional changes on their side (that we will need to workaround conditionally on our side), the upcoming Rust and `bindgen` versions should generally work. This applies to beta and nightly versions of Rust as well.

In addition, getting Linux to build on stable Rust was a "flagship goal" of the Rust project for [2024H2](https://rust-lang.github.io/rust-project-goals/2024h2/rfl_stable.html) and [2025H1](https://rust-lang.github.io/rust-project-goals/2025h1/rfl.html). We also had two goals for 2025H2 ([language](https://rust-lang.github.io/rust-project-goals/2025h2/Rust-for-Linux-language.html) and [compiler](https://rust-lang.github.io/rust-project-goals/2025h2/Rust-for-Linux-compiler.html)) and, currently, an ongoing [2026 roadmap](https://rust-lang.github.io/rust-project-goals/2026/roadmap-rust-for-linux.html) (and the individual project goals linked there, e.g. [compiler features](https://rust-lang.github.io/rust-project-goals/2026/rust-for-linux-compiler-features.html)).

[^stable-kernels]: Stable/LTS kernels may have different requirements. For instance, Linux 6.18.y has a minimum of Rust 1.78.0 at the time of writing.

[^rust-is-stable]: To clarify, the Rust language is stable, i.e. it promises backwards compatibility, except for those unstable features.

## Supported toolchains

The Rust versions currently supported should already be enough for kernel developers in recent distributions, such as:

  - Arch Linux.
  - Debian 13 (Trixie), Debian Testing and Debian Unstable (Sid).
  - Fedora Linux.
  - Gentoo Linux.
  - Nix.
  - openSUSE Slowroll and openSUSE Tumbleweed.
  - Ubuntu 25.10 and 26.04 LTS. In addition, 24.04 LTS using versioned packages.

In addition, we support the toolchains distributed by Rust, installed via [`rustup`](https://rust-lang.github.io/rustup/) or the [standalone installers](https://forge.rust-lang.org/infra/other-installation-methods.html#standalone-installers).

Finally, slim and fast LLVM+Rust toolchains are provided at [kernel.org](https://kernel.org/pub/tools/llvm/rust/).

Please see the [Quick Start guide](https://docs.kernel.org/rust/quick-start.html) for details.

## Minimum upgrade policy

Since early 2026, our current policy is to follow Debian Stable's Rust version as the minimum supported version.

For instance, Debian 13 (Trixie)'s Rust version is 1.85.0 at the time of writing. Thus, some months after Debian's release (to give time for developers to upgrade), it will become the Rust minimum (expected in Linux v7.1).
