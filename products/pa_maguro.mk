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
ifeq (pa_maguro,$(TARGET_PRODUCT))

# Define PA bootanimation size
PARANOID_BOOTANIMATION_NAME := XHDPI

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_xhdpi

# Build paprefs from sources
PREFS_FROM_SOURCE := true

# Include ParanoidAndroid common configuration
include vendor/pa/config/pa_common.mk

# Include missing proprietaries
PRODUCT_COPY_FILES += \
  vendor/pa/proprietary/maguro/bcm4330.hcd:system/vendor/firmware/bcm4330.hcd

# Inherit AOSP device configuration
$(call inherit-product, device/samsung/maguro/full_maguro.mk)

# Override AOSP build properties
PRODUCT_NAME := pa_maguro
PRODUCT_BRAND := Google
PRODUCT_MODEL := Galaxy Nexus
PRODUCT_MANUFACTURER := Samsung
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=yakju BUILD_FINGERPRINT="google/yakju/maguro:4.0.4/IMM76I/330937:user/release-keys" PRIVATE_BUILD_DESC="yakju-user 4.0.4 IMM76I 330937 release-keys"

GET_VENDOR_PROPS := $(shell vendor/pa/tools/getvendorprops.py $(PRODUCT_NAME))

endif

