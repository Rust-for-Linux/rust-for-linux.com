# Contributing

## The kernel development process

The Rust support is part of the Linux kernel, and thus contributing works the same way as for the latter. That implies, among other things:

  - A patch-based workflow is used.

  - Reviews take place in the different mailing lists of the kernel.

  - Contributions are signed under the [Developer's Certificate of Origin](https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1).

To learn more about the kernel development process, please read the documentation under [`Documentation/process`](https://docs.kernel.org/process/index.html). In particular, please make sure to read [`submitting-patches.rst`](https://docs.kernel.org/process/submitting-patches.html).

In addition, it may be a good idea to contribute a small cleanup or fix somewhere in the kernel (not necessarily to Rust code), in order to get accustomed to the patch-based workflow. From time to time we add ["good first issues"](https://github.com/Rust-for-Linux/linux/contribute) to our GitHub issue tracker for that purpose.

## Ways to contribute

There are many ways to contribute to the Rust support in the kernel:

  - Submitting changes, of course, whether it is new code or improvements to existing code. Please see the details below on this option.

  - Reviewing patches, especially if you have experience with unsafe Rust and have an eye to spot unsoundness issues or with Rust API design in general. Reviewers can get credited within commits messages via the `Reviewed-by` tag.

  - Testing patches. Like reviewing, running meaningful testing increases the confidence that the patch is OK. Testers can get credited within commits messages via the `Tested-by` tag.

  - Reporting issues you find. Reporters can get credited within commits messages via the `Reported-by` tag.

  - Suggesting improvements. Good ideas that end up being implemented can get credited within commit messages via the `Suggested-by` tag.

  - Helping others on Zulip. For instance, getting them started with the Rust support in the kernel.

## The Rust subsystem

The Rust subsystem takes care of the core Rust abstractions as well as the general infrastructure for Rust in the kernel. It is a bit special in that it potentially intersects with every other subsystem in the kernel, especially in the beginning of the Rust support in the kernel.

For this reason, early on, there are a few extra notes to have in mind when contributing Rust code to the kernel.

### Submitting changes to existing code

All patches containing Rust code should be sent to both the maintainers/reviewers/mailing lists of the relevant kernel subsystem they touch as well as the Rust one.

This applies even if the files that the patch modifies are all under `rust/` (e.g. currently all abstractions live under `rust/`, but the plan is to change this in the future as Rust grows in the kernel) and the files are referenced by the `MAINTAINERS` entry of the relevant subsystem. Scripts like `scripts/get_maintainers.pl` may not provide the complete list.

The goal with this procedure is that everybody interested in Rust can follow what is going on with Rust in the entire kernel in the early stages, to avoid duplicate work, and to make it easier for everybody to coordinate.

For instance, if a patch modifies `rust/kernel/time.rs`, then the patch should be sent to both "TIMEKEEPING" and "RUST".

Ideally, the maintainers of the particular subsystem will take the changes through their tree, instead of going through the Rust one.

Please make sure your code is properly documented, that the code compiles warning-free under `CLIPPY=1`, that the code documentation tests pass and that the code is formatted.

### Submitting new abstractions and modules

For new abstractions and modules, and especially for those that require new kernel subsystems/maintainers to be involved, please follow the approach outlined here.

  - Kernel maintainers and developers interested in using Rust should take the lead in developing missing abstractions/modules for the subsystems they need.

  - Part of the work may be already done or in the process of being upstreamed, thus please first check the [mailing list archive](https://lore.kernel.org/rust-for-linux/) as well as the [PRs submitted to GitHub](https://github.com/Rust-for-Linux/linux/pulls). It is also a good idea to ask on our [Zulip chat](https://rust-for-linux.zulipchat.com).

  - As early as possible, please get in touch with the maintainers of the relevant subsystem in order to make them aware of the work you are doing or planning to do. That way, they can give you input and feedback on the process. Please feel free to Cc the Rust maintainers too.

  - When you are getting closer to patch submission, please consider sending an RFC series first, especially if it is a major contribution, or if it is a long patch series, or if you require a lot of prerequisite patches (e.g. for abstractions of other subsystems) that are not yet upstreamed.

    The RFC can be based on top of a branch placed somewhere else that contains the prerequisite patches, so that the RFC patches themselves do not cover those, and therefore is focused on the parts that the maintainers will eventually review.

    This way, you can get early design feedback before the actual patch submission later, and the discussion is focused on the given subsystem (rather than the prerequisites).

  - In general, the kernel does not allow to integrate code without users, but exceptions can potentially be made for Rust code to simplify the upstreaming process early on. That is, upstreaming some dependencies first so that it is easier to upstream expected in-tree users later on. However, note that this is not meant to be a way to justify upstreaming APIs that do not have agreed upon in-tree users. In particular, [out-of-tree modules](Out-of-tree-modules.md) do not constitute a user in this context.

    Please contact the Rust maintainers for help, especially if you find yourself with a lot of dependencies or patches for unrelated subsystems.

## Submitting patches

If you are using a CLI tool like [`git-send-email`](https://git-scm.com/docs/git-send-email) or [`b4`](https://b4.docs.kernel.org), then you may find the following commands useful for generating the options needed for submitting patches to the Rust subsystem:

```sh
awk '/^RUST$/,/^$/' MAINTAINERS | grep '^M:'    | cut -f2- | xargs -IP echo --to \'P\' \\
awk '/^RUST$/,/^$/' MAINTAINERS | grep '^[RL]:' | cut -f2- | xargs -IP echo --cc \'P\' \\
```

This list includes the maintainers (`M:`), reviewers (`R:`) and mailing list (`L:`) of the "RUST" subsystem in the `MAINTAINERS` file.

However, please keep in mind that this does not cover additional subsystems that you may need to submit your patches to, as explained in the other sections.
