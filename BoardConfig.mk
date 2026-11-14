DEVICE_PATH := device/xiaomi/vangogh

# 架构
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := kryo

# 平台
TARGET_BOARD_PLATFORM := sm7250

# 内核 (如果你在 Actions 中没有配置编译内核，需要把预编译内核放在这里)
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz-dtb

# Recovery 专属配置
RECOVERY_VARIANT := orangefox
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
TARGET_OTA_ASSERT_DEVICE := vangogh

# 屏幕与 UI
TW_THEME := portrait_hdpi
TW_SCREEN_WIDTH := 1080
TW_SCREEN_HEIGHT := 2400

# 核心功能开关 (解密与分区)
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_HAS_FASTBOOTD := true
TW_INCLUDE_NTFS_3G := true
TW_HAS_MTP := true
TW_USE_TOOLBOX := true
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1023
