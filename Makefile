
PWD=$(shell pwd)
AAP_JUCE_DIR=$(PWD)/external/aap-juce

# Specify the app name. It will show up as the Main Launcher.
APP_NAME=DuskAudioPlugins

APP_BUILD_DIR=$(PWD)
# Specify the app repo as a submodule
APP_SRC_DIR=$(PWD)/external/dusk-audio-plugins
# dusk-audio-plugins does not contain JUCE; we have our own submodule (passed as JUCE_PATH in app/build.gradle).
JUCE_DIR=$(PWD)/external/JUCE

# The app contains many plugins, and there is no app icon in the source tree either.
#APP_ICON=

# It can be any name, just make sure you generate the diff for AAP support,
# otherwise it will only build for Android without AAP.
# Make sure to include submodule changes (by e.g. git diff --submodule=diff)
PATCH_FILE=$(PWD)/aap-juce-support.patch
PATCH_DEPTH=1

# JUCE patches if any
# standalone-aap-factory-weak-fallback.patch defines the plugin factory entrypoint, which conflicts with the default patch.
AAP_JUCE_CMAKE_SKIP_DEFAULT_PATCHES=1
# The app contains more than one JUCE plugin library, so the ComponentPeerView patch has to be applied
# to the embedded byte-code too (see aap-juce docs/JUCE_GUI_SUPPORT.md).
JUCE_PATCHES= \
	$(AAP_JUCE_DIR)/juce-patches/8.0.12/export-jni-symbols.patch \
	$(AAP_JUCE_DIR)/juce-patches/8.0.12/support-plugin-ui.patch \
	$(AAP_JUCE_DIR)/juce-patches/8.0.12/disable-detach-current-thread.patch \
	$(AAP_JUCE_DIR)/juce-patches/8.0.12/embedded-peer-window-guard.patch \
	$(AAP_JUCE_DIR)/juce-patches/8.0.12/juce-component-peer-view-touch.patch \
	$(AAP_JUCE_DIR)/juce-patches/8.0.15/juce-component-peer-view-touch-bytecode.patch \
	$(AAP_JUCE_DIR)/juce-patches/8.0.12/popup-menu-android.patch \
	$(AAP_JUCE_DIR)/juce-patches/8.0.15/popup-menu-lightweight-android.patch \
	$(AAP_JUCE_DIR)/juce-patches/8.0.12/standalone-aap-factory-weak-fallback.patch

include $(AAP_JUCE_DIR)/Makefile.cmake-common
