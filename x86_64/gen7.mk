ifneq ($(BOARD_HAVE_GEN_GFX_SRC),true)

UFO_REQUIRED_MODULES :=

UFO_PREBUILT_LIBS := $(shell find $(LOCAL_PATH)/$(TARGET_ARCH)/lib64/* -not -type d)
UFO_PREBUILT_LIBS := $(patsubst $(LOCAL_PATH)/$(TARGET_ARCH)/lib64/%, %, $(UFO_PREBUILT_LIBS))
UFO_PREBUILT_LIBS := $(filter-out %disabled.so,$(UFO_PREBUILT_LIBS))
UFO_PREBUILT_LIBS := $(filter-out %igfxSettings,$(UFO_PREBUILT_LIBS))

UFO_PREBUILT_BINS := $(shell find $(LOCAL_PATH)/$(TARGET_ARCH)/bin/* -not -type d)
UFO_PREBUILT_BINS := $(patsubst $(LOCAL_PATH)/$(TARGET_ARCH)/bin/%, %, $(UFO_PREBUILT_BINS))

UFO_PREBUILT_ETC := $(shell find $(LOCAL_PATH)/$(TARGET_ARCH)/etc/* -not -type d)
UFO_PREBUILT_ETC := $(patsubst $(LOCAL_PATH)/$(TARGET_ARCH)/etc/%, %, $(UFO_PREBUILT_ETC))

UFO_VENDOR_LIBS := $(shell find $(LOCAL_PATH)/$(TARGET_ARCH)/vendor/lib64/* -not -type d)
UFO_VENDOR_LIBS := $(patsubst $(LOCAL_PATH)/$(TARGET_ARCH)/vendor/lib64/%, %, $(UFO_VENDOR_LIBS))

UFO_VENDOR_ETC := $(shell find $(LOCAL_PATH)/$(TARGET_ARCH)/vendor/* -not -type d -not -path "*/bin/*" -not -path "*/lib64/*" -not -path "*/lib/*")
UFO_VENDOR_ETC := $(patsubst $(LOCAL_PATH)/$(TARGET_ARCH)/vendor/%, %, $(UFO_VENDOR_ETC))

define prebuilt-rule
    UFO_MODULE_NAME := $$(basename $$(basename $$(notdir $(1))))
    ifeq ($$(dir $(1)),hw/)
        UFO_REQUIRED_MODULE := $$(UFO_MODULE_NAME).ufo
    else
        UFO_REQUIRED_MODULE := $$(UFO_MODULE_NAME)
    endif # dirpath = hw
    UFO_REQUIRED_MODULES += $$(UFO_REQUIRED_MODULE)

    include $$(CLEAR_VARS)

    LOCAL_MODULE := $$(UFO_REQUIRED_MODULE)
    LOCAL_MODULE_RELATIVE_PATH := $$(dir $(1))
    ifeq ($$(LOCAL_MODULE_RELATIVE_PATH),hw/)
        LOCAL_MODULE_STEM := $$(UFO_MODULE_NAME).$$(TARGET_BOARD_PLATFORM)
        LOCAL_MODULE_STEM_32 := $$(UFO_MODULE_NAME).$$(TARGET_BOARD_PLATFORM)
        LOCAL_MODULE_STEM_64 := $$(UFO_MODULE_NAME).$$(TARGET_BOARD_PLATFORM)
    else
        LOCAL_MODULE_STEM := $$(UFO_MODULE_NAME)
        LOCAL_MODULE_STEM_32 := $$(UFO_MODULE_NAME)
        LOCAL_MODULE_STEM_64 := $$(UFO_MODULE_NAME)
    endif # LOCAL_MODULE_RELATIVE_PATH = hw

    LOCAL_MODULE_CLASS := $(2)
    LOCAL_MODULE_TAGS := optional
    LOCAL_MODULE_SUFFIX := $$(suffix $(1))
    LOCAL_MODULE_OWNER := intel
    LOCAL_PROPRIETARY_MODULE := $(3)
    LOCAL_MODULE_RELATIVE_PATH := $$(dir $(1))

    ifeq ($$(LOCAL_MODULE_CLASS),SHARED_LIBRARIES)
        LOCAL_MULTILIB := both
        ifeq ($$(LOCAL_PROPRIETARY_MODULE),true)
            LOCAL_SRC_FILES_32 := x86/vendor/lib/$(1)
            LOCAL_SRC_FILES_64 := x86_64/vendor/lib64/$(1)
        else
            LOCAL_SRC_FILES_32 := x86/lib/$(1)
            LOCAL_SRC_FILES_64 := x86_64/lib64/$(1)
        endif # LOCAL_PROPRIETARY_MODULE
        LOCAL_MODULE_PATH_32 := $$(LOCAL_MODULE_PATH_32_GFX_LIB)
        LOCAL_MODULE_PATH_64 := $$(LOCAL_MODULE_PATH_64_GFX_LIB)
    else ifeq ($$(LOCAL_MODULE_CLASS),EXECUTABLES)
        ifeq ($$(LOCAL_PROPRIETARY_MODULE),true)
            LOCAL_SRC_FILES := $$(TARGET_ARCH)/vendor/bin/$(1)
        else
            LOCAL_SRC_FILES := $$(TARGET_ARCH)/bin/$(1)
        endif # LOCAL_PROPRIETARY_MODULE
        ifneq ($$(LOCAL_MODULE),msync)
            LOCAL_MODULE_PATH := $$(LOCAL_MODULE_PATH_GFX_BIN)
        endif $ LOCAL_MODULE != msync
    else ifeq ($$(LOCAL_MODULE_CLASS),ETC)
        ifeq ($$(LOCAL_PROPRIETARY_MODULE),true)
            LOCAL_SRC_FILES := $$(TARGET_ARCH)/vendor/$(1)
            LOCAL_MODULE_PATH := $$(TARGET_OUT)/vendor
        else
            LOCAL_SRC_FILES := $$(TARGET_ARCH)/etc/$(1)
            LOCAL_MODULE_PATH := $$(TARGET_OUT)/etc
        endif # LOCAL_PROPRIETARY_MODULE
    endif # LOCAL_MODULE_CLASS

    include $$(BUILD_PREBUILT)
endef

$(foreach p, $(UFO_PREBUILT_LIBS), $(eval $(call prebuilt-rule,$(p),SHARED_LIBRARIES)))
$(foreach p, $(UFO_PREBUILT_BINS), $(eval $(call prebuilt-rule,$(p),EXECUTABLES)))
$(foreach p, $(UFO_PREBUILT_ETC), $(eval $(call prebuilt-rule,$(p),ETC)))
ifeq ($(USE_INTEL_UFO_OPENCL),true)
$(foreach p, $(UFO_VENDOR_LIBS), $(eval $(call prebuilt-rule,$(p),SHARED_LIBRARIES,true)))
$(foreach p, $(UFO_VENDOR_ETC), $(eval $(call prebuilt-rule,$(p),ETC,true)))
endif # USE_INTEL_UFO_OPENCL

include $(CLEAR_VARS)
LOCAL_MODULE := ufo_prebuilts
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_OWNER := intel
LOCAL_REQUIRED_MODULES := $(UFO_REQUIRED_MODULES)

# Non-VPG deps
LOCAL_REQUIRED_MODULES += libdrm
LOCAL_REQUIRED_MODULES += libdrm_intel
LOCAL_REQUIRED_MODULES += libpciaccess
LOCAL_REQUIRED_MODULES += libva
LOCAL_REQUIRED_MODULES += libva-android
include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_COPY_HEADERS_TO := ufo
LOCAL_COPY_HEADERS := x86/graphics.h
LOCAL_COPY_HEADERS += x86/gralloc.h
LOCAL_COPY_HEADERS += x86/libpavp.h
LOCAL_COPY_HEADERS += x86/iVP.h
include $(BUILD_COPY_HEADERS)

endif # BOARD_HAVE_GEN_GFX_SRC
