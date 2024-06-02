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
