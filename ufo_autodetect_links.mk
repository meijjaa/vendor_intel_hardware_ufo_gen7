LOCAL_PATH := $(call my-dir)

SP_UFO_CREATE_SYMLINKS:
	@echo "Creating links in $(TARGET_OUT)/bin"
	@mkdir -p $(TARGET_OUT)/bin;
	@ln -sf $(HAL_BM_TARGET_GFX)/bin/coreu $(TARGET_OUT)/bin/;
	@ln -sf $(HAL_BM_TARGET_GFX)/bin/mediainfo $(TARGET_OUT)/bin/;
#	@ln -sf $(HAL_BM_TARGET_GFX)/bin/curd $(TARGET_OUT)/bin/;
	@ln -sf $(HAL_BM_TARGET_GFX)/bin/hdcpd $(TARGET_OUT)/bin/;
	@ln -sf $(HAL_BM_TARGET_GFX)/bin/igfxSettings $(TARGET_OUT)/bin/;
	
	@echo "Creating links in $(TARGET_OUT)/lib"
	@mkdir -p $(TARGET_OUT)/lib
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libhwcservice.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libgrallocclient.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libgrallocgmm.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/i965_drv_video.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libivp.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/igfxcmjit32.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/igfxcmrt32.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/lib2d.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libcoreuclient.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libcoreuinterface.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libcoreuservice.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libgsmgr.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libuevent.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libpavpdll.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libpavp.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libpcp.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libskuwa.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libmd.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libRSDriverMlc_intel7.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libRSDriverUmd_intel7.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libRSDriver_intel7.so $(TARGET_OUT)/lib/
ifeq ($(USE_INTEL_UFO_OPENCL),true)
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libigdbcl.so $(TARGET_OUT)/lib/
endif # USE_INTEL_UFO_OPENCL

	@echo "Creating links in $(TARGET_OUT)/lib/egl"
	@mkdir -p $(TARGET_OUT)/lib/egl
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/egl/libGLES_intel.so $(TARGET_OUT)/lib/egl/

	@echo "Creating links in $(TARGET_OUT)/lib/hw"
	@mkdir -p $(TARGET_OUT)/lib/hw
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/hw/hwcomposer.$(TARGET_BOARD_PLATFORM).so $(TARGET_OUT)/lib/hw/hwcomposer.$(TARGET_BOARD_PLATFORM).so
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/hw/gralloc.$(TARGET_BOARD_PLATFORM).so $(TARGET_OUT)/lib/hw/gralloc.autodetect.so

	@echo "Creating links in ufo_byt"
	@mkdir -p $(TARGET_OUT_VENDOR)/gfx/ufo_byt/lib/egl
	@ln -sf ./libGLES_intel7.so $(TARGET_OUT_VENDOR)/gfx/ufo_byt/lib/egl/libGLES_intel.so

ifeq (x86_64,$(TARGET_ARCH))
	@mkdir -p $(TARGET_OUT)/lib64
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libhwcservice.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libgrallocclient.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libgrallocgmm.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/i965_drv_video.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libivp.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/igfxcmjit32.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/igfxcmrt32.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/lib2d.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libcoreuclient.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libcoreuinterface.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libcoreuservice.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libgsmgr.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libuevent.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libpavpdll.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libpavp.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libpcp.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libskuwa.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libmd.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libRSDriverMlc_intel7.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libRSDriverUmd_intel7.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libRSDriver_intel7.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libigdbcl.so $(TARGET_OUT)/lib64/
	#x86_64 need libigdusc.so both 32bit and 64bit lib
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/libigdusc.so $(TARGET_OUT)/lib64/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libigdusc.so $(TARGET_OUT)/lib/

	@echo "Creating links in $(TARGET_OUT)/lib64/egl"
	@mkdir -p $(TARGET_OUT)/lib64/egl
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/egl/libGLES_intel.so $(TARGET_OUT)/lib64/egl/

	@echo "Creating links in $(TARGET_OUT)/lib64/hw"
	@mkdir -p $(TARGET_OUT)/lib64/hw
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/hw/hwcomposer.$(TARGET_BOARD_PLATFORM).so $(TARGET_OUT)/lib64/hw/hwcomposer.$(TARGET_BOARD_PLATFORM).so
	@ln -sf $(HAL_BM_TARGET_GFX)/lib64/hw/gralloc.$(TARGET_BOARD_PLATFORM).so $(TARGET_OUT)/lib64/hw/gralloc.autodetect.so

	@echo "Creating links in ufo_byt"
	@mkdir -p $(TARGET_OUT_VENDOR)/gfx/ufo_byt/lib64/egl
	@ln -sf ./libGLES_intel7.so $(TARGET_OUT_VENDOR)/gfx/ufo_byt/lib64/egl/libGLES_intel.so
endif

ALL_DEFAULT_INSTALLED_MODULES += SP_UFO_CREATE_SYMLINKS
