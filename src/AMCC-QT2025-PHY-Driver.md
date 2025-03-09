# AMCC QT2025 PHY Driver

The Rust AMCC QT2025 driver is for the Applied Micro Circuits Corporation (AMCC) QT2025 PHY (Physical Layer) device. This driver facilitates communication between the operating system and the QT2025 hardware, ensuring proper network functionality.

The driver was [merged](https://git.kernel.org/linus/fd3eaad826daf4774835599e264b216a30129c32) into Linux kernel version v6.12-rc1 along with the improvements to the PHY abstraction that provides safe APIs for PHY drivers.

Both the Rust QT2025 driver and the MAC driver for Tehuti Networks' TN40xx chips have been tested using the Edimax EN-9320SFP+ 10G network adapter.
