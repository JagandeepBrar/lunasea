# LunaSea &ndash; Usenet Manager for iOS

[![Homepage](https://img.shields.io/badge/Homepage-LunaSea-red?style=for-the-badge&logo=html5&color=%234ECCA3&logoColor=white)](https://www.lunasea.app) &nbsp; [![Release](https://img.shields.io/badge/AppStore-v2.0.0%20(333)-red?style=for-the-badge&logo=app-store&color=%230D96F6&logoColor=white)](https://apps.apple.com/us/app/lunasea/id1496797802?ls=1) &nbsp; [![License](https://img.shields.io/github/license/LunaSeaApp/LunaSea?color=%23222222&style=for-the-badge&logo=github&logoColor=white)](https://github.com/LunaSeaApp/LunaSea/blob/master/README.md)

![Screenshot](https://www.lunasea.app/images/hero.png)

---

## Developing, Installing, &amp; Building

#### Requirements

1. A MacOS Machine
2. An AppleID account (does not require developer account)
3. [Flutter Framework (Beta Channel)](https://flutter.dev/)
4. [XCode 11.4 or Higher](https://apps.apple.com/ca/app/xcode/id497799835?mt=12)

#### Developing

1. Clone the repository
    - `git clone git@github.com:LunaSeaApp/LunaSea.git`
2. Install the Flutter packages
    - `flutter pub get`
3. (Physical device development only) Follow the steps in the repository wiki to [setup your developer certificate](https://github.com/LunaSeaApp/LunaSea/wiki/Setup-of-Development-Certificate)
4. Start your simulator or plug in your device and ensure you have accepted it is a trusted device
5. Install LunaSea in development mode on your device or simulator
    - `flutter run` 

#### Installing

> Release builds can only be installed on physical devices

1. Clone the repository
    - `git clone git@github.com:LunaSeaApp/LunaSea.git`
2. Install the Flutter packages
    - `flutter pub get`
3. Follow the steps in the repository wiki to [setup your developer certificate](https://github.com/LunaSeaApp/LunaSea/wiki/Setup-of-Development-Certificate)
4. Plug in your device and ensure you have accepted it is a trusted device
5. Install a production version of the application on your device
    - `flutter run --release`

#### Building (.ipa)

1. Clone the repository
    - `git clone git@github.com:LunaSeaApp/LunaSea.git`
2. Install the Flutter packages
    - `flutter pub get`
3. Follow the steps in the repository wiki to [setup your developer certificate](https://github.com/LunaSeaApp/LunaSea/wiki/Setup-of-Development-Certificate)
4. Run `build_ipa` inside of the `scripts` folder
5. The IPA will be placed in the root of the project directory
