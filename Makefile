include $(THEOS)/makefiles/common.mk

ARCHS = arm64
BUNDLE_NAME = WeChatCornerPrefs
WeChatCornerPrefs_FILES = WeChatCornerPrefsListController.mm
WeChatCornerPrefs_INSTALL_PATH = /Library/PreferenceBundles
WeChatCornerPrefs_FRAMEWORKS = UIKit
WeChatCornerPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk
