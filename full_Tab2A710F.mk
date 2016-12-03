DEVICE_DIR := device/lenovo/Tab2A710F

# Inherit from those products. Most specific first.
$(call inherit-product, $(DEVICE_DIR)/device.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

PRODUCT_CHARACTERISTICS := tablet

# init
PRODUCT_COPY_FILES += \
    $(DEVICE_DIR)/ramdisk/init.mt8127.rc:root/init.mt8127.rc \
    $(DEVICE_DIR)/ramdisk/init.mt8127.power.rc:root/init.mt8127.power.rc \
    $(DEVICE_DIR)/ramdisk/init.mt8127.usb.rc:root/init.mt8127.usb.rc \
    $(DEVICE_DIR)/ramdisk/init.aee.rc:root/init.aee.rc \
    $(DEVICE_DIR)/ramdisk/init.ssd.rc:root/init.ssd.rc \
    $(DEVICE_DIR)/ramdisk/init.project.rc:root/init.project.rc \
    $(DEVICE_DIR)/ramdisk/init.charging.rc:root/init.charging.rc \
    $(DEVICE_DIR)/ramdisk/ueventd.rc:root/ueventd.rc \
    $(DEVICE_DIR)/ramdisk/ueventd.mt8127.rc:root/ueventd.mt8127.rc \
    $(DEVICE_DIR)/ramdisk/factory_init.project.rc:root/factory_init.project.rc \
    $(DEVICE_DIR)/ramdisk/meta_init.rc:root/meta_init.rc \
    $(DEVICE_DIR)/ramdisk/meta_init.project.rc:root/meta_init.project.rc \
    $(DEVICE_DIR)/ramdisk/factory_init.rc:root/factory_init.rc \
    $(DEVICE_DIR)/ramdisk/auto_shutdown.sh:root/auto_shutdown.sh \
    $(DEVICE_DIR)/ramdisk/enableswap.sh:root/enableswap.sh
#    $(DEVICE_DIR)/ramdisk/init.environ.rc:root/init.environ.rc \


# fstab
PRODUCT_COPY_FILES += \
    $(DEVICE_DIR)/ramdisk/fstab:root/fstab \
    $(DEVICE_DIR)/ramdisk/fstab.mt8127:root/fstab.mt8127

# sh	# Is there an other way to avoid "- exec '/system/bin/sh' failed: No such file or directory (2) -" ?
PRODUCT_COPY_FILES += \
    $(DEVICE_DIR)/ramdisk/system/bin/sh:root/system/bin/sh

# libxlog
PRODUCT_PACKAGES += \
    libxlog
    
# Wifi
PRODUCT_PACKAGES += \
    libwpa_client \
    hostapd \
    dhcpcd.conf \
    wpa_supplicant \
    wpa_supplicant.conf
PRODUCT_COPY_FILES += \
    $(DEVICE_DIR)/configs/hostapd/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
    $(DEVICE_DIR)/configs/hostapd/hostapd.accept:system/etc/hostapd/hostapd.accept \
    $(DEVICE_DIR)/configs/hostapd/hostapd.deny:system/etc/hostapd/hostapd.deny

	
# libbt-vendor
PRODUCT_PACKAGES += \
    libbt-vendor

# libdashplayer # ?
#PRODUCT_PACKAGES += \
#    libdashplayer

