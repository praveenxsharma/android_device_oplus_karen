/*
 * Copyright (C) 2024 The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 *
 * libbase shim for libnvram and libsysenv
 * These vendor blobs reference libbase symbols with a slightly
 * different ABI than what AOSP ships. This shim re-exports the
 * needed symbols from the AOSP libbase.
 */

// Empty — the shared_libs dependency on libbase in Android.bp
// is sufficient to pull in all needed symbols at link time.
// The shim just needs to exist as a loadable .so that depends on libbase.
