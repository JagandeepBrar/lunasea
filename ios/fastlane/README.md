fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios keychain_create

```sh
[bundle exec] fastlane ios keychain_create
```

Create the LunaSea Keychain

### ios keychain_delete

```sh
[bundle exec] fastlane ios keychain_delete
```

Delete the LunaSea Keychain

### ios keychain_setup

```sh
[bundle exec] fastlane ios keychain_setup
```

Setup the Keychain

### ios connect_appstore_connect

```sh
[bundle exec] fastlane ios connect_appstore_connect
```

Connect to App Store Connect

### ios build_appstore

```sh
[bundle exec] fastlane ios build_appstore
```

Build App Package for App Store

### ios deploy_appstore

```sh
[bundle exec] fastlane ios deploy_appstore
```

Deploy to App Store Connect

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
