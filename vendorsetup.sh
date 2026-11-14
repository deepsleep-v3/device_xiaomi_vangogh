#!/bin/bash
# OrangeFox Build Setup for Xiaomi 10 Lite Zoom (vangogh)

FDEVICE="vangogh"
if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then

    # =====================================================================
    # 自动补齐缺失的公共设备树 (sm7250-common)
    # =====================================================================
    COMMON_TREE_DIR="device/xiaomi/sm7250-common"
        # 直接使用官方 PE 的原版公共树
    COMMON_TREE_URL="https://github.com/PixelExperience-Devices/device_xiaomi_sm7250-common.git"
    
    if [ ! -d "$COMMON_TREE_DIR" ]; then
        echo ">>> 发现缺失 sm7250-common，正在自动拉取..."
        git clone "$COMMON_TREE_URL" -b thirteen "$COMMON_TREE_DIR"
    fi
    # =====================================================================

    # --- 维护者与版本 ---
    export OF_MAINTAINER="deepsleep-v3"

    # --- UI 屏幕参数 ---
    export OF_SCREEN_H=2400
    export OF_STATUS_H=69
    export OF_STATUS_INDENT_LEFT=48
    export OF_STATUS_INDENT_RIGHT=48
    export OF_ALLOW_DISABLE_NAVBAR=1
    export OF_DEFAULT_TIMEZONE="Asia/Shanghai"

    # --- 功能设置 ---
    export OF_QUICK_BACKUP_LIST="/boot;/data;"
    export OF_USE_GREEN_LED=0
    export OF_KEEP_DM_VERITY=1
    export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
    export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1

    # --- 终极暴力赋权 (确保解密库能跑) ---
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    find "$SCRIPT_DIR/recovery/root" -type f -exec chmod 777 {} \; 2>/dev/null
    find "$SCRIPT_DIR/recovery/root" -type d -exec chmod 777 {} \; 2>/dev/null

fi