# Android Binder Driver

This project is an effort to rewrite Android's Binder kernel driver in Rust.

## Motivation

Binder is one of the most security and performance critical components of Android.
Android isolates apps from each other and the system by assigning each app a
unique user ID (UID).  This is called "application sandboxing", and is a fundamental
tenet of the [Android Platform Security Model](https://arxiv.org/abs/1904.05572).

The majority of inter-process communication (IPC) on Android goes through Binder.
Thus, memory unsafety vulnerabilities are especially critical when they happen in the
Binder driver.

## Maintenance

The Rust driver was originally authored by Wedson Almeida Filho, and is now maintained
by Alice Ryhl. The ongoing work will be part of the
[Android Open Source Project](https://source.android.com/).
