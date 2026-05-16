#!/bin/bash
#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=karen
VENDOR=oplus

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
  echo "Unable to find helper script at ${HELPER}"
  exit 1
fi

source "${HELPER}"

# Initialize extract_utils
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false false

extract "${MY_DIR}/proprietary-files.txt" "$@"
