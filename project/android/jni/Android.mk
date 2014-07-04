LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

include $(LOCAL_PATH)/Android_v8.mk


# Copy the shaders from sources to assets
$(shell rm -r $(LOCAL_PATH)/../assets/www/shaders)
$(shell cp -r $(LOCAL_PATH)/source/ejecta/EJCanvas/2D/Shaders $(LOCAL_PATH)/../assets/www/shaders)