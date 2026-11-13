#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from sm7250-common
include device/xiaomi/sm7250-common/BoardConfigCommon.mk

DEVICE_PATH := device/xiaomi/vangogh

BUILD_BROKEN_DUP_RULES := true

# Display
TARGET_SCREEN_DENSITY := 440

# Kernel
TARGET_KERNEL_CONFIG := vendor/vangogh_user_defconfig

# Inherit from the proprietary version
include vendor/xiaomi/vangogh/BoardConfigVendor.mk

TARGET_KERNEL_LLVM_BINUTILS := false
TARGET_KERNEL_CLANG_VERSION := vangogh
# ================= OrangeFox Recovery 专属配置 =================
# 告诉编译器：别编 TWRP 了，我要编橙狐！
RECOVERY_VARIANT := orangefox

# 设定你的机型代号，防止小白乱刷变砖
TARGET_OTA_ASSERT_DEVICE := vangogh

# 使用触摸屏 Recovery 主题（分辨率适配）
TW_THEME := portrait_hdpi

# 动态分区（Dynamic Partitions）和 A-only 必备
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
TW_HAS_FASTBOOTD := true

# 修复解密和挂载问题
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_FUSE_EXFAT := true
TW_HAS_MTP := true
