# Check for target product
ifeq (pa_toroplus,$(TARGET_PRODUCT))

# Define PA bootanimation size
PARANOID_BOOTANIMATION_NAME := XHDPI

# TARGET_FAMILY adds common overlay and overrides PA configuration source
TARGET_FAMILY := pa_tuna

# include ParanoidAndroid common configuration
include vendor/pa/config/pa_common.mk

# include missing proprietaries
PRODUCT_COPY_FILES += \
  vendor/pa/proprietary/toroplus/bcm4330.hcd:system/vendor/firmware/bcm4330.hcd

# Inherit CM9 device configuration
$(call inherit-product, device/samsung/toroplus/cm.mk)

PRODUCT_NAME := pa_toroplus

GET_VENDOR_PROPS := $(shell vendor/pa/tools/getvendorprops.py $(PRODUCT_NAME))

endif
