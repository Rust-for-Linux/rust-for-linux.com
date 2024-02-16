# Rust reference drivers

Some kernel subsystems maintainers are open to the idea of experimenting with Rust, but they may want to start simple with a driver they are familiar with. But such a driver would violate the "no duplicate drivers" rule.

Similarly, external people have expressed an interest in writing Rust drivers, but given the required abstractions are not there, they may decide to wait. But if nobody writes a first use case, the abstractions cannot be merged without breaking the "no code without an
expected in-tree user" rule.

[Rust reference drivers](https://lore.kernel.org/all/CANiq72=99VFE=Ve5MNM9ZuSe9M-JSH1evk6pABNSEnNjK7aXYA@mail.gmail.com/) are a solution to these deadlocks: they are drivers that subsystem maintainers are allowed to introduce in their subsystem without dropping the existing C driver. This allows maintainers:

  1. To bootstrap abstractions for new drivers, i.e. not the "duplicate"/"rewritten" one, but future new drivers that would use those abstractions; while avoiding breaking the "no dead code" rule.

  2. To serve as a reference for existing C maintainers on how such drivers would look like in Rust, as "live" documentation, e.g. like how [LWN featured a 1:1 comparison](https://lwn.net/Articles/863459/) between a C and Rust driver. And it has to be buildable at all times.

  3. To use all the in-tree kernel infrastructure and to prepare their subsystem for Rust over time, e.g. setting up tests and CI.

  4. To learn over time, especially for subsystems that have several maintainers where not everybody may have time for it at a given moment. Reading Rust patches from time to time for APIs one is familiar with can help a lot.

  5. And, most importantly, to evaluate if the effort is worth it for their subsystem. For instance, maintainers may ask themselves:

     - "How much can we write in safe code?"

     - "How many issues has the reference driver had over time vs. the C one? Did Rust help prevent some?"

     - "How hard is it to maintain the Rust side? Do we have enough resources in our subsystem?"

     - etc.

A Rust reference driver does not necessarily need to be considered a real driver, e.g. it could be behind `EXPERT`, be tagged `(EXPERIMENTAL)`, staging...

The first driver that took advantage of this framework was [`drivers/net/phy/ax88796b_rust.rs`](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/phy/ax88796b_rust.rs?h=v6.8-rc1), merged in v6.8:

```kconfig
config AX88796B_RUST_PHY
	bool "Rust reference driver for Asix PHYs"
	depends on RUST_PHYLIB_ABSTRACTIONS && AX88796B_PHY
	help
	  Uses the Rust reference driver for Asix PHYs (ax88796b_rust.ko).
	  The features are equivalent. It supports the Asix Electronics PHY
	  found in the X-Surf 100 AX88796B package.
```
