# Android `ashmem`

[`ashmem`](https://android.googlesource.com/kernel/common/+/refs/heads/android16-6.12/drivers/staging/android/ashmem_rust.rs) (Anonymous Shared Memory Subsystem for Android) is a new shared memory allocator, similar to POSIX SHM but with different behavior and sporting a simpler file-based API.

It is, in theory, a good memory allocator for low-memory devices, because it can discard shared memory units when under memory pressure.
