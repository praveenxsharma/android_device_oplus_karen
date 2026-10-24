#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'hardware/mediatek',
    'hardware/oplus',
]


def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_{partition}' if partition == 'vendor' else None


lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    'vendor.mediatek.hardware.videotelephony@1.0': lib_fixup_vendor_suffix,
}


blob_fixups: blob_fixups_user_type = {
    # GNSS: compiled against ndk_platform, LOS ships ndk variant
    (
        'vendor/bin/hw/android.hardware.gnss-service.mediatek',
        'vendor/lib64/hw/android.hardware.gnss-impl-mediatek.so',
    ): blob_fixup()
        .replace_needed(
            'android.hardware.gnss-V1-ndk_platform.so',
            'android.hardware.gnss-V1-ndk.so',
        ),

    # C2 codec: needs stagefright-v33 shim, minijail_vendor -> minijail
    (
        'vendor/bin/hw/android.hardware.media.c2@1.2-mediatek',
        'vendor/bin/hw/android.hardware.media.c2@1.2-mediatek-64b',
    ): blob_fixup()
        .add_needed('libstagefright_foundation-v33.so')
        .replace_needed(
            'libavservices_minijail_vendor.so',
            'libavservices_minijail.so',
        ),

    # NVRAM + sysenv: linked against incompatible libbase ABI
    (
        'vendor/lib/libnvram.so',
        'vendor/lib/libsysenv.so',
        'vendor/lib64/libnvram.so',
        'vendor/lib64/libsysenv.so',
    ): blob_fixup()
        .add_needed('libbase_shim.so'),
}  # fmt: skip


module = ExtractUtilsModule(
    'karen',
    'oplus',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)
module.add_firmware_proprietary_file()

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
