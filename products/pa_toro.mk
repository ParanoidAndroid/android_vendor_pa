# Check for target product
ifeq (pa_toro,$(TARGET_PRODUCT))

# Define PA bootanimation size
PARANOID_BOOTANIMATION_NAME := 720x1280

# include ParanoidAndroid common configuration
include vendor/pa/config/pa_common.mk

# Inherit CM9 device configuration
$(call inherit-product, device/samsung/toro/cm.mk)

PRODUCT_NAME := pa_toro

GET_VENDOR_PROPS := $(shell vendor/pa/tools/getvendorprops.py $(PRODUCT_NAME))

endif

