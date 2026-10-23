# Copyright (C) 2024 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# karen ships the stock preloader inside the OTA package so it stays
# available for rescue, but it is NEVER flashed automatically: karen is
# virtual A/B and the bootloader chain is not part of the OTA.
#
# Based on the op6893 releasetools preloader shipping work:
# https://github.com/mt6893-development/android_device_oplus_op6893/commit/8b7634e6105cf4dae5ebade9bcbd493d5649ef89
#

import os

import common


def _ShipPreloader(info):
    preloader = os.path.join(
        os.path.dirname(__file__), "prebuilt", "preloader.img")
    if not os.path.exists(preloader):
        return
    with open(preloader, "rb") as f:
        data = f.read()
    info.script.Print("Shipping stock preloader for rescue purposes...")
    common.ZipWriteStr(info.output_zip, "preloader.img", data)


def FullOTA_InstallEnd(info):
    _ShipPreloader(info)


def IncrementalOTA_InstallEnd(info):
    _ShipPreloader(info)
