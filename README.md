[![Homepage](https://img.shields.io/badge/Homepage-LunaSea-red?style=for-the-badge&logo=html5&color=%234ECCA3&logoColor=white)](https://www.lunasea.app) &nbsp; [![Release](https://img.shields.io/badge/AppStore-v2.0.1%20(55)-red?style=for-the-badge&logo=app-store&color=%230D96F6&logoColor=white)](https://apps.apple.com/us/app/lunasea/id1496797802?ls=1) &nbsp; [![Subreddit](https://img.shields.io/reddit/subreddit-subscribers/LunaSeaApp?label=R%2FLunaSeaApp&logo=reddit&logoColor=white&style=for-the-badge)](https://www.reddit.com/r/LunaSeaApp) &nbsp; [![License](https://img.shields.io/github/license/LunaSeaApp/LunaSea?color=%23222222&style=for-the-badge&logo=github&logoColor=white)](https://github.com/LunaSeaApp/LunaSea/blob/master/LICENSE)

![LunaSea](https://www.lunasea.app/images/banner.png)

![Screenshot](https://www.lunasea.app/images/hero.png)

LunaSea is a fully-featured, open-source usenet manager built using the Flutter framework for mobile devices! LunaSea is focused on giving you a seamless experience between all of your usenet software.

Support for services include:
- Lidarr
- Radarr
- Sonarr
- SABnzbd
- NZBGet
- Newznab Indexer Searching
- ...and more coming soon!

LunaSea also comes with support for:
- Profiles for multiple instances of applications
- Backup and restore configuration from the filesystem

---

## Developing, Installing, &amp; Building (iOS)

#### Requirements

1. A MacOS Machine
2. An AppleID account (does not require developer account)
3. [Flutter Framework (Beta Channel)](https://flutter.dev/)
4. [XCode 11.4 or Higher](https://apps.apple.com/ca/app/xcode/id497799835?mt=12)
5. [Developer Certificate Configured](https://github.com/LunaSeaApp/LunaSea/wiki/Setup-of-Development-Certificate)

#### Developing

1. Clone the repository
    - `git clone git@github.com:LunaSeaApp/LunaSea.git`
2. Install the Flutter packages
    - `flutter pub get`
3. Start your simulator or plug in your device and ensure you have accepted it is a trusted device
4. Install LunaSea in development mode on your device or simulator
    - `flutter run` 

#### Installing

> Release builds can only be installed on physical devices

1. Clone the repository
    - `git clone git@github.com:LunaSeaApp/LunaSea.git`
2. Install the Flutter packages
    - `flutter pub get`
3. Plug in your device and ensure you have accepted it is a trusted device
4. Install a production version of the application on your device
    - `flutter run --release`

#### Building (.ipa)

1. Clone the repository
    - `git clone git@github.com:LunaSeaApp/LunaSea.git`
2. Install the Flutter packages
    - `flutter pub get`
3. Run `build_ipa` inside of the `scripts` folder
4. The IPA will be placed in the root of the project directory

---

## Developing, Installing, &amp; Building (Android)

#### Requirements

1. Android SDK/Android Studio Installed & Configured
2. [Flutter Framework (Beta Channel)](https://flutter.dev/)
3. [Keystore Configured](https://github.com/LunaSeaApp/LunaSea/wiki/Configure-Keystore)

#### Developing

1. Clone the repository
    - `git clone git@github.com:LunaSeaApp/LunaSea.git`
2. Install the Flutter packages
    - `flutter pub get`
3. Start your simulator or plug in your device and ensure you have enabled USB Debugging
4. Install LunaSea in development mode on your device or simulator
    - `flutter run` 

#### Installing

> Release builds can only be installed on physical devices

1. Clone the repository
    - `git clone git@github.com:LunaSeaApp/LunaSea.git`
2. Install the Flutter packages
    - `flutter pub get`
3. Plug in your device and ensure you have accepted it is a trusted device
4. Install a production version of the application on your device
    - `flutter run --release`

#### Building (.apk)

1. Clone the repository
    - `git clone git@github.com:LunaSeaApp/LunaSea.git`
2. Install the Flutter packages
    - `flutter pub get`
3. Run `flutter build apk --split-per-abi`
4. The APKs are located in:
    - `./build/app/outputs/apk/release/app-armeabi-v7a-release.apk`
    - `./build/app/outputs/apk/release/app-arm64-v8a-release.apk`
    - `./build/app/outputs/apk/release/app-x86_64-release.apk`
