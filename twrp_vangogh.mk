$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# 继承极简 device.mk
$(call inherit-product, device/xiaomi/vangogh/device.mk)

PRODUCT_DEVICE := vangogh
PRODUCT_NAME := twrp_vangogh
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := MI 10 Lite Zoom
PRODUCT_MANUFACTURER := Xiaomi
