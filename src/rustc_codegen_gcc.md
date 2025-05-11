# `rustc_codegen_gcc`

[`rustc_codegen_gcc`](https://github.com/rust-lang/rustc_codegen_gcc) is a GCC ahead-of-time codegen for rustc, meaning that it can be loaded by the existing rustc frontend, but benefits from GCC by having more architectures supported and having access to GCC’s optimizations.

Rust for Linux can be compiled with `rustc_codegen_gcc` which allows to have a GCC-compiled Linux kernel with Rust kernel modules compiled with GCC as well.

[Blog with updates about the progress of the GCC codegen.](https://blog.antoyo.xyz/)

## Building `rustc_codegen_gcc` and the sysroot

Follow the build instructions [here](https://github.com/rust-lang/rustc_codegen_gcc#quick-start).

## Building Rust for Linux

Follow the [Rust for Linux Quick Start instructions](https://docs.kernel.org/rust/quick-start.html) with a few changes as explained below.

First, disable `MITIGATION_RETPOLINE` in `menuconfig` at: Mitigations for CPU vulnerabilities -> Avoid speculative indirect branches in kernel.

Since the GCC codegen might not work on every nightly version (that should soon be fixed now that we run some tests in the Rust CI), we're going to use [the same nightly version as the GCC codegen](https://github.com/rust-lang/rustc_codegen_gcc/blob/master/rust-toolchain) instead of using the version recommended by Rust for Linux:

```sh
rustup override set nightly-2023-10-21 # Adjust to the version used by the GCC codegen.
```

Now, you need to set some variables to build Rust for Linux with the GCC codegen (do not forget to adjust your path to `rustc_codegen_gcc`):

```sh
make -j20 KRUSTFLAGS="-Zcodegen-backend=/path/to/rustc_codegen_gcc/target/debug/librustc_codegen_gcc.so" \
    HOSTRUSTFLAGS="-Zcodegen-backend=/path/to/rustc_codegen_gcc/target/debug/librustc_codegen_gcc.so \
    --sysroot /path/to/rustc_codegen_gcc/build_sysroot/sysroot -Clto=no"
```

## CI

We have a [repo](https://github.com/Rust-for-Linux/ci-rustc_codegen_gcc) that runs some tests of Rust for Linux compiled with `rustc_codegen_gcc`.

## Troubleshooting

If that didn't build the Rust object files, run `make menuconfig` again and check if the "Rust support" is available.
It could be that you have `RUST_IS_AVAILABLE [=n]`.
In that case, run `make rustavailable` with the `KRUSTFLAGS` you used above.
That should give you the correct error, which could be one of those:

 * `libgccjit.so.0: cannot open shared object file: No such file or directory`
   - In this case, make sure you set `LD_LIBRARY_PATH` and `LIBRARY_PATH`.
 * `Source code for the 'core' standard library could not be found`
   - In this case, make sure you used a recent enough version of `rustc_codegen_gcc` (c6bc7ecd65046ee502118664f42637ca318cdfb5 or more recent should be good) that copies the source of the sysroot at the correct location.

## Contact

Please contact Antoni Boucher (antoyo) on
[Matrix](https://matrix.to/#/#rustc_codegen_gcc:matrix.org) or post a message on [Zulip](https://rust-lang.zulipchat.com/#narrow/channel/386786-rustc-codegen-gcc).
