# Copyright (C) 2017-2026 The Android Open Source Project
# SPDX-License-Identifier: Apache-2.0

PRODUCT_RELEASE_NAME := courbet

$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, vendor/twrp/config/common.mk)
$(call inherit-product, device/xiaomi/courbet/device.mk)

PRODUCT_DEVICE := courbet
PRODUCT_SHIPPING_API_LEVEL := 30
PRODUCT_NAME := twrp_courbet
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := M2101K9AG
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="courbet_global-user 13 RKQ1.210614.002 V14.0.4.0.TKQMIXM release-keys"

BUILD_FINGERPRINT := Xiaomi/courbet_global/courbet:13/RKQ1.210614.002/V14.0.4.0.TKQMIXM:user/release-keys