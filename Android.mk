LOCAL_PATH := $(call my-dir)

ifeq ($(USE_INTEL_UFO_DRIVER),true)

include $(CLEAR_VARS)
LOCAL_MODULE := ufo.prop
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_OWNER := intel
LOCAL_SRC_FILES := ufo.prop
include $(BUILD_PREBUILT)

include $(LOCAL_PATH)/$(TARGET_ARCH)/baytrail.mk

endif # USE_INTEL_UFO_DRIVER
