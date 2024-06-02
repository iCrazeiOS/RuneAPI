# Rune Developer API

#### For extending the functionality of [Rune](https://havoc.app/package/rune)

Requirements: [Theos](https://theos.dev/docs/installation)

## Getting Started

1. Start by cloning this repo to your machine

2. Run `plugin-gen.sh` to create a new plugin. It will ask you for some details before setting up the project.

![Screenshot of plugin-gen](https://github.com/iCrazeiOS/RuneAPI/assets/39101269/93ff1fa7-da0e-46ae-b64d-4330e673285b)

3. `cd` into the newly created directory and compile the plugin using `make package`. If you are compiling for a rootless jailbreak, append `THEOS_PACKAGE_SCHEME=rootless` to the command.

4. If the compilation was successful, you should have a `.deb` file in the `packages` directory. After installing the package and respringing, it should appear within Rune's panel selection.

![Screenshot of a successful compilation](https://github.com/iCrazeiOS/RuneAPI/assets/39101269/4b0b714b-6e25-4da9-b0a7-1cb49a16ff71)

![Screenshot of Rune's panel list](https://github.com/iCrazeiOS/RuneAPI/assets/39101269/478ff06f-54bc-46d3-bb3f-2fa627e0ce87)

After enabling the plugin, you should see its panel show up within Rune.

![Screenshot of the plugin in action](https://github.com/iCrazeiOS/RuneAPI/assets/39101269/638fe62d-3741-4607-b5ab-188d610ffed0)


## Programming

Now that you have a plugin set up, you can edit `Tweak.x` to build your UI and add functionality.

The `plugin-gen.sh` script creates a subclass of BBRBasePanelView for you automatically. This is the class that you should use to build your panel.

The `didMoveToWindow` method is called when the panel is (re)loaded by Rune. Use this to set up your panel's UI and any other initialisation code.

As each plugin is a Substrate tweak, you can hook methods just like you would in any other tweak.


## NSNotificationCenter

Rune uses NSNotificationCenter to communicate with plugins. You can listen for notifications by adding an observer in your panel's `didMoveToWindow` method.

Here is an example of how to listen for the `com.icraze.rune-opened` notification, to call a method named `updatePanel` whenever Rune is presented:

```objc
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePanel) name:@"com.icraze.rune-opened" object:nil];
```

Available notifications:

`com.icraze.rune-opened` - Fired when Rune is presented

`com.icraze.rune-closed` - Fired when Rune is dismissed


## Other Info

The `icon` field within the plugin's plist must be the name of an [SF Symbol](https://developer.apple.com/design/human-interface-guidelines/sf-symbols). Be sure to choose a symbol that is available on iOS 14 and above, as Rune supports these versions.