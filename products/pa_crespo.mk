# Check for target product
ifeq (pa_crespo,$(TARGET_PRODUCT))

# Define PA bootanimation size
PARANOID_BOOTANIMATION_NAME := HDPI

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_hdpi

# include ParanoidAndroid common configuration
include vendor/pa/config/pa_common.mk

# include missing proprietaries
PRODUCT_COPY_FILES += \
  vendor/pa/proprietary/crespo/bcm4329.hcd:system/vendor/firmware/bcm4329.hcd \
  vendor/pa/proprietary/crespo/libpn544_fw.so:system/vendor/firmware/libpn544_fw.so \
  vendor/pa/proprietary/crespo/gps.s5pc110.so:system/vendor/lib/hw/gps.s5pc110.so \
  vendor/pa/proprietary/crespo/libakm.so:system/vendor/lib/libakm.so \
  vendor/pa/proprietary/crespo/gpsd:system/vendor/bin/gpsd

PRODUCT_NAME := pa_crespo

GET_VENDOR_PROPS := $(shell vendor/pa/tools/getvendorprops.py $(PRODUCT_NAME))

endif
