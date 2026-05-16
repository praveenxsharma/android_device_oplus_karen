/*
 * Copyright (C) 2024 The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 *
 * android.hardware.sensors@1.0-convert-shared shim
 * vendor/bin/mnld and the sensors subhal link against libsensorndkbridge
 * for sensor type conversion. LineageOS uses the @1.0-convert approach.
 * This shim bridges the two.
 */

// Empty — the shared_libs in Android.bp pull in the correct
// sensors@1.0 and hidl symbols that mnld and the subhal need.
