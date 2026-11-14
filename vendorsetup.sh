#!/bin/bash
FDEVICE="vangogh"
if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export OF_MAINTAINER="deepsleep-v3"
    export OF_SCREEN_H=2400
    export OF_STATUS_H=69
    export OF_STATUS_INDENT_LEFT=48
    export OF_STATUS_INDENT_RIGHT=48
    export OF_ALLOW_DISABLE_NAVBAR=1
    export OF_DEFAULT_TIMEZONE="Asia/Shanghai"
    export OF_QUICK_BACKUP_LIST="/boot;/data;"
    export OF_USE_GREEN_LED=0
    export OF_KEEP_DM_VERITY=1

    # 给底层解密库最高权限 (777)
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    find "$SCRIPT_DIR/recovery/root" -type f -exec chmod 777 {} \; 2>/dev/null
    find "$SCRIPT_DIR/recovery/root" -type d -exec chmod 777 {} \; 2>/dev/null
fi
