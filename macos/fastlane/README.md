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

### mac prepare_keychain

```sh
[bundle exec] fastlane mac prepare_keychain
```

Setup the LunaSea Keychain

### mac destroy_keychain

```sh
[bundle exec] fastlane mac destroy_keychain
```

Destroy the LunaSea Keychain

### mac build

```sh
[bundle exec] fastlane mac build
```

Build App Package

### mac deploy

```sh
[bundle exec] fastlane mac deploy
```

Deploy to App Store Connect

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
