# Check for target product
ifeq (pa_galaxys2,$(TARGET_PRODUCT))

# Inherit CM9 device configuration
$(call inherit-product, device/samsung/galaxys2/cm.mk)

# include ParanoidAndroid common configuration
include vendor/pa/config/pa_common.mk

# ParanoidAndroid device specific configuration
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd.density=128

PRODUCT_NAME := pa_galaxys2

GET_VENDOR_PROPS := $(shell vendor/pa/tools/getvendorprops.py $(PRODUCT_NAME))

endif
