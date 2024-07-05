#/bin/bash

# ensure theos is installed
if [ -z "$THEOS" ] || [ ! -d "$THEOS" ]; then
	echo "[ERROR] Theos does not appear to be installed. Follow the steps at https://theos.dev/docs/installation to get it set up."
	exit 1
fi

# ask for plugin details

read -p "Enter plugin name: " plugin_name

if [ -z "$plugin_name" ]; then
	echo "[ERROR] Plugin name must not be empty."
	exit 1
fi

read -p "Enter plugin description: " plugin_description

if [ -z "$plugin_description" ]; then
	plugin_description="An awesome Rune plugin!"
fi

read -p "Enter plugin author: " plugin_author

if [ -z "$plugin_author" ]; then
	echo "[ERROR] Plugin author must not be empty."
	exit 1
fi

plugin_author_no_spaces=$(echo $plugin_author | sed 's/ //g')

read -p "Enter plugin identifier (e.g. com.example.myplugin): " plugin_identifier

if [ -z "$plugin_identifier" ]; then
	echo "[ERROR] Plugin identifier must not be empty."
	exit 1
fi

if [[ "$plugin_identifier" != "${plugin_identifier%[[:space:]]*}" ]]; then
	echo "[ERROR] Plugin identifier must not contain spaces."
	exit 1
fi

echo -e "\nA class name prefix is used to avoid class name conflicts with other software."
echo "It should be a unique string that is unlikely to be used by other plugins."
echo "For example, if your plugin is called 'MyRunePlugin', you could use 'MRP' as the class name prefix."
read -p "Enter class name prefix: " class_name_prefix

if [ -z "$class_name_prefix" ]; then
	class_name_prefix="ABC"
fi

plugin_name_no_spaces=$(echo $plugin_name | sed 's/ //g')

plugin_directory="$plugin_name_no_spaces"

if [ -d "$plugin_directory" ]; then
	echo "[ERROR] '$plugin_directory' directory already exists. Cannot continue."
	exit 1
fi

# create plugin directory and files

mkdir $plugin_directory

cat > $plugin_directory/control <<EOF
Name: $plugin_name
Package: $plugin_identifier
Description: $plugin_description
Author: $plugin_author
Maintainer: $plugin_author
Version: 1.0
Architecture: iphoneos-arm
Section: Tweaks
Depends: com.icraze.rune
EOF


cat > $plugin_directory/Makefile <<EOF
export SDKVERSION = 14.5
export ARCHS = arm64 arm64e

include \$(THEOS)/makefiles/common.mk

BUNDLE_NAME = $plugin_name_no_spaces

\$(BUNDLE_NAME)_FILES = Tweak.x
\$(BUNDLE_NAME)_CFLAGS = -fobjc-arc
\$(BUNDLE_NAME)_LIBRARIES = substrate
\$(BUNDLE_NAME)_INSTALL_PATH = /Library/Application Support/Rune/Plugins

include \$(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
EOF


cat > $plugin_directory/Tweak.x <<EOF
#import <UIKit/UIKit.h>

@interface BBRBasePanelView : UIView
@end

@interface ${class_name_prefix}PanelView : BBRBasePanelView
@end

%subclass ${class_name_prefix}PanelView : BBRBasePanelView
-(void)didMoveToWindow {
	%orig;

	// Create example label
	UILabel *label = [[UILabel alloc] init];
	[label setText:@"Hello, Rune!"];
	[label setTextColor:[UIColor whiteColor]];
	[label setFont:[UIFont boldSystemFontOfSize:24]];
	[label sizeToFit];
	[label setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)];
	[self addSubview:label];
}
%end
EOF


mkdir $plugin_directory/Resources

cat > $plugin_directory/Resources/$plugin_name_no_spaces.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>className</key>
	<string>${class_name_prefix}PanelView</string>
	<key>name</key>
	<string>$plugin_name</string>
	<key>icon</key>
	<string>hand.wave</string>
</dict>
</plist>
EOF

echo -e "\nPlugin has been created in the '$plugin_directory' directory."
