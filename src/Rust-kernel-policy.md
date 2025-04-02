# Rust kernel policy

There has been a fair amount of confusion about what the kernel policies around Rust are, who maintains what and so on.

This document tries to clarify some of these points with what, to the best of our knowledge, is the current status.

Like most things in the kernel, these points are not hard rules and can change over time depending on the situation and what key maintainers and the kernel community discuss.


## How is Rust introduced in a subsystem?

Like for many other things in the kernel, it is up to each subsystem how they want to deal with Rust.

The goal has always been to get maintainers involved progressively, because the effort does not scale otherwise.

Therefore, different subsystems have taken different approaches so far:

  - Some subsystems prefer to actively drive the Rust effort themselves, taking patches, fixing issues, etc. This may allow them the chance to learn Rust in the process.

  - Some subsystems prefer to get a new co-maintainer, sub-maintainer, reviewer, etc. to split the workload, letting them take care of the Rust side. Some may want to do so in their existing `MAINTAINERS` entry; others may prefer a new entry dedicated to that. Some may want to use the same trees to land the patches. Some may want PRs from their Rust sub-maintainer. And so on and so forth.

  - Some subsystems may decide they do not want to have Rust code for the time being, typically for bandwidth reasons. This is fine and expected.

Now, in the Kernel Maintainers Summit 2022, we asked for flexibility when the time comes that a major user of Rust in the kernel requires key APIs for which the maintainer may not be able to maintain Rust abstractions for it. This is the needed counterpart to the ability of maintainers to decide whether they want to allow Rust or not.


## Do kernel maintainers support Rust in the kernel?

Yes, there are key kernel maintainers that support Rust in the kernel.

Please see the quotes given by kernel maintainers for the [FOSDEM 2025 Rust for Linux keynote](https://fosdem.org/2025/events/attachments/fosdem-2025-6507-rust-for-linux/slides/237976/2025-02-0_iwSaMYM.pdf), slides 45-85.


## Who maintains Rust code in the kernel?

The usual kernel policy applies. That is, whoever is the listed maintainer.

The "RUST" subsystem maintains certain core facilities as well as some APIs that do not have other maintainers. However, it does not maintain all the Rust code in the kernel — it would not scale.

Nevertheless, the team can be approached for help if needed — indeed, the intention has always been to build a mixed team of people that could help across the kernel to bootstrap Rust.

Eventually, the "RUST" subsystem could also act as "fallback maintainers" for Rust code too, similar to how akpm serves as a last resort maintainer.


## Who is responsible if a C change breaks a build with Rust enabled?

The usual kernel policy applies. So, by default, changes should not be introduced if they are known to break the build, including Rust.

However, exceptionally, for Rust, a subsystem may allow to temporarily break Rust code. The intention is to facilitate friendly adoption of Rust in a subsystem without introducing a burden to existing maintainers who may be working on urgent fixes for the C side. The breakage should nevertheless be fixed as soon as possible, ideally before the breakage reaches Linus.

For instance, this approach was chosen by the block layer — they called it "stage 1" in their [Rust integration plan](https://lore.kernel.org/all/593a98c9-baaa-496b-a9a7-c886463722e1@kernel.dk/).

We believe this approach is reasonable as long as the kernel does not have way too many subsystems doing that (because otherwise it would be very hard to build e.g. linux-next).


## Should maintainers treat Rust code up to the same standards?

Ideally, and eventually, yes. However, when they are starting out, not necessarily.

The intention is that maintainers are not pressured to reject Rust, even if they wanted to try it, just because they may feel they will not be able to provide timely fixes and so on the same way they do for C.

Thus, depending on the subsystem, Rust may be seen as a new thing, and new things can break. In fact, ideally it should be fun for maintainers to try Rust.


## Didn't you promise Rust wouldn't be extra work for maintainers?

No, we did not. Since the very beginning, we acknowledged the costs and risks a second language introduces. However, we believe the advantages of introducing Rust in the Linux kernel outweigh those costs.

Please see the [original RFC](https://lore.kernel.org/lkml/20210414184604.23473-1-ojeda@kernel.org/).


## Years have passed, have you reevaluated the tradeoffs mentioned in the original RFC?

As years have passed, the advantages mentioned in the RFC have become more evident, and part of the initial costs have already been paid.

For instance, within the kernel, successful complex Rust drivers have been written and improvements to the C side were implemented. Outside the kernel, there is nowadays increased industry pressure to move to memory safe languages than when we started years ago.

On the costs side, a lot of the required setup work within the kernel is in place, most Rust language features we used were stabilized, Rust compiler features were implemented, other projects improved their support for Rust as well (e.g. `bindgen`, Coccinelle for Rust, `pahole`, GCC, `rustc_codegen_gcc`...), and so on.


## Are duplicated C/Rust drivers allowed?

The usual kernel policy applies. So, by default, no.

However, subsystems may decide to allow it, temporarily, to get Rust bootstrapped — please see [Rust reference drivers](Rust-reference-drivers.md).


## Is Rust for Linux driven by the "Rust community"?

No, the people involved around Rust for Linux come from different backgrounds and organizations. Some are kernel maintainers, some are Rust experts. Some are hobbyists, some are employees at large corporations.

In particular, it is not an effort driven by the Rust Project nor the Rust Foundation. In fact, Rust for Linux was founded by a Linux kernel maintainer as a hobby.


## Are companies involved in Rust in the kernel?

Yes, at the time of writing, there are at least 6+ FTEs publicly working on Rust for Linux or its users across several major companies. Privately, there are more.

Please see our [Industry and academia support](Industry-and-academia-support.md) page as well.
