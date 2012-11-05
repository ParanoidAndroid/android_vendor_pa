# Check for target product
ifeq (pa_grouper,$(TARGET_PRODUCT))

# Define PA bootanimation size
PARANOID_BOOTANIMATION_NAME := XHDPI

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_tvdpi

# include ParanoidAndroid common configuration
include vendor/pa/config/pa_common.mk

# include missing proprietaries
PRODUCT_COPY_FILES += \
  vendor/pa/proprietary/grouper/bcm4330.hcd:system/etc/firmware/bcm4330.hcd

PRODUCT_NAME := pa_grouper

GET_VENDOR_PROPS := $(shell vendor/pa/tools/getvendorprops.py $(PRODUCT_NAME))

endif

