# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

### [10.0.2](https://github.com/JagandeepBrar/LunaSea/compare/v10.0.1...v10.0.2) (2022-04-12)


### Features

* **account:** ability to update account email and password ([5ea6269](https://github.com/JagandeepBrar/LunaSea/commit/5ea6269bca9cc21f9a3ec34ff9840ea22384b717))
* **firebase:** allow building LunaSea without setting up Firebase [skip ci] ([d7431b1](https://github.com/JagandeepBrar/LunaSea/commit/d7431b110217ff868e662be4a34af656ca1d6515))
* **firebase:** conditionally load Firebase depending on the platform ([91f556d](https://github.com/JagandeepBrar/LunaSea/commit/91f556d07833c9be6a4d176d663e7889361b8ec2))
* **linux:** initial linux support ([12fab1d](https://github.com/JagandeepBrar/LunaSea/commit/12fab1d6c22104cbf18ff695b1c636cc48236126))
* **resources:** add link to build bucket [skip ci] ([64db574](https://github.com/JagandeepBrar/LunaSea/commit/64db574155182942dabbaffba5dbf43e0cca950c))
* **resources:** add link to information about build channels ([fb31aba](https://github.com/JagandeepBrar/LunaSea/commit/fb31aba7f9b2678736f2d9abacdbf244edd1048a))
* **ui:** ability to set background color on LunaBlock tiles [skip ci] ([e108cfb](https://github.com/JagandeepBrar/LunaSea/commit/e108cfbac5f5bb2a1cd7404af0a331fadba85612))
* **windows:** initial windows support ([313e05c](https://github.com/JagandeepBrar/LunaSea/commit/313e05c8f519ca0c17efbec3d0587418e712cb81))


### Bug Fixes

* **charts:** rollback to fl_charts@0.46.0 ([cc81ee7](https://github.com/JagandeepBrar/LunaSea/commit/cc81ee7f14adc49b84556224dfef54c735c54758))
* **database:** write to LunaSea parent folder on Linux and Windows ([6e89796](https://github.com/JagandeepBrar/LunaSea/commit/6e89796a15622f82759a6f8f02a82b1494ea1f8d))
* **desktop:** prevent flickering by waiting for window settings to apply ([5a2a9b7](https://github.com/JagandeepBrar/LunaSea/commit/5a2a9b780b94d27aa2005823e1a18e225970967f))
* **desktop:** set initial and minimum window sizes ([dd30c3a](https://github.com/JagandeepBrar/LunaSea/commit/dd30c3a0a32201a6503c81685dfdbc928a4aee90))


### Tweaks

* **flavor:** rename build flavors [skip ci] ([26cc258](https://github.com/JagandeepBrar/LunaSea/commit/26cc2585b28f17342caf034ef9ef76dad06eb474))
* **settings:** do not show version code [skip ci] ([ac807a8](https://github.com/JagandeepBrar/LunaSea/commit/ac807a8a01993939b86baad2dcb11e7d2a73e509))
* **ui:** remove usages of tab indentations [skip ci] ([d9e7009](https://github.com/JagandeepBrar/LunaSea/commit/d9e70090007b402d2596e09195da5324ac1aafd0))

### [10.0.1](https://github.com/JagandeepBrar/LunaSea/compare/v10.0.0...v10.0.1) (2022-03-25)


### Features

* **config:** support retrying entering encryption password on failure ([cd9a3d2](https://github.com/JagandeepBrar/LunaSea/commit/cd9a3d295e87b7d8987e508e6c77b02c1c5290f8))
* **filesystem:** rewrite filesystem interface for better compatibility ([4c60df5](https://github.com/JagandeepBrar/LunaSea/commit/4c60df5523b98da3a7f135bb26fa20b36ed653e9))
* **ios:** enable landscape support on iOS devices ([f8e6760](https://github.com/JagandeepBrar/LunaSea/commit/f8e676015c26f1e33f8680043663ea4f25dbc872))
* **web:** initial web support ([91e1fa0](https://github.com/JagandeepBrar/LunaSea/commit/91e1fa03d9fae7cf82d158f00587075b29c610ea))
* **window_manager:** rewrite window manager to be platform-safe ([d6aed6c](https://github.com/JagandeepBrar/LunaSea/commit/d6aed6c707ad75c0a02c3a4fa496ee6d8adeb55e))


### Bug Fixes

* **android:** prevent multiple splash screens from appearing on Android 12 ([26523e5](https://github.com/JagandeepBrar/LunaSea/commit/26523e58ed12c8789c5c2c0df8d9f6e75e719f11))
* **web:** set notification vapid key ([1ddcc27](https://github.com/JagandeepBrar/LunaSea/commit/1ddcc279dd6adf629a2f99939a567481e3675bd2))


### Tweaks

* **images:** guard and fallback image cache implementation ([601d82c](https://github.com/JagandeepBrar/LunaSea/commit/601d82cf89a22890d4197d10e1b74dbe110b0755))
* **platform:** guard usages of dart:io and dart:html for future compatibility ([c7bd62d](https://github.com/JagandeepBrar/LunaSea/commit/c7bd62de2ee5669b41e6ccbc5e706ecb237cbcac))
* **wake_on_lan:** refactor wake on LAN support, support loading API with dart:html ([403edc1](https://github.com/JagandeepBrar/LunaSea/commit/403edc16fb8188bba9bb6dd5b60a128dc8c2b0d4))

## [10.0.0](https://github.com/JagandeepBrar/LunaSea/tree/v10.0.0) (2022-03-12)


### Features

* **debug:** debug page for multiple UI elements ([80c5d21](https://github.com/JagandeepBrar/LunaSea/commit/80c5d2118a68129690cde5acbf70a23746d30acf))
* **http:** set User-Agent to "LunaSea/{version} {build}" ([420d11c](https://github.com/JagandeepBrar/LunaSea/commit/420d11c37188fe1d56d76b51b98325b384a45cff))
* **overseerr:** integrate request list and request tiles ([b7fc3c0](https://github.com/JagandeepBrar/LunaSea/commit/b7fc3c0a0fe917ca13513be74159af022c956465))
* **overseerr:** issues (de)serialization & list integration ([db4dfda](https://github.com/JagandeepBrar/LunaSea/commit/db4dfdaf9ca1976d1a6e4b0ebc451b2e0f08b19e))
* **overseerr:** serialized movie & tv objects ([2b778dc](https://github.com/JagandeepBrar/LunaSea/commit/2b778dc437559549df7404fa5266719979c3cce3))
* **settings:** add test build information to resources ([be2d3e6](https://github.com/JagandeepBrar/LunaSea/commit/be2d3e63c27dc8eb5f2f01740df02d23b75eec8e))
* **sonarr:** support for searching entire series for monitored episodes [skip ci] ([ba958b5](https://github.com/JagandeepBrar/LunaSea/commit/ba958b59a6445d422ae1ea9533f9a6ada188962b))
* **ui:** support skeleton-state loading on LunaBlock ([8ab5f80](https://github.com/JagandeepBrar/LunaSea/commit/8ab5f80d004ead52a40a69f33482f371fe0f8c8b))


### Bug Fixes

* **desktop:** handle pull-to-refresh drag action ([d38fc77](https://github.com/JagandeepBrar/LunaSea/commit/d38fc770d2de4c2e2471aa4b61f8c4eb231ee134))
* **firebase:** remove remaining references to crashlytics and analytics [skip ci] ([67afaa0](https://github.com/JagandeepBrar/LunaSea/commit/67afaa05f22163b95faff7be526c7a7ddbd5ac5e))
* **overseerr:** rehydrate missing cached media content when required after cache ejection ([b09353b](https://github.com/JagandeepBrar/LunaSea/commit/b09353ba6e35992ce90613a198f7eb39759522a1))
* **radarr:** localized strings and correctly display disk/root folder tiles ([490ecf6](https://github.com/JagandeepBrar/LunaSea/commit/490ecf60d1d2267a1e2a6677db8e58c0dea9e096))
* **radarr:** match file details to web GUI ([a42aa41](https://github.com/JagandeepBrar/LunaSea/commit/a42aa4109ecde42dd2226ee13d398ca09c66a4b3))
* **radarr:** prevent using preDB availability when adding movie ([9d71c1a](https://github.com/JagandeepBrar/LunaSea/commit/9d71c1ac9ae5505692c24c425be2ce22ae292a25))
* **tautulli:** set graph padding to theme-default padding ([1229e5e](https://github.com/JagandeepBrar/LunaSea/commit/1229e5ee5ba1534d3e694fb85657b79b7dfcbf78))


### Tweaks

* **flavor:** rename "internal" to "develop" ([5652cb0](https://github.com/JagandeepBrar/LunaSea/commit/5652cb04bc7a23292d0ea9d65d6e919218975905))
* **modules:** remove canonical module import file [skip ci] ([0cbd61e](https://github.com/JagandeepBrar/LunaSea/commit/0cbd61eac5c8e8675b3dd5702977c99e06ca81d5))
* **overseerr:** utilize JsonEnum generators in enum types [skip ci] ([76d530e](https://github.com/JagandeepBrar/LunaSea/commit/76d530ed0810724d9b61bb73b689d6afb23d4ebd))

---

Previous version changelogs are no longer available.