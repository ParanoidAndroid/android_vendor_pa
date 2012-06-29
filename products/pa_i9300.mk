# Check for target product
ifeq (pa_i9300,$(TARGET_PRODUCT))

# include ParanoidAndroid common configuration
include vendor/pa/config/pa_common.mk

# ParanoidAndroid device specific configuration
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=320

# Inherit CM9 device configuration
$(call inherit-product, device/samsung/i9300/cm.mk)

PRODUCT_NAME := pa_i9300

GET_VENDOR_PROPS := $(shell vendor/pa/tools/getvendorprops.py $(PRODUCT_NAME))

endif
