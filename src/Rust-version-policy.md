# Rust version policy

## Supported versions

The kernel documents the [minimal requirements](https://docs.kernel.org/process/changes.html) to compile it. In the case of Rust, currently only a single version is supported (i.e. rather than a minimum):

> A particular version of the Rust toolchain is required. Newer versions may or may not work because the kernel depends on some unstable Rust features, for the moment.

The reason is that we cannot guarantee newer Rust versions will work due to the [unstable features](Unstable-features.md) in use[^rust-is-stable]. Removing the need for them is a priority in order to be able to eventually declare a minimum Rust version for the kernel.

Having said that, generally speaking, newer versions should work, as long as one patches any potential compilation errors coming from changes in unstable features.

[^rust-is-stable]: Note that the Rust language is stable, i.e. it promises backwards compatibility. See the [Unstable features](Unstable-features.md) page for details.

### Distribution toolchains

Some Linux distributions provide Rust toolchains (i.e. built by the distribution maintainers, rather than redistributing the ones from https://www.rust-lang.org). These toolchains should be fine to use, as long as they have not been modified in unexpected ways (and keeping in mind the versioning limitations).

## Update policy

### Before a minimum version can be declared

It remains to be decided how often the Rust version upgrades will land. Ideally we would track the latest Rust release, but it remains to be seen how other kernel developers feel about it.

On top of that, if the [`klint`](klint.md) support is merged and starts to be routinely used, then we will also need to be mindful of its schedule.

### After a minimum version is declared

If we follow a similar model to the GCC and LLVM support in the kernel (which is likely), then we will not track the latest Rust release (i.e. as a minimum), though how wide the window will be remains to be seen. It is possible we may start with a small window and then widen it, similar to what was originally decided for the LLVM support in the kernel.

## Submitting upgrades

Please do not submit patches to upgrade the Rust version. If you want to discuss upgrading the Rust version in the kernel, then please [contact us](Contact.md).

## Feedback

We are looking for [feedback](Contact.md) from Linux distributions, companies and other users and maintainers of downstream kernel releases.

In particular, it would be useful to know:

  - What versions/policy would work best your distribution/company.

  - If the kernel cannot satisfy exactly that (which is likely, given the current constraints), whether you would prefer to maintain a given compiler version for a while or to backport support from a newer version from mainline.
