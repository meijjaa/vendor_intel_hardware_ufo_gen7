LOCAL_PATH := $(call my-dir)

# Maintain the default to gen7 until the build targets
# are sorted out.
UFO_ENABLE_GEN ?= gen7

ifeq ($(strip $(UFO_ENABLE_GEN)),gen7)
ifeq ($(USE_INTEL_UFO_DRIVER),true)
ifneq ($(BOARD_HAVE_GEN_GFX_SRC),true)

include $(LOCAL_PATH)/$(TARGET_ARCH)/baytrail.mk

endif # BOARD_HAVE_GEN_GFX_SRC 
endif # USE_INTEL_UFO_DRIVER
endif # UFO_ENABLE_GEN
