# Check for target product
ifeq (pa_tf700t,$(TARGET_PRODUCT))

# Define PA bootanimation size
PARANOID_BOOTANIMATION_NAME := XHDPI

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_tf700t

# Build paprefs from sources
PREFS_FROM_SOURCE := true

# include ParanoidAndroid common configuration
include vendor/pa/config/pa_common.mk

# TF700T Packages
#PRODUCT_PACKAGES += \

# include missing proprietaries
#PRODUCT_COPY_FILES += \
#  vendor/pa/proprietary/grouper/bcm4330.hcd:system/etc/firmware/bcm4330.hcd

# Inherit CM device configuration
$(call inherit-product, device/asus/tf700t/cm.mk)

PRODUCT_NAME := pa_tf700t

GET_VENDOR_PROPS := $(shell vendor/pa/tools/getvendorprops.py $(PRODUCT_NAME))

endif

