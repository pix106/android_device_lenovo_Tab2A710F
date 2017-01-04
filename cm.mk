# Release name
PRODUCT_RELEASE_NAME := Tab2A710F

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

# Inherit device configuration
$(call inherit-product, device/lenovo/Tab2A710F/full_Tab2A710F.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := Tab2A710F
PRODUCT_NAME := cm_Tab2A710F
PRODUCT_BRAND := lenovo
PRODUCT_MODEL := Tab2A710F
PRODUCT_MANUFACTURER := lenovo
PRODUCT_RELEASE_NAME := Tab2A710F

TARGET_SCREEN_WIDTH := 600
TARGET_SCREEN_HEIGHT := 1024

