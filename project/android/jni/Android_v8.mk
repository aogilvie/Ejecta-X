LOCAL_PATH := $(call my-dir)
ANDROID_NDK_ROOT := /Users/Ally/Documents/android-ndk-r9d

V8Libraries = $(LOCAL_PATH)/libraries/v8/libs/libv8_base.a
V8Libraries += $(LOCAL_PATH)/libraries/v8/libs/libv8_libbase.a
V8Libraries += $(LOCAL_PATH)/libraries/v8/libs/libv8_snapshot.a

V8Libraries += $(LOCAL_PATH)/libraries/icu/libs/libicui18n.a
V8Libraries += $(LOCAL_PATH)/libraries/icu/libs/libicuuc.a
V8Libraries += $(LOCAL_PATH)/libraries/icu/libs/libicudata.a

STLPath := $(ANDROID_NDK_ROOT)/sources/cxx-stl/stlport
STLHeaders := $(STLPath)/stlport
STLLibrary := $(STLPath)/libs/armeabi-v7a/libstlport_static.a

# project code import
include $(CLEAR_VARS)
LOCAL_LDLIBS := -llog -lc

LOCAL_MODULE    	:= libv8

LOCAL_CFLAGS += -DENABLE_SINGLE_THREADED=1 -DUSE_FILE32API -D__LINUX__=1 -DCOMPATIBLE_GCC4=1 -D__LITTLE_ENDIAN__=1 -DGL_GLEXT_PROTOTYPES=1 -DEJECTA_DEBUG=1

LOCAL_C_INCLUDES := \
                    $(LOCAL_PATH) \
                    $(LOCAL_PATH)/source/lib/lodefreetype \
                    $(LOCAL_PATH)/source/lib/lodepng \
                    $(LOCAL_PATH)/source/lib/lodejpeg \
                    $(LOCAL_PATH)/source/lib/uriparser \
                    $(LOCAL_PATH)/source/ejecta \
                    $(LOCAL_PATH)/source/ejecta/EJCanvas \
                    $(LOCAL_PATH)/source/ejecta/EJCanvas/2D \
                    $(LOCAL_PATH)/source/ejecta/EJCocoa \
                    $(LOCAL_PATH)/source/ejecta/EJCocoa/support \
                    $(LOCAL_PATH)/source/ejecta/EJUtils \
                    $(LOCAL_PATH)/libraries/v8/includes \
                    $(LOCAL_PATH)/libraries/android/libfreetype/include \
                    $(LOCAL_PATH)/libraries/android/libpng/include \
                    $(LOCAL_PATH)/libraries/android/libjpeg/include \
                    $(LOCAL_PATH)/libraries/android/libcurl/include \
                    $(LOCAL_PATH)/libraries/android/JavaScriptCore/include 

LOCAL_SRC_FILES := \
                    source/ejecta/EJCocoa/support/nsCArray.cpp \
                    source/ejecta/EJCocoa/NSObject.cpp \
                    source/ejecta/EJCocoa/NSObjectFactory.cpp \
                    source/ejecta/EJCocoa/NSGeometry.cpp \
                    source/ejecta/EJCocoa/NSAutoreleasePool.cpp \
                    source/ejecta/EJCocoa/NSArray.cpp \
                    source/ejecta/EJCocoa/CGAffineTransform.cpp \
                    source/ejecta/EJCocoa/NSDictionary.cpp \
                    source/ejecta/EJCocoa/NSNS.cpp \
                    source/ejecta/EJCocoa/NSSet.cpp \
                    source/ejecta/EJCocoa/NSString.cpp \
                    source/ejecta/EJCocoa/NSValue.cpp \
                    source/ejecta/EJCocoa/NSZone.cpp \
                    source/ejecta/EJCocoa/NSCache.cpp \
                    source/ejecta/EJApp.cpp \
                    source/ejecta/EJConvert.cpp \
                    source/ejecta/EJBindingBase.cpp \
                    source/ejecta/EJBindingEjectaCore.cpp \
                    source/ejecta/EJBindingEventedBase.cpp \
                    source/ejecta/EJSharedOpenGLContext.cpp \
                    source/ejecta/EJTimer.cpp \
                    source/ejecta/EJAudio/EJBindingAudio.cpp \
                    source/ejecta/EJCanvas/EJBindingImage.cpp \
                    source/ejecta/EJCanvas/EJBindingCanvas.cpp \
                    source/ejecta/EJCanvas/EJCanvasContext.cpp \
                    source/ejecta/EJCanvas/EJTexture.cpp \
                    source/ejecta/EJCanvas/2D/EJBindingImageData.cpp \
                    source/ejecta/EJCanvas/2D/EJCanvasContextScreen.cpp \
                    source/ejecta/EJCanvas/2D/EJCanvasContextTexture.cpp \
                    source/ejecta/EJCanvas/2D/EJFont.cpp \
                    source/ejecta/EJCanvas/2D/EJGLProgram2D.cpp \
                    source/ejecta/EJCanvas/2D/EJImageData.cpp \
                    source/ejecta/EJCanvas/2D/EJPath.cpp \
                    source/ejecta/EJUtils/EJBindingHttpRequest.cpp \
                    source/ejecta/EJUtils/EJBindingLocalStorage.cpp \
                    source/ejecta/EJUtils/EJBindingTouchInput.cpp \
                    ejecta.cpp \
                    
LOCAL_CFLAGS 		+= -Wall -Wno-unused-function -Wno-unused-variable -fpermissive -Wno-psabi
LOCAL_CPPFLAGS 		+= -ldl -lstdc++ -llog -lgcc -licudata

LOCAL_LDLIBS += $(V8Libraries) $(STLLibrary) -ldl -lstdc++ -llog -lgcc -landroid -lz -lGLESv2 -lGLESv1_CM

#LOCAL_STATIC_LIBRARIES := v8_base v8_libbase v8_snapshot icui18n icuuc icudata $(STLLibrary)
include $(BUILD_SHARED_LIBRARY)  