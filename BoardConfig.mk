# inherit from the proprietary version
-include vendor/acer/a510/BoardConfigVendor.mk

TARGET_BOOTLOADER_BOARD_NAME := picasso_m
TARGET_OTA_ASSERT_DEVICE := picasso_m,a510_pa_cus1

# Kernel defconfig
TARGET_KERNEL_CONFIG := cyanogenmod_picasso_m_defconfig

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/acer/a510/bluetooth

# Inherit from t30-common
include device/acer/t30-common/BoardConfigCommon.mk
