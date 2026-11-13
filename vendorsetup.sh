#!/bin/bash
# OrangeFox Build Setup for Xiaomi 10 Lite Zoom (vangogh)

# 检查当前设备代号，防止在其他机型上误编译
FDEVICE="vangogh"
if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then

    # --- 维护者与版本信息 ---
    export OF_MAINTAINER="你的名字"
    
    # --- UI 屏幕参数 (完全基于你刚才用 adb 查出来的精准数据) ---
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

    # --- 指纹伪装 (可选，但这能让刷机包校验更顺滑) ---
    export OF_TARGET_FINGERPRINT="Xiaomi/vangogh/vangogh:12/RKQ1.200826.002/V13.0.9.0.SJVCNXM:user/release-keys"

    # --- 强制开启解密库 (关键！) ---
    # 很多编译脚本会遗漏这个，加上这行确保 OF 能解密 FBE
    export FOX_USE_SPECIFIC_MAGISK_ZIP=""

fi
