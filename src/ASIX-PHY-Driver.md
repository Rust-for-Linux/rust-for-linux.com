# ASIX PHY Driver

The Rust ASIX driver is for ASIX Electronics' Ethernet PHY (Physical Layer) devices. This driver facilitates communication between the operating system and the ASIX AX887xx chips, ensuring proper network functionality.

The driver is the first Rust driver merged into the Linux kernel. It was [merged](https://git.kernel.org/linus/cbe0e415089636170aa6eb540ca4af5dc9842a60) into Linux kernel version v6.8-rc1 along with a PHY abstraction that provides safe APIs for PHY drivers.

The ASIX driver is [a Rust reference driver](Rust-reference-drivers.md). It serves as a guide for developers. ASIX PHY chips are widely used in affordable 10/100M USB Ethernet adapters from various vendors.
