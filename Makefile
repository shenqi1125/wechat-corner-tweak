TARGET := iphone:clang:latest:7.0
ARCHS = arm64
INSTALL_TARGET_PROCESSES = WeChat
include $(THEOS)/makefiles/common.mk
TWEAK_NAME = WeChatCorner
WeChatCorner_FILES = Tweak.x
WeChatCorner_CFLAGS = -fobjc-arc
WeChatCorner_FRAMEWORKS = UIKit CoreGraphics QuartzCore
include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += wechatcornerprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
