# 只拷贝 Recovery 专用的 fstab
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/etc/recovery.fstab:$(TARGET_RECOVERY_ROOT_OUT)/system/etc/recovery.fstab

# 注意：recovery/root 目录下的所有文件（如解密库和 rc 脚本），
# 会被 TWRP/OF 的编译系统自动打包进 ramdisk，无需在这里声明 COPY。
