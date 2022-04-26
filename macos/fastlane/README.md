fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Mac

### mac keychain_create

```sh
[bundle exec] fastlane mac keychain_create
```

Create the LunaSea Keychain

### mac keychain_delete

```sh
[bundle exec] fastlane mac keychain_delete
```

Delete the LunaSea Keychain

### mac keychain_setup

```sh
[bundle exec] fastlane mac keychain_setup
```

Setup the Keychain

### mac connect_appstore_connect

```sh
[bundle exec] fastlane mac connect_appstore_connect
```

Connect to App Store Connect

### mac build_app_package

```sh
[bundle exec] fastlane mac build_app_package
```

Build App Package for Direct Deployment

### mac build_app_store

```sh
[bundle exec] fastlane mac build_app_store
```

Build App Package for App Store

### mac build_disk_image

```sh
[bundle exec] fastlane mac build_disk_image
```

Build Disk Image for Direct Deployment

### mac deploy_appstore

```sh
[bundle exec] fastlane mac deploy_appstore
```

Deploy to App Store Connect

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
