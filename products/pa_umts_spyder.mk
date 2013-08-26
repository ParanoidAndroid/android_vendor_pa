# Copyright (C) 2012 ParanoidAndroid Project
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

# Check for target product
ifeq (pa_umts_spyder,$(TARGET_PRODUCT))

# Define PA bootanimation size
PARANOID_BOOTANIMATION_NAME := XHDPI

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_edison

# Build paprefs from sources
PREFS_FROM_SOURCE := false

# include ParanoidAndroid common configuration
include vendor/pa/config/pa_common.mk

# Inherit AOSP device configuration
$(call inherit-product, device/motorola/umts_spyder/full_umts_spyder.mk)

# Product Package Extras
include vendor/pa/packages/umts_spyder.mk

# Include CM extras
EXTRA_CM_PACKAGES := true

# Override AOSP build properties
PRODUCT_NAME := pa_umts_spyder
PRODUCT_BRAND := RTGB
PRODUCT_DEVICE := umts_spyder
PRODUCT_MODEL := XT910
PRODUCT_MANUFACTURER := MOTO
PRODUCT_RELEASE_NAME := MOTOROLA RAZR
PRODUCT_SFX := umts

UTC_DATE := $(shell date +%s)
DATE := $(shell date +%Y%m%d)

PRODUCT_BUILD_PROP_OVERRIDES += \
   PRODUCT_NAME=${PRODUCT_DEVICE}_${PRODUCT_SFX} \
   BUILD_NUMBER=${DATE} \
   TARGET_DEVICE=${PRODUCT_DEVICE} \
   BUILD_FINGERPRINT=${PRODUCT_BRAND}/${PRODUCT_DEVICE}_${PRODUCT_SFX}/${PRODUCT_DEVICE_PREFIX}_${PRODUCT_DEVICE}:${PLATFORM_VERSION}/${BUILD_ID}/${DATE}:user/release-keys \
   PRIVATE_BUILD_DESC="${PRODUCT_DEVICE_PREFIX}_${PRODUCT_DEVICE}-user ${PLATFORM_VERSION} ${BUILD_ID} ${DATE} release-keys" \
   PRODUCT_BRAND=${PRODUCT_BRAND} \
   BUILD_UTC_DATE= \
   PRODUCT_DEFAULT_LANGUAGE=en \
   PRODUCT_DEFAULT_REGION=US \

# Include ParanoidAndroid repos configuration
include vendor/pa/config/pa_addons.mk

endif
