LOCAL_PATH := $(call my-dir)

SP_UFO_CREATE_SYMLINKS:
	@echo "Creating links in $(TARGET_OUT)/bin"
	@mkdir -p $(TARGET_OUT)/bin;
	@ln -sf $(HAL_BM_TARGET_GFX)/bin/coreu $(TARGET_OUT)/bin/;
	@ln -sf $(HAL_BM_TARGET_GFX)/bin/mediainfo $(TARGET_OUT)/bin/;
#	@ln -sf $(HAL_BM_TARGET_GFX)/bin/curd $(TARGET_OUT)/bin/;
#	@ln -sf $(HAL_BM_TARGET_GFX)/bin/hdcpd $(TARGET_OUT)/bin/;
	
	@echo "Creating links in $(TARGET_OUT)/lib"
	@mkdir -p $(TARGET_OUT)/lib
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libhwcservice.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libgrallocclient.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libgrallocgmm.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libvpwrapper.so $(TARGET_OUT)/lib/
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
#	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libpavpdll.so $(TARGET_OUT)/lib/
#	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libpavp.so $(TARGET_OUT)/lib/
#	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libpcp.so $(TARGET_OUT)/lib/
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/libskuwa.so $(TARGET_OUT)/lib/

	@echo "Creating links in $(TARGET_OUT)/lib/egl"
	@mkdir -p $(TARGET_OUT)/lib/egl
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/egl/libGLES_intel.so $(TARGET_OUT)/lib/egl/

	@echo "Creating links in $(TARGET_OUT)/lib/hw"
	@mkdir -p $(TARGET_OUT)/lib/hw
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/hw/hwcomposer.irda.so $(TARGET_OUT)/lib/hw/hwcomposer.irda.so
	@ln -sf $(HAL_BM_TARGET_GFX)/lib/hw/gralloc.irda.so $(TARGET_OUT)/lib/hw/gralloc.irda.so

	@echo "Creating links in ufo_byt"
	@mkdir -p $(TARGET_OUT)/vendor/gfx/ufo_byt/lib/egl
	@ln -sf ./libGLES_intel7.so $(TARGET_OUT)/vendor/gfx/ufo_byt/lib/egl/libGLES_intel.so

ALL_DEFAULT_INSTALLED_MODULES += SP_UFO_CREATE_SYMLINKS
