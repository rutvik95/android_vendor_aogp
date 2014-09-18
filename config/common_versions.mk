# Version information used on all builds
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_VERSION_TAGS=release-keys USER=android-build BUILD_UTC_DATE=$(shell date +"%s")

DATE = $(shell vendor/aogp/tools/getdate)
AOGP_BRANCH=kitkat

# AOGP RELEASE VERSION
AOGP_VERSION_MAJOR = 1
AOGP_VERSION_MINOR = 0
AOGP_VERSION_MAINTENANCE =

VERSION := $(AOGP_VERSION_MAJOR).$(AOGP_VERSION_MINOR)$(AOGP_VERSION_MAINTENANCE)

ifndef AOGP_BUILD
    ifdef RELEASE_TYPE
        RELEASE_TYPE := $(shell echo $(RELEASE_TYPE) | sed -e 's|^AOGP_||g')
        AOGP_BUILD := $(RELEASE_TYPE)
    else
        AOGP_BUILD := UNOFFICIAL
    endif
endif

ifdef AOGP_BUILD
    ifeq ($(AOGP_BUILD), RELEASE)
       AOGP_VERSION := $(TARGET_PRODUCT)_$(AOGP_BRANCH)-$(VERSION)-RELEASE-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(AOGP_BUILD), NIGHTLY)
        AOGP_VERSION := $(TARGET_PRODUCT)_$(AOGP_BRANCH)-$(VERSION)-NIGHTLY-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(AOGP_BUILD), EXPERIMENTAL)
        AOGP_VERSION := $(TARGET_PRODUCT)_$(AOGP_BRANCH)-$(VERSION)-EXPERIMENTAL-$(shell date -u +%Y%m%d)
    endif
    ifeq ($(AOGP_BUILD), UNOFFICIAL)
        AOGP_VERSION := $(TARGET_PRODUCT)_$(AOGP_BRANCH)-$(VERSION)-UNOFFICIAL-$(shell date -u +%Y%m%d)
    endif
else
#We reset back to UNOFFICIAL
        AOGP_VERSION := $(TARGET_PRODUCT)_$(AOGP_BRANCH)-$(VERSION)-UNOFFICIAL-$(shell date -u +%Y%m%d)
endif



PRODUCT_PROPERTY_OVERRIDES += \
    ro.modversion=$(AOGP_VERSION) \
    ro.aogp.version=$(VERSION)-$(AOGP_BUILD)
