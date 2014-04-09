LOCAL_PATH := $(call my-dir)

ifeq ($(USE_INTEL_UFO_DRIVER),true)
ifneq ($(BOARD_HAVE_GEN_GFX_SRC),true)

include $(LOCAL_PATH)/$(TARGET_ARCH)/baytrail.mk

endif # BOARD_HAVE_GEN_GFX_SRC 
endif # USE_INTEL_UFO_DRIVER
