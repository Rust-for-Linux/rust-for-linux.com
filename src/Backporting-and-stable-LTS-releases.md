# Backporting and stable/LTS releases

The [_stable_ and _longterm_ (LTS) kernel releases](https://www.kernel.org/category/releases.html) only receive fixes, and thus [do not accept new features](https://docs.kernel.org/process/stable-kernel-rules.html). Therefore, it is not possible to backport Rust support into those kernel releases. Moreover, there is a significant cost in maintaining a stable branch.

Having said that, we are aware that there is growing interest in backported Rust support for, at least, 5.15 and 6.1. There are several questions around the possibility of supporting an stable/LTS release on Rust for Linux's side:

  - Whether the support is best-effort or intended to be used in production, and the security and scheduling implications.

  - Whether all new abstractions, drivers and overall features appearing in mainline are backported, and whether those that require extra backports on the C side to support them should be included.

  - Whether the Rust version policy would be different than the one in mainline, e.g. whether the version would be fixed.

  - Whether to provide it as a rebasing branch (i.e. as a set of patches) on top of the stable/LTS ones or as an actual stable branch.

If your company, organization or team would be interested in such releases with backported Rust support, then please [contact us](Contact.md).
