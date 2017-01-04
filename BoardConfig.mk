USE_CAMERA_STUB := true

DEVICE_DIR := device/lenovo/Tab2A710F
VENDOR_DIR := vendor/lenovo/Tab2A710F
KERNEL_DIR := kernel/lenovo/Tab2A710F

# Additional includes
TARGET_SPECIFIC_HEADER_PATH := $(DEVICE_DIR)/include

# inherit from the proprietary version
-include $(VENDOR_DIR)/BoardConfigVendor.mk

# Platform
TARGET_BOARD_PLATFORM := mt8127
TARGET_BOARD_PLATFORM_GPU := mali-450mp4

# Arch
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a7
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
ARCH_ARM_HAVE_TLS_REGISTER := true
ARCH_ARM_HAVE_NEON := true

TARGET_NO_BOOTLOADER := true
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_BOOTLOADER_BOARD_NAME := Tab2A710F
TARGET_OTA_ASSERT_DEVICE := Tab2A710F

BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216          # = 16MB (OK with MTKDroidTools value)
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216		# = 16MB (OK with MTKDroidTools value)
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1610612736		# = 1,5 GB  (OK with MTKDroidTools value)
BOARD_USERDATAIMAGE_PARTITION_SIZE := 3221225472	# = 3 GB on 5,5 GB max  (OK with MTKDroidTools value)
BOARD_CACHEIMAGE_PARTITION_SIZE := 132120576		# = 0x07e00000 = 128MB
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072
TARGET_USERIMAGES_USE_EXT4 := true

TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false

# Vold
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/mt_usb/musb-hdrc.0.auto/gadget/lun%d/file

# Kernel
#BOARD_MKBOOTIMG_ARGS :=
#BOARD_KERNEL_CMDLINE :=
BOARD_KERNEL_CMDLINE := androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048

BUILD_KERNEL_FROM_SOURCE := false
ifeq ($(BUILD_KERNEL_FROM_SOURCE),true)
    # build kernel from sources
    BOARD_USES_MTK_KERNELBUILD := true    # from https://gitlab.com/SaberMod/slim-android-build/blob/d0ea96c4ec309e9361f8da6d12dc6770f04e57f4/core/mtk_utils.mk
    TARGET_KERNEL_SOURCE := $(KERNEL_DIR)
    TARGET_KERNEL_CONFIG := bitland8127_tb_l_defconfig
    #TARGET_KMODULES := true         # is it needed ?
else
    # use prebuilt kernel
    TARGET_PREBUILT_KERNEL := $(DEVICE_DIR)/kernel
endif

# MTK
BOARD_HAS_MTK_HARDWARE := true
MTK_HARDWARE := true
BLOCK_BASED_OTA :=false

# to be used with hardware/mediatek repo
BOARD_HAS_MTK := true
MTK_HWC_CHIP := mt8127
MTK_HWC_SUPPORT := true
MTK_WFD_SUPPORT := true
MTK_PQ_SUPPORT := true
MTK_ION_SUPPORT := true
MTK_HDMI_SUPPORT := false
MTK_SENSOR_SUPPORT := true

# Flags
TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -DMTK_HARDWARE
COMMON_GLOBAL_CFLAGS += -DMTK_HARDWARE
COMMON_GLOBAL_CFLAGS += -DREFRESH_RATE=60   # useful ? Not found using mgrep in source
COMMON_GLOBAL_CFLAGS += -DADD_LEGACY_ACQUIRE_BUFFER_SYMBOL  # useful ? Not found using mgrep in source
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD # useful ? Not found using mgrep in source

# Graphics
USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := $(DEVICE_DIR)/configs/egl.cfg
BOARD_EGL_WORKAROUND_BUG_10194508 := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_OVERLAY := true
MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 1024*1024
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true # useful ? qcom only ?
TARGET_DISPLAY_USE_RETIRE_FENCE := true # useful ? qcom only ?
TARGET_USES_ION := true # useful ? qcom only ?

# WIFI
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_mt66xx
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_mt66xx
WIFI_DRIVER_FW_PATH_PARAM:="/dev/wmtWifi"
WIFI_DRIVER_FW_PATH_STA:=STA
WIFI_DRIVER_FW_PATH_AP:=AP
WIFI_DRIVER_FW_PATH_P2P:=P2P

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_MTK := true
BOARD_BLUETOOTH_DOES_NOT_USE_RFKILL := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_DIR)/bluetooth

# RECOVERY
TARGET_RECOVERY_FSTAB := $(DEVICE_DIR)/recovery/root/recovery.fstab
TARGET_RECOVERY_INITRC := $(DEVICE_DIR)/recovery/root/init.rc

# Debug
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# libxlog
TARGET_LDPRELOAD += libxlog.so

# SELinux
BOARD_SEPOLICY_DIRS := \
       $(DEVICE_DIR)/sepolicy

#BOARD_SEPOLICY_UNION := \
#        device.te \
#        netd.te \
#        system.te \
#        file_contexts


# test
# Some flags that may be related to HWC problems. Tried some...
#
# from https://github.com/DevUt/android_device_htc_endeavoru/blob/twrp3/BoardConfig.mk
#BOARD_EGL_WORKAROUND_BUG_10194508 := true
#TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true  # removed, as seen removed on github, try it later
#BOARD_EGL_SKIP_FIRST_DEQUEUE := true
#BOARD_EGL_NEEDS_FNW := true                    # seems old, try it later, may make surfaceflinger fail
#BOARD_USES_LEGACY_MMAP := true                 # seems old
#TARGET_NEEDS_NON_PIE_SUPPORT := true           # seems old
#COMMON_GLOBAL_CFLAGS += -DTARGET_NEEDS_HWC_V0  # not found in source
#COMMON_GLOBAL_CFLAGS += -DBOARD_CANT_REALLOCATE_OMX_BUFFERS

# from https://github.com/thune-xiaobai/Android_device_ZTE_U950/blob/master/BoardConfig.mk
#BOARD_NEEDS_OLD_HWC_API := true
#BOARD_EGL_NEEDS_LEGACY_FB := true

# from https://github.com/CyanogenMod12Y300/android_device_huawei_msm7x27a-common/blob/cm-12.1/BoardConfigCommon.mk
#TARGET_ENABLE_QC_AV_ENHANCEMENTS := true       # ! No QC hardware
#TARGET_NO_ADAPTIVE_PLAYBACK := true

# from http://pastebin.com/Vyk35GrL
#TARGET_DISPLAY_INSECURE_MM_HEAP := true

# changes to existing flags
#TARGET_BOOTLOADER_BOARD_NAME := mt8127          # change ?

#BOARD_EGL_SYSTEMUI_PBSIZE_HACK := true
#AUDIO_FEATURE_ENABLED_FM := true

#BOARD_NEEDS_MEMORYHEAPION := true   # exynos only ! (build fails on libion_exynos)
#BOARD_USES_HWC_SERVICES := true    # exynos only ?
#SURFACE_IS_BGR32 := true    # manta only ?

## /test
