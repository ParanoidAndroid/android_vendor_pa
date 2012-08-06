# Check for target product
ifeq (pa_i9300,$(TARGET_PRODUCT))

# Define PA bootanimation size
PARANOID_BOOTANIMATION_NAME := XHDPI

# include ParanoidAndroid common configuration
include vendor/pa/config/pa_common.mk

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := $(TARGET_PRODUCT)

# Inherit CM9 device configuration
$(call inherit-product, device/samsung/i9300/cm.mk)

PRODUCT_NAME := pa_i9300

GET_VENDOR_PROPS := $(shell vendor/pa/tools/getvendorprops.py $(PRODUCT_NAME))

endif
