export SDKVERSION = 14.5
export ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = HelloRune

$(BUNDLE_NAME)_FILES = Tweak.x
$(BUNDLE_NAME)_CFLAGS = -fobjc-arc
$(BUNDLE_NAME)_LIBRARIES = substrate
$(BUNDLE_NAME)_INSTALL_PATH = /Library/Application Support/Rune/Plugins

include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
