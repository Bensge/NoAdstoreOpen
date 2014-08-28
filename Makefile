TARGET=:clang
ARCHS=armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = NoAdstoreOpen
NoAdstoreOpen_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "launchctl stop com.apple.SpringBoard"