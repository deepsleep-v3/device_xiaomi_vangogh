#!/bin/bash
# OrangeFox Build Setup for Xiaomi 10 Lite Zoom (vangogh)

FDEVICE="vangogh"
if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then

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

    # --- 指纹伪装 ---
    export OF_TARGET_FINGERPRINT="Xiaomi/vangogh/vangogh:12/RKQ1.200826.002/V13.0.9.0.SJVCNXM:user/release-keys"

    # --- 终极暴力赋权 (修复路径问题) ---
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    
    # 给解密库和所有文件最高权限，防止报错
    find "$SCRIPT_DIR/recovery/root" -type f -exec chmod 777 {} \; 2>/dev/null
    find "$SCRIPT_DIR/recovery/root" -type d -exec chmod 777 {} \; 2>/dev/null

fi