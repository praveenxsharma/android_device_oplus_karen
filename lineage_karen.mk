# Copyright (C) 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from karen device
$(call inherit-product, device/oplus/karen/device.mk)

# Inherit some common LineageOS stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Boot animation resolution
TARGET_BOOT_ANIMATION_RES := 1080

# Device identifier — THIS must match TARGET_OTA_ASSERT_DEVICE in BoardConfig
PRODUCT_NAME := lineage_karen
PRODUCT_DEVICE := karen
PRODUCT_BRAND := oplus
PRODUCT_MODEL := CPH2401
PRODUCT_MANUFACTURER := oplus

PRODUCT_GMS_CLIENTID_BASE := android-oplus

BUILD_FINGERPRINT := oplus/ossi/ossi:13/TP1A.220905.001/1678873363230:user/release-keys
