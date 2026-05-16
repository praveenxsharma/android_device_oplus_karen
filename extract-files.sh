#!/bin/bash
##
## SPDX-FileCopyrightText: 2024 The LineageOS Project
## SPDX-License-Identifier: Apache-2.0
##

set -e

DEVICE=karen
VENDOR=oplus

MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

# Load extract_utils
 HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
 if [ ! -f "${HELPER}" ]; then
     echo "Unable to find helper script at ${HELPER}"
         exit 1
         fi
         source "${HELPER}"

         # Initialize extract_utils for our device
         setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false false

         # Extract from dump or device
         extract "${MY_DIR}/proprietary-files.txt" "${@}"

         # Blob fixups — applied after extraction
         BLOB_ROOT="${ANDROID_ROOT}/vendor/${VENDOR}/${DEVICE}/proprietary"

         # Fix 1: GNSS service — replace ndk_platform with ndk
         sed -i \
             's|android.hardware.gnss-V1-ndk_platform.so|android.hardware.gnss-V1-ndk.so|g' \
                 "${BLOB_ROOT}/vendor/bin/hw/android.hardware.gnss-service.mediatek" 2>/dev/null || true

                 # Fix 2: C2 codec — replace minijail_vendor with minijail
                 sed -i \
                     's|libavservices_minijail_vendor.so|libavservices_minijail.so\x00\x00\x00\x00\x00\x00\x00|g' \
                         "${BLOB_ROOT}/vendor/bin/hw/android.hardware.media.c2@1.2-mediatek-64b" 2>/dev/null || true

                         echo "Extraction complete."

			 # Fix 3: NVRAM + sysenv — add libbase_shim dependency
			  patchelf --add-needed libbase_shim.so \
			      "${BLOB_ROOT}/vendor/lib64/libnvram.so" 2>/dev/null || true
			      patchelf --add-needed libbase_shim.so \
			          "${BLOB_ROOT}/vendor/lib64/libsysenv.so" 2>/dev/null || true
			 
			          # Fix 4: C2 codec — add stagefright-v33 dependency  
			          patchelf --add-needed libstagefright_foundation-v33.so \
			              "${BLOB_ROOT}/vendor/bin/hw/android.hardware.media.c2@1.2-mediatek-64b" 2>/dev/null || true
			 
			              # Fix 5: sensors subhal + mnld — replace sensorndkbridge
			              patchelf --replace-needed libsensorndkbridge.so \
			                  android.hardware.sensors@1.0-convert-shared.so \
			                      "${BLOB_ROOT}/vendor/lib64/hw/android.hardware.sensors@2.X-subhal-mediatek.so" 2>/dev/null || true
			                      patchelf --replace-needed libsensorndkbridge.so \
			                          android.hardware.sensors@1.0-convert-shared.so \
			                              "${BLOB_ROOT}/vendor/bin/mnld" 2>/dev/null || true
