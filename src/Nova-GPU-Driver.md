# Nova GPU Driver

Nova is a driver for GSP-based Nvidia GPUs that is currently under development
and is being written in Rust.

Currently, the objective is to upstream Rust abstractions for the relevant
subsystems as a prerequisite for the actual driver. Hence, the first mainline
version of Nova will be a stub driver which helps establishing the necessary
infrastructure in other subsystems (notably PCI and DRM).

## Contact

To contact the team and / or participate in development, please use the mailing
list: nouveau@lists.freedesktop.org


## Resources

- [Official Source Tree](https://gitlab.freedesktop.org/drm/nova)
- [Announcement E-Mail](https://lore.kernel.org/dri-devel/Zfsj0_tb-0-tNrJy@cassiopeiae/)

In the source tree, the driver lives in `drivers/gpu/drm/nova`.


## Status

Currently, Nova is just a stub driver intended to lift the bindings necessary
for a real GPU driver into the (mainline) kernel.

Currently, those efforts are mostly focused on getting bindings for PCI, DRM
and the Device (driver) model upstream.

It can be expected that, as the driver continues to grow, various other abstractions
will be needed.


## Utilized Common Rust Infrastructure

Nova depends on the Rust for Linux `staging/*` [branches](Branches.md).


## Contributing

As with every real open source program, help and participation is highly welcome!

As the driver is very young, however, it is currently difficult to assign tasks
to people. Many things still have to settle until a steadily paced workflow
produces atomic work topics a new one can work on.

If you really want to jump in immediately regardless, here are a few things you
can consider:

- Most work to do right now is with more bindings for Rust. Notably, this
  includes the device driver model, DRM and PCI. If you have expertise there,
  have a look at the existing code in the [topic branches](Branches.md) and see
  if there's something you can add or improve.
- Feel free to go over Nova's code base and make suggestions or send patches,
  for example for improved comments, grammar fixes, improving code readability
  etc.


Happy hacking!
