# Product's extra packages+repos
-include vendor/pa/products/$(PRODUCT_NAME)_extra.mk
PA_ROOMSERVICE_LIST += products/$(PRODUCT_NAME)

# CM's packages+repos
ifneq ($(findstring cm,$(VENDOR_PACKAGES_LIST)),)
include vendor/pa/packages/cm.mk
PA_ROOMSERVICE_LIST += packages/cm
endif

# Remove/Get extra repos (roomservice.xml)
PA_ROOMSERVICE_INFO := $(shell vendor/pa/config/pa_roomservice.py $(PA_ROOMSERVICE_LIST))
