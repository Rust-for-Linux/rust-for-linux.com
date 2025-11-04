# Rust version policy

## Supported versions

The kernel documents the [minimal requirements](https://docs.kernel.org/process/changes.html) to compile it. Since v6.11, the kernel supports a minimum version of Rust, starting with Rust 1.78.0.

For the moment, we cannot guarantee newer Rust versions will always work due to the [unstable features](Unstable-features.md) in use[^rust-is-stable]. Removing the need for them is a priority of the project.

To ameliorate that, the kernel is now being [build-tested](https://rustc-dev-guide.rust-lang.org/tests/rust-for-linux.html) in Rust's pre-merge CI. That is, every change that is attempting to land into the Rust compiler is tested against the kernel, and it is merged only if it passes. Similarly, the `bindgen` tool is also [build-testing](https://github.com/rust-lang/rust-bindgen/pull/2851) the kernel in their pre-merge CI.

Thus, with the pre-merge CIs in place, those projects hope to avoid unintentional changes to Rust and `bindgen` that break the kernel. This means that, in general, apart from intentional changes on their side (that we will need to workaround conditionally on our side), the upcoming Rust and `bindgen` versions should generally work. This applies to beta and nightly versions of Rust as well.

In addition, one of the three [flagship goals for 2024H2](https://rust-lang.github.io/rust-project-goals/2024h2/index.html#flagship-goals) of the Rust project was getting the kernel into stable Rust (at least solving the main blockers). A continuation of that work is being proposed as a new [flagship goal for 2025H1](https://rust-lang.github.io/rust-project-goals/2025h1/goals.html#flagship-goals).

[^rust-is-stable]: To clarify, the Rust language is stable, i.e. it promises backwards compatibility, except for those unstable features.

## Supported toolchains

The Rust versions currently supported should already be enough for kernel developers in distributions that provide recent Rust compilers routinely, such as:

  - Arch Linux.
  - Debian 13 (Trixie), Debian Testing and Debian Unstable (Sid).
  - Fedora Linux.
  - Gentoo Linux.
  - Nix (unstable).
  - openSUSE Slowroll and Tumbleweed.
  - Ubuntu LTS (20.04, 22.04, 24.04) and non-LTS (interim).

In addition, we support the toolchains distributed by Rust, installed via [`rustup`](https://rust-lang.github.io/rustup/) or the [standalone installers](https://forge.rust-lang.org/infra/other-installation-methods.html#standalone-installers).

Finally, slim and fast LLVM+Rust toolchains are provided at [kernel.org](https://kernel.org/pub/tools/llvm/rust/).

Please see the [Quick Start guide](https://docs.kernel.org/rust/quick-start.html) for details.

## Minimum upgrade policy

We will start with a small window of supported Rust releases and then widen it progressively. However, we are still determining how often we will move the minimum to newer Rust versions, since we will have to balance different factors. For instance, we are [following](https://alioth-lists.debian.net/pipermail/pkg-rust-maintainers/2024-July/044870.html) the evolution of which Rust version the upcoming Debian Stable distribution (i.e. Trixie) will package.
