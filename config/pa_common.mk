# ParanoidAndroid
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/$(TARGET_PRODUCT)-pad.prop:system/pad.prop

# Replace CM9 files
PRODUCT_COPY_FILES += \
    vendor/pa/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh

ifneq ($(TARGET_BOOTANIMATION_NAME),)
    PRODUCT_COPY_FILES += \
        vendor/pa/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
else
    PRODUCT_COPY_FILES += \
        vendor/pa/prebuilt/common/bootanimation/vertical-480x800.zip:system/media/bootanimation.zip
endif
    
# ParanoidAndroid Packages
PRODUCT_PACKAGES += \
    ParanoidBackup \
    ParanoidOTA      

# ParanoidAndroid Overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/common
PRODUCT_PACKAGE_OVERLAYS += vendor/pa/overlay/$(TARGET_PRODUCT)

PA_VERSION_MAJOR = 1
PA_VERSION_MINOR = 5
PA_VERSION_MAINTENANCE = a

TARGET_CUSTOM_RELEASETOOL := vendor/pa/tools/squisher

CM_VERSION := PARANOIDANDROID
PA_VERSION := $(CM_VERSION)-$(TARGET_PRODUCT)-$(PA_VERSION_MAJOR).$(PA_VERSION_MINOR)$(PA_VERSION_MAINTENANCE)-$(shell date +%0d%^b%Y-%H%M%S)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.cm.version=$(CM_VERSION) \
  ro.modversion=$(CM_VERSION) \
  ro.pa.version=$(PA_VERSION)
