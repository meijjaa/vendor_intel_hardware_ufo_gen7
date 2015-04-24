LOCAL_PATH := $(call my-dir)

UFO_PREBUILTS := $(shell find $(LOCAL_PATH)/x86/bin/* $(LOCAL_PATH)/x86/lib/* $(LOCAL_PATH)/x86/vendor/lib/* -not -type d)
UFO_PREBUILTS := $(patsubst $(LOCAL_PATH)/x86/%, %, $(UFO_PREBUILTS))
ifeq (x86_64,$(TARGET_ARCH))
UFO_64_PREBUILTS := $(shell find $(LOCAL_PATH)/x86_64/lib64/* $(LOCAL_PATH)/x86_64/vendor/lib64/* -not -type d)
UFO_64_PREBUILTS := $(patsubst $(LOCAL_PATH)/x86_64/%, %, $(UFO_64_PREBUILTS))
UFO_PREBUILTS += $(UFO_64_PREBUILTS)
endif
UFO_PREBUILTS := $(filter-out %disabled.so,$(UFO_PREBUILTS))
UFO_PREBUILTS := $(filter-out %igfxSettings,$(UFO_PREBUILTS))

SP_UFO_CREATE_SYMLINKS:
	@echo "Creating symbolic links for gfx files"
	@for p in $(UFO_PREBUILTS); do \
		if [ "$$(basename $$(dirname $$p))" == "egl" ]; then \
			mkdir -p $(TARGET_OUT)/$$(dirname $$p); \
			ln -sf $(HAL_BM_TARGET_GFX)/$$(dirname $$p)/libGLES_intel.so $(TARGET_OUT)/$$(dirname $$p)/; \
			mkdir -p $(TARGET_OUT)/vendor/gfx/ufo_byt/$$(dirname $$p)/; \
			ln -sf ./$$(basename $$p) $(TARGET_OUT)/vendor/gfx/ufo_byt/$$(dirname $$p)/libGLES_intel.so; \
		elif [ "$$(basename $$(dirname $$p))" == "hw" ]; then \
			mkdir -p $(TARGET_OUT)/$$(dirname $$p); \
			ln -sf $(HAL_BM_TARGET_GFX)/$$(dirname $$p)/hwcomposer.$(TARGET_BOARD_PLATFORM).so \
						$(TARGET_OUT)/$$(dirname $$p)/; \
			ln -sf $(HAL_BM_TARGET_GFX)/$$(dirname $$p)/gralloc.$(TARGET_BOARD_PLATFORM).so \
						$(TARGET_OUT)/$$(dirname $$p)/gralloc.autodetect.so; \
		elif [ "$$(dirname $$(dirname $$p))" == "vendor" ]; then \
			if [ "$(USE_INTEL_UFO_OPENCL)" == "true" ]; then \
				mkdir -p $(TARGET_OUT)/$$(dirname $$p); \
				ln -sf $(HAL_BM_TARGET_GFX)/$$p $(TARGET_OUT)/$$(dirname $$p)/; \
			fi; \
		else \
			mkdir -p $(TARGET_OUT)/$$(dirname $$p); \
			ln -sf $(HAL_BM_TARGET_GFX)/$$p $(TARGET_OUT)/$$(dirname $$p)/; \
		fi; \
	done;

ALL_DEFAULT_INSTALLED_MODULES += SP_UFO_CREATE_SYMLINKS
