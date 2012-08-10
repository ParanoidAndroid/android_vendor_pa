# Check for target product
ifeq (pa_epicmtd,$(TARGET_PRODUCT))

# include ParanoidAndroid common configuration
include vendor/pa/config/pa_common.mk

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := $(TARGET_PRODUCT)

# Inherit CM9 device configuration
$(call inherit-product, device/samsung/i9100/cm.mk)

PRODUCT_NAME := pa_epicmtd

GET_VENDOR_PROPS := $(shell vendor/pa/tools/getvendorprops.py $(PRODUCT_NAME))

endif
