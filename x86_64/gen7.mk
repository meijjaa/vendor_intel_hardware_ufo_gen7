ifneq ($(BOARD_HAVE_GEN_GFX_SRC),true)

UFO_REQUIRED_MODULES :=

UFO_PREBUILT_LIBS := $(shell find $(LOCAL_PATH)/x86_64/lib64/ -not -type d)
UFO_PREBUILT_LIBS := $(patsubst $(LOCAL_PATH)/x86_64/lib64/%, %, $(UFO_PREBUILT_LIBS))
UFO_PREBUILT_LIBS := $(filter-out %disabled.so,$(UFO_PREBUILT_LIBS))

UFO_PREBUILT_32_LIBS := $(shell find $(LOCAL_PATH)/x86/lib/ -not -type d)
UFO_PREBUILT_32_LIBS := $(patsubst $(LOCAL_PATH)/x86/lib/%, %, $(UFO_PREBUILT_32_LIBS))
UFO_PREBUILT_32_LIBS := $(filter-out %disabled.so,$(UFO_PREBUILT_32_LIBS))
UNIQUE_UFO_PREBUILTS_32_LIBS := $(UFO_PREBUILTS_32_LIBS)

UFO_PREBUILT_BINS := $(shell find $(LOCAL_PATH)/x86_64/bin/ -not -type d)
UFO_PREBUILT_BINS := $(patsubst $(LOCAL_PATH)/x86_64/bin/%, %, $(UFO_PREBUILT_BINS))
UFO_PREBUILT_BINS := $(filter-out %igfxSettings,$(UFO_PREBUILT_BINS))

UFO_PREBUILT_ETC := $(shell find $(LOCAL_PATH)/x86_64/etc/ -not -type d)
UFO_PREBUILT_ETC := $(patsubst $(LOCAL_PATH)/x86_64/etc/%, %, $(UFO_PREBUILT_ETC))

UFO_VENDOR_LIBS := $(shell find $(LOCAL_PATH)/x86_64/vendor/lib64/ -not -type d)
UFO_VENDOR_LIBS := $(patsubst $(LOCAL_PATH)/x86_64/vendor/lib64/%, %, $(UFO_VENDOR_LIBS))

UFO_VENDOR_32_LIBS := $(shell find $(LOCAL_PATH)/x86/vendor/lib/ -not -type d)
UFO_VENDOR_32_LIBS := $(patsubst $(LOCAL_PATH)/x86/vendor/lib/%, %, $(UFO_VENDOR_32_LIBS))
UNIQUE_UFO_VENDOR_32_LIBS := $(UFO_VENDOR_32_LIBS)

UFO_VENDOR_ETC := $(shell find $(LOCAL_PATH)/x86_64/vendor/ -not -type d -not -path "*/bin/*" -not -path "*/lib64/*" -not -path "*/lib/*")
UFO_VENDOR_ETC := $(patsubst $(LOCAL_PATH)/x86_64/vendor/%, %, $(UFO_VENDOR_ETC))

define prebuilt-rule
    UFO_MODULE_NAME := $$(basename $$(basename $$(notdir $(1))))
    ifeq ($$(dir $(1)),hw/)
        UFO_REQUIRED_MODULE := $$(UFO_MODULE_NAME).ufo
    else ifeq ($(3),true)
        ifeq ($$(suffix $(1)),.so)
            UFO_REQUIRED_MODULE := $$(UFO_MODULE_NAME)
        else
            UFO_REQUIRED_MODULE := $$(notdir $(1))
        endif # suffix = .so
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
        UFO_32_LIB_EXISTS := false
        UFO_64_LIB_EXISTS := false
        ifeq ($$(LOCAL_PROPRIETARY_MODULE),true)
            UFO_LIB_LOCAL_PATH := vendor
            ifneq ($(filter $(UFO_VENDOR_32_LIBS),$(1)),)
                UFO_32_LIB_EXISTS := true
            endif
            ifneq ($(filter $(UFO_VENDOR_LIBS),$(1)),)
                UFO_64_LIB_EXISTS := true
            endif
            UNIQUE_UFO_VENDOR_32_LIBS := $(filter-out $(1),$(UNIQUE_UFO_VENDOR_32_LIBS))
        else
            UFO_LIB_LOCAL_PATH := .
            ifneq ($(filter $(UFO_PREBUILT_32_LIBS),$(1)),)
                UFO_32_LIB_EXISTS := true
            endif
            ifneq ($(filter $(UFO_PREBUILT_LIBS),$(1)),)
                UFO_64_LIB_EXISTS := true
            endif
            UNIQUE_UFO_PREBUILTS_32_LIBS := $(filter-out $(1),$(UNIQUE_UFO_PREBUILTS_32_LIBS))
        endif # LOCAL_PROPRIETARY_MODULE

        ifeq ($$(UFO_32_LIB_EXISTS),true)
            ifeq ($$(UFO_64_LIB_EXISTS),true)
                LOCAL_MULTILIB := both
            else
                LOCAL_MULTILIB := 32
                LOCAL_MODULE_STEM_64 :=
            endif
            LOCAL_SRC_FILES_32 := x86/$$(UFO_LIB_LOCAL_PATH)/lib/$(1)
            LOCAL_MODULE_PATH_32 := $$(LOCAL_MODULE_PATH_32_GFX_LIB)
        endif
        ifeq ($$(UFO_64_LIB_EXISTS),true)
            ifeq ($$(UFO_32_LIB_EXISTS),true)
                LOCAL_MULTILIB := both
            else
                LOCAL_MULTILIB := 64
                LOCAL_MODULE_STEM_32 :=
            endif
            LOCAL_SRC_FILES_64 := x86_64/$$(UFO_LIB_LOCAL_PATH)/lib64/$(1)
            LOCAL_MODULE_PATH_64 := $$(LOCAL_MODULE_PATH_64_GFX_LIB)
        endif
    else ifeq ($$(LOCAL_MODULE_CLASS),EXECUTABLES)
        ifeq ($$(LOCAL_PROPRIETARY_MODULE),true)
            LOCAL_SRC_FILES := x86_64/vendor/bin/$(1)
        else
            LOCAL_SRC_FILES := x86_64/bin/$(1)
        endif # LOCAL_PROPRIETARY_MODULE
        LOCAL_MODULE_PATH := $$(LOCAL_MODULE_PATH_GFX_BIN)
    else ifeq ($$(LOCAL_MODULE_CLASS),ETC)
        ifeq ($$(LOCAL_PROPRIETARY_MODULE),true)
            LOCAL_SRC_FILES := x86_64/vendor/$(1)
            LOCAL_MODULE_PATH := $$(TARGET_OUT)/vendor
        else
            LOCAL_SRC_FILES := x86_64/etc/$(1)
            LOCAL_MODULE_PATH := $$(TARGET_OUT)/etc
        endif # LOCAL_PROPRIETARY_MODULE
    endif # LOCAL_MODULE_CLASS

    # For debugging
    ## (info )
    # (info LOCAL_MODULE = $(LOCAL_MODULE))
    # (info LOCAL_MULTILIB = $(LOCAL_MULTILIB))
    # (info LOCAL_PROPRIETARY_MODULE = $(LOCAL_PROPRIETARY_MODULE))
    # (info LOCAL_MODULE_STEM_32 = $(LOCAL_MODULE_STEM_32))
    # (info LOCAL_MODULE_STEM_64 = $(LOCAL_MODULE_STEM_64))
    # (info LOCAL_SRC_FILES_32 = $(LOCAL_SRC_FILES_32))
    # (info LOCAL_SRC_FILES_64 = $(LOCAL_SRC_FILES_64))
    # (info LOCAL_MODULE_PATH_32 = $(LOCAL_MODULE_PATH_32))
    # (info LOCAL_MODULE_PATH_64 = $(LOCAL_MODULE_PATH_64))
    # (info UFO_32_LIB_EXISTS = $(UFO_32_LIB_EXISTS))
    # (info UFO_64_LIB_EXISTS = $(UFO_64_LIB_EXISTS))

    include $$(BUILD_PREBUILT)
endef

$(foreach p, $(UFO_PREBUILT_LIBS), $(eval $(call prebuilt-rule,$(p),SHARED_LIBRARIES)))
$(foreach p, $(UFO_PREBUILT_BINS), $(eval $(call prebuilt-rule,$(p),EXECUTABLES)))
$(foreach p, $(UFO_PREBUILT_ETC), $(eval $(call prebuilt-rule,$(p),ETC)))
$(foreach p, $(UNIQUE_UFO_PREBUILTS_32_LIBS), $(eval $(call prebuilt-rule,$(p),SHARED_LIBRARIES)))
ifeq ($(USE_INTEL_UFO_OPENCL),true)
$(foreach p, $(UFO_VENDOR_LIBS), $(eval $(call prebuilt-rule,$(p),SHARED_LIBRARIES,true)))
$(foreach p, $(UFO_VENDOR_ETC), $(eval $(call prebuilt-rule,$(p),ETC,true)))
$(foreach p, $(UNIQUE_UFO_VENDOR_32_LIBS), $(eval $(call prebuilt-rule,$(p),SHARED_LIBRARIES,true)))
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
