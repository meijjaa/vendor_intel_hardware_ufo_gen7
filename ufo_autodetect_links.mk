LOCAL_PATH := $(call my-dir)

# Create symbolic links to the gfx bind-mounted folder containing ufo
# libraries of the running device (bind-mount is done by hald upon graphic
# chip detection, gen7 here).
#
# UFO_PREBUILT_LINK_PAIRS contains a list of link:target pairs:
#	path/to/symlink1:../../relative/path/to/link_target1 \
#	path/to/symlink2:../relative/path/to/link_target2 \
#	...
#
# UFO_PREBUILT_LINKS contains the symbolic link files extracted from
# UFO_PREBUILT_LINK_PAIRS
#
# Then a rule for all symbolic links creates them. This rule also creates a
# fake target file (using touch) so the link, that points to its target using
# a relative path, is valid in both the device tree and the build tree (so the
# link is not created again by subsequent make invocations). These fake files
# get overridden by the bind-mount.

# x86/bin/ and x86/lib/
PREBUILTS := $(shell cd $(LOCAL_PATH)/x86/ && find bin lib -maxdepth 1 -not -type d)
UFO_PREBUILT_LINK_PAIRS := $(foreach f,$(PREBUILTS),$(TARGET_OUT)/$(f):../..$(HAL_BM_TARGET_GFX)/$(f))

# x86/lib/egl/
UFO_PREBUILT_LINK_PAIRS += \
	$(TARGET_OUT)/lib/egl/libGLES_intel.so:../../..$(HAL_BM_TARGET_GFX)/lib/egl/libGLES_intel.so \
	$(PRODUCT_OUT)$(HAL_BM_SOURCE_GFX_PREFIX)/ufo_byt/lib/egl/libGLES_intel.so:./libGLES_intel7.so

# x86/lib/hw/
UFO_PREBUILT_LINK_PAIRS += \
	$(TARGET_OUT)/lib/hw/hwcomposer.$(TARGET_BOARD_PLATFORM).so:../../..$(HAL_BM_TARGET_GFX)/lib/hw/hwcomposer.$(TARGET_BOARD_PLATFORM).so \
	$(TARGET_OUT)/lib/hw/gralloc.autodetect.so:../../..$(HAL_BM_TARGET_GFX)/lib/hw/gralloc.$(TARGET_BOARD_PLATFORM).so

ifeq ($(USE_INTEL_UFO_OPENCL),true)
PREBUILTS := $(shell cd $(LOCAL_PATH)/x86/ && find vendor/lib -not -type d)
UFO_PREBUILT_LINK_PAIRS += $(foreach f,$(PREBUILTS),$(TARGET_OUT)/$(f):../../..$(HAL_BM_TARGET_GFX)/$(f))
endif

ifeq (x86_64,$(TARGET_ARCH))

# x86_64/lib64/
PREBUILTS := $(shell cd $(LOCAL_PATH)/x86_64/ && find lib64 -maxdepth 1 -not -type d)
UFO_PREBUILT_LINK_PAIRS += $(foreach f,$(PREBUILTS),$(TARGET_OUT)/$(f):../..$(HAL_BM_TARGET_GFX)/$(f))

# x86_64/lib64/egl/
UFO_PREBUILT_LINK_PAIRS += \
	$(TARGET_OUT)/lib64/egl/libGLES_intel.so:../../..$(HAL_BM_TARGET_GFX)/lib64/egl/libGLES_intel.so \
	$(PRODUCT_OUT)$(HAL_BM_SOURCE_GFX_PREFIX)/ufo_byt/lib64/egl/libGLES_intel.so:./libGLES_intel7.so

# x86_64/lib64/hw/
UFO_PREBUILT_LINK_PAIRS += \
	$(TARGET_OUT)/lib64/hw/hwcomposer.$(TARGET_BOARD_PLATFORM).so:../../..$(HAL_BM_TARGET_GFX)/lib64/hw/hwcomposer.$(TARGET_BOARD_PLATFORM).so \
	$(TARGET_OUT)/lib64/hw/gralloc.autodetect.so:../../..$(HAL_BM_TARGET_GFX)/lib64/hw/gralloc.$(TARGET_BOARD_PLATFORM).so

ifeq ($(USE_INTEL_UFO_OPENCL),true)
PREBUILTS := $(shell cd $(LOCAL_PATH)/x86_64/ && find vendor/lib64 -not -type d)
UFO_PREBUILT_LINK_PAIRS += $(foreach f,$(PREBUILTS),$(TARGET_OUT)/$(f):../../..$(HAL_BM_TARGET_GFX)/$(f))
endif

endif

UFO_PREBUILT_LINKS := \
	$(foreach item, $(UFO_PREBUILT_LINK_PAIRS), $(call word-colon, 1, $(item)))

# This rule create the links and their fake targets
$(UFO_PREBUILT_LINKS):
	$(hide) echo "Creating symbolic link on $(notdir $@)"
	$(eval PRV_TARGET := $(call word-colon, 2, $(filter $@:%, $(UFO_PREBUILT_LINK_PAIRS))))
	mkdir -p $(dir $@)
	mkdir -p $(dir $(dir $@)$(PRV_TARGET))
	touch $(dir $@)$(PRV_TARGET)
	ln -sf $(PRV_TARGET) $@

ALL_DEFAULT_INSTALLED_MODULES += $(UFO_PREBUILT_LINKS)
