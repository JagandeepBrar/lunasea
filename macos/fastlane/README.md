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

### mac keychain_development

```sh
[bundle exec] fastlane mac keychain_development
```

Setup the Keychain for Development

### mac keychain_appstore

```sh
[bundle exec] fastlane mac keychain_appstore
```

Setup the Keychain for App Store Deployment

### mac keychain_direct

```sh
[bundle exec] fastlane mac keychain_direct
```

Setup the LunaSea Keychain for Direct Deployment

### mac connect_appstore_connect

```sh
[bundle exec] fastlane mac connect_appstore_connect
```

Connect to App Store Connect

### mac build_appstore

```sh
[bundle exec] fastlane mac build_appstore
```

Build App Package for App Store

### mac build_direct

```sh
[bundle exec] fastlane mac build_direct
```

Build App Package for Direct Deployment

### mac deploy_appstore

```sh
[bundle exec] fastlane mac deploy_appstore
```

Deploy to App Store Connect

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
