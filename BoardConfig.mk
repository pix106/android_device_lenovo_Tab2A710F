USE_CAMERA_STUB := true

# Additional includes
TARGET_SPECIFIC_HEADER_PATH := device/lenovo/Tab2A710F/include	# moved up 03/10/2016

# inherit from the proprietary version
-include vendor/lenovo/Tab2A710F/BoardConfigVendor.mk

# Platform
TARGET_BOARD_PLATFORM := mt8127
TARGET_BOARD_PLATFORM_GPU := mali-450mp4	# mp4 added 06/10/2016

# Arch
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a7
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
#ARCH_ARM_HAVE_TLS_REGISTER := true	# Comment 03/10/2016
#ARCH_ARM_HAVE_NEON := true	# Comment 03/10/2016

TARGET_NO_BOOTLOADER := true
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_BOOTLOADER_BOARD_NAME := Tab2A710F
TARGET_OTA_ASSERT_DEVICE := Tab2A710F	# added 03/10/2016

BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216		# = 16MB (OK with MTKDroidTools value)
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216		# = 16MB (OK with MTKDroidTools value)
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1610612736		# = 1,5 GB  (OK with MTKDroidTools value)
BOARD_USERDATAIMAGE_PARTITION_SIZE := 3221225472	# = 3 GB on 5,5 GB max  (OK with MTKDroidTools value)
BOARD_CACHEIMAGE_PARTITION_SIZE := 132120576		# = 0x07e00000 = 128MB
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072
TARGET_USERIMAGES_USE_EXT4 := true

TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false	# Comment ? (ford)

# Vold
TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/mt_usb/musb-hdrc.0.auto/gadget/lun%d/file

# Kernel
#BOARD_MKBOOTIMG_ARGS :=
#BOARD_KERNEL_CMDLINE :=
BOARD_KERNEL_CMDLINE := androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
#TARGET_KERNEL_SOURCE := kernel/lenovo/Tab2A710F
#TARGET_KERNEL_CONFIG := bitland8127_tb_l_defconfig
TARGET_PREBUILT_KERNEL := device/lenovo/Tab2A710F/kernel

# MTK
BOARD_HAS_MTK_HARDWARE := true	# 03/10/2016
MTK_HARDWARE := true # 03/10/2016
BLOCK_BASED_OTA :=false

# to be used with hardware/mediatek repo
BOARD_HAS_MTK := true # added 07/10/2016
MTK_HWC_CHIP := mt8127 # added 07/10/2016
MTK_HWC_SUPPORT := true # added 07/10/2016
MTK_WFD_SUPPORT := true # added 07/10/2016
MTK_PQ_SUPPORT := true # added 07/10/2016
MTK_ION_SUPPORT := true # added 07/10/2016
MTK_HDMI_SUPPORT := false # added 07/10/2016
MTK_SENSOR_SUPPORT := true # added 07/10/2016


# Flags
TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -DMTK_HARDWARE -mfpu=neon -mfloat-abi=softfp
COMMON_GLOBAL_CFLAGS += -DREFRESH_RATE=60
COMMON_GLOBAL_CFLAGS += -DMTK_HARDWARE
COMMON_GLOBAL_CFLAGS += -DADD_LEGACY_ACQUIRE_BUFFER_SYMBOL
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD	# added 03/10/2016

# Graphics
USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := device/lenovo/Tab2A710F/egl.cfg
TARGET_USES_C2D_COMPOSITION := true     # added 03/10/2016
TARGET_USES_OVERLAY := true     # added 03/10/2016
TARGET_USES_ION := true     # added 03/10/2016
TARGET_DISPLAY_USE_RETIRE_FENCE := true     # added 03/10/2016
MAX_EGL_CACHE_KEY_SIZE := 12*1024     # added 03/10/2016
MAX_EGL_CACHE_SIZE := 1024*1024     # added 03/10/2016

# Surfaceflinger optimization for VD surfaces     # added 03/10/2016
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true     # added 03/10/2016
#NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3     # added 03/10/2016

# WIFI
WPA_SUPPLICANT_VERSION := VER_0_8_X
#BOARD_HOSTAPD_DRIVER := NL80211
#BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_mt66xx
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
#BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_mt66xx
WIFI_DRIVER_FW_PATH_PARAM:="/dev/wmtWifi"
WIFI_DRIVER_FW_PATH_STA:=STA
WIFI_DRIVER_FW_PATH_AP:=AP
WIFI_DRIVER_FW_PATH_P2P:=P2P

# BT (added 03/10/2016)
BOARD_HAVE_BLUETOOTH := true
#BOARD_HAVE_BLUETOOTH_MTK := true
BOARD_BLUETOOTH_DOES_NOT_USE_RFKILL := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/lenovo/Tab2A710F/bluetooth

# RECOVERY
TARGET_RECOVERY_FSTAB := device/lenovo/Tab2A710F/recovery/root/recovery.fstab
TARGET_RECOVERY_INITRC := device/lenovo/Tab2A710F/recovery/root/init.rc

# Debug
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# libxlog
TARGET_LDPRELOAD += libxlog.so

# SELinux
BOARD_SEPOLICY_DIRS := \
       device/lenovo/Tab2A710F/sepolicy

# Hack for build
$(shell mkdir -p $(OUT)/obj/KERNEL_OBJ/usr)

#BOARD_SEPOLICY_UNION := \
#        device.te \
#        netd.te \
#        system.te \
#        file_contexts
       
       
