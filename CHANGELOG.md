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
* **filesystem:** rewrite filesystem interface for better compatability ([4c60df5](https://github.com/JagandeepBrar/LunaSea/commit/4c60df5523b98da3a7f135bb26fa20b36ed653e9))
* **ios:** enable landscape support on iOS devices ([f8e6760](https://github.com/JagandeepBrar/LunaSea/commit/f8e676015c26f1e33f8680043663ea4f25dbc872))
* **web:** initial web support ([91e1fa0](https://github.com/JagandeepBrar/LunaSea/commit/91e1fa03d9fae7cf82d158f00587075b29c610ea))
* **window_manager:** rewrite window manager to be platform-safe ([d6aed6c](https://github.com/JagandeepBrar/LunaSea/commit/d6aed6c707ad75c0a02c3a4fa496ee6d8adeb55e))


### Bug Fixes

* **android:** prevent multiple splash screens from appearing on Android 12 ([26523e5](https://github.com/JagandeepBrar/LunaSea/commit/26523e58ed12c8789c5c2c0df8d9f6e75e719f11))
* **web:** set notification vapid key ([1ddcc27](https://github.com/JagandeepBrar/LunaSea/commit/1ddcc279dd6adf629a2f99939a567481e3675bd2))


### Tweaks

* **images:** guard and fallback image cache implementation ([601d82c](https://github.com/JagandeepBrar/LunaSea/commit/601d82cf89a22890d4197d10e1b74dbe110b0755))
* **platform:** guard usages of dart:io and dart:html for future compatability ([c7bd62d](https://github.com/JagandeepBrar/LunaSea/commit/c7bd62de2ee5669b41e6ccbc5e706ecb237cbcac))
* **wake_on_lan:** refactor wake on LAN support, support loading API with dart:html ([403edc1](https://github.com/JagandeepBrar/LunaSea/commit/403edc16fb8188bba9bb6dd5b60a128dc8c2b0d4))

## [10.0.0](https://github.com/JagandeepBrar/LunaSea/compare/v6.0.1...v10.0.0) (2022-03-12)


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

### [6.0.1](https://github.com/JagandeepBrar/LunaSea/compare/v6.0.0...v6.0.1) (2022-01-25)


### Features

* **dev:** adopt standard-version for changelog generation ([#602](https://github.com/JagandeepBrar/LunaSea/issues/602)) ([c189fb3](https://github.com/JagandeepBrar/LunaSea/commit/c189fb3632aaa84ce51b3f86cd3308e9b67fce74))
* **development:** integrate Husky, Commitizen, and Conventional Changelog ([fd8e061](https://github.com/JagandeepBrar/LunaSea/commit/fd8e061a81ee93a2bb3476a293f116dd69e472be))
* **env:** Load environment at build-time ([#578](https://github.com/JagandeepBrar/LunaSea/issues/578)) ([1d0f2ab](https://github.com/JagandeepBrar/LunaSea/commit/1d0f2ab3873380d178b17fce8c1854d88d179384))


### Bug Fixes

* **cache:** support stash_memory 4.0.0 typings ([63572f1](https://github.com/JagandeepBrar/LunaSea/commit/63572f18b052a30487fea697f3283d3ffbdc73ce))
* **changelog:** Do not show the changelog unless it is a production release ([5f9d590](https://github.com/JagandeepBrar/LunaSea/commit/5f9d59087ea2ed120afc4a398ba9a4754d5d8f2b))
* **ci:** (Android) Do not send metadata on alpha build, new lane for metadata ([#562](https://github.com/JagandeepBrar/LunaSea/issues/562)) ([5093b10](https://github.com/JagandeepBrar/LunaSea/commit/5093b10d0cd3bffc1cdbed2481b1791dd1088d65))
* **ci:** (Android) Set version name to build number ([836a5a5](https://github.com/JagandeepBrar/LunaSea/commit/836a5a5b32842bd1510f85f339d15fc79942ba42))
* **ci:** (Android) Use commit hash for version naming ([8ada02b](https://github.com/JagandeepBrar/LunaSea/commit/8ada02bf83f2e15207c35100dd93b5eff47d7a9d))
* **ci:** (macOS) Remove app.lunasea.lunasea.ImageNotification identifier ([95695b5](https://github.com/JagandeepBrar/LunaSea/commit/95695b53d1dd91e7be5d06c84e05fd15e7053141))
* **ci:** (macOS) Set additional signing certificates ([3f1f727](https://github.com/JagandeepBrar/LunaSea/commit/3f1f727c8cb2865f929ad9b4557f66f1ee9a6357))
* **ci:** (macOS) Set FLAVOR and VERSION as inputs to workflow call ([3717ba0](https://github.com/JagandeepBrar/LunaSea/commit/3717ba097490fa588cb2ced3644433647bd8a44c))
* **ci:** Correctly cache iOS pods ([03c9a32](https://github.com/JagandeepBrar/LunaSea/commit/03c9a3254a378bfc8ac9d34c7eaafca4266bdd6c))
* **ci:** Correctly pass secrets to worker workflows ([9fd52b2](https://github.com/JagandeepBrar/LunaSea/commit/9fd52b236f5e86061e0d1506356463561e864002))
* **ci:** Correctly pull and set Git commit hash ([ad190b1](https://github.com/JagandeepBrar/LunaSea/commit/ad190b153ed86a2da06f8f39353d74dda06517f4))
* **ci:** Do not pass values via environment to prevent leakage ([388cefa](https://github.com/JagandeepBrar/LunaSea/commit/388cefab0420f87dcc097db970d6b7cd76ef16f8))
* **ci:** Fix CI instabilities ([#561](https://github.com/JagandeepBrar/LunaSea/issues/561)) ([7969f56](https://github.com/JagandeepBrar/LunaSea/commit/7969f56bf9469d217daa0c109daf07fb263906c4))
* **ci:** Improve artifact naming legibility ([ea5e6d1](https://github.com/JagandeepBrar/LunaSea/commit/ea5e6d16aca0a1fa414e315874c8e4fd89356d5b))
* **ci:** Lock cancel-workflow-action to v0.9.1 ([5993446](https://github.com/JagandeepBrar/LunaSea/commit/5993446c4ebf670e671cf5ef371ea0dcff93a124))
* **ci:** Move Discord update workflow into jobs to prevent depth errors ([8ac4e38](https://github.com/JagandeepBrar/LunaSea/commit/8ac4e388a4aefcd92f2518510c76dc579fe7741d))
* **ci:** Pass DISCORD_WEBHOOK secret to action ([0300f27](https://github.com/JagandeepBrar/LunaSea/commit/0300f277c94e877a34947fcb4f72bea7cae4c304))
* **ci:** Pass FLAVOR and VERSION parameters as inputs instead of secrets ([851bace](https://github.com/JagandeepBrar/LunaSea/commit/851baceb9ee4cb56a167d6eb807dab4604e45f70))
* **ci:** Remove asset caching from workflows ([9c36c43](https://github.com/JagandeepBrar/LunaSea/commit/9c36c43ba36bbc8d0035cf8a4a33474c92105b7c))
* **ci:** Remove Blackbox ([#571](https://github.com/JagandeepBrar/LunaSea/issues/571)) ([b326730](https://github.com/JagandeepBrar/LunaSea/commit/b32673091a3c306f1791fee4dc261b842a8ea8bc))
* **ci:** Remove option to build "develop" flavor ([d42d729](https://github.com/JagandeepBrar/LunaSea/commit/d42d729aa7095ea3bb39e7f4926cc463d6060fc7))
* **ci:** Set as default keychain when using CI ([3834169](https://github.com/JagandeepBrar/LunaSea/commit/38341691a5c1554460bf20fba63a84fa60e7b205))
* **ci:** Set correct Discord action ([75e26d8](https://github.com/JagandeepBrar/LunaSea/commit/75e26d8e493aba2c9c5451caa2ff6161a78e64cc))
* **ci:** Set uses key before needs/if ([be5f6d1](https://github.com/JagandeepBrar/LunaSea/commit/be5f6d18db09e4dd8db1aad2fce078af8e4080a2))
* **ci:** Shorten job titles ([cccfc82](https://github.com/JagandeepBrar/LunaSea/commit/cccfc82bb5f9eb70fee4d45605c1278b8ba1c519))
* **ci:** Typo in beta workflow title ([4be37c7](https://github.com/JagandeepBrar/LunaSea/commit/4be37c71eb920e6c1056d0bf51c8f9236320b054))
* **ci:** Use ANSI C quoting for flavor set ([7906cd7](https://github.com/JagandeepBrar/LunaSea/commit/7906cd716ce5de24db1047a4a40f90360005b561))
* **config:** Prevent database from being unloaded from memory on clear ([cff45fc](https://github.com/JagandeepBrar/LunaSea/commit/cff45fcf461dee39168832bc9d2f71cf7a19e6c7))
* **dart:** Delete all .g.dart generated files ([d3c8110](https://github.com/JagandeepBrar/LunaSea/commit/d3c8110c2f8df220d55dc3c7149d6a22edfd0844))
* **dashboard:** (Calendar) Correctly type check in marker builder ([#559](https://github.com/JagandeepBrar/LunaSea/issues/559)) ([a31a70c](https://github.com/JagandeepBrar/LunaSea/commit/a31a70c58a1aec029d1e285063e2ae44bab9021e))
* **fastlane:** Lane to prepare keychain for development ([a4c26f8](https://github.com/JagandeepBrar/LunaSea/commit/a4c26f80387177e9396aa7e846c4028e04b4271c))
* **flavor:** Change "develop" to "internal" ([b9032cb](https://github.com/JagandeepBrar/LunaSea/commit/b9032cb486325d3f7b0f02781f37e3b4d8cb25f8))
* **flavor:** Set default flavor to "internal" ([5fd49be](https://github.com/JagandeepBrar/LunaSea/commit/5fd49be1ff13abf24aef3898458e019a5eb795b0))
* **macos:** Re-enable quit-on-hide ([72cbfb7](https://github.com/JagandeepBrar/LunaSea/commit/72cbfb759af034538c232a1d607ba720574cbcac))
* **navbar:** Revert Navigation Bar to Original ([#558](https://github.com/JagandeepBrar/LunaSea/issues/558)) ([8ecc7e4](https://github.com/JagandeepBrar/LunaSea/commit/8ecc7e469bebc865026747a3744825600525c344))
* **shaders:** Rebuild SkSL shaders ([87b0a0e](https://github.com/JagandeepBrar/LunaSea/commit/87b0a0ef8ff2eef0dbd09d1726003795f973ab6f))
* **tautulli:** (History) Correctly pass session or reference id ([#598](https://github.com/JagandeepBrar/LunaSea/issues/598)) ([e243bf5](https://github.com/JagandeepBrar/LunaSea/commit/e243bf564f5247bea37b7c56082ff2f6694b11e2))
* **window:** Correctly set window minimum and default window size ([#549](https://github.com/JagandeepBrar/LunaSea/issues/549)) ([8abffca](https://github.com/JagandeepBrar/LunaSea/commit/8abffca0a0cf7f43cf8089efab20065fb1c1992a))
* **workflows:** Improve quality of alpha build workflows ([3778189](https://github.com/JagandeepBrar/LunaSea/commit/3778189eadf4318c59ea6938164d1eec85933fcc))

## 6.0.0


### Features

* **Dashboard:** (Calendar) Display content poster and additional information
* **Dashboard:** (Calendar) Add option to show past days in schedule view
* **Dashboard:** (Calendar) Use different marker colours depending on how much content is missing
* **Lidarr:** (Add Artist) Long-press result tile to view Discogs page
* **Lidarr:** (Add Artist) Show artist poster in result list
* **Lidarr:** (Add Artist) Allow user to select monitoring options
* **Lidarr:** (Add Artist) Removed toggle to use album folders
* **Lidarr:** (Catalogue) Show artist poster in catalogue list
* **Lidarr:** (Missing) Display album covers
* **Notifications:** (Priority) Support time-sensitive notifications
* **Settings:** (Account) Ability to delete your LunaSea account and all cloud data
* **Settings:** (Configuration) Show dismissible blocks with information and links
* **Settings:** (Network) Ability to enable TLS certificate validation
* **Settings:** (Radarr) Ability to set default catalogue view
* **Settings:** (Sonarr) Removed toggle to enable v3 features
* **Settings:** (Sonarr) Ability to set default catalogue view
* **Settings:** (Sonarr) Ability to set default filtering method
* **Settings:** (Sonarr) Ability to set queue fetch size
* **Settings:** (System) Ability to clear image cache
* **Radarr:** (Catalogue) Grid view support
* **Radarr:** (Catalogue) Expand search bar on focus
* **Sonarr:** (Catalogue) Grid view support
* **Sonarr:** (Catalogue) Expand search bar on focus
* **Sonarr:** (Catalogue) Many additional sorting and filtering options
* **Sonarr:** (Episodes) Entirely revamped details view
* **Sonarr:** (Episodes) View media info for downloaded episodes
* **Sonarr:** (Episodes) View history for a single episode
* **Sonarr:** (Episodes) View active queued releases for a single episode
* **Sonarr:** (Season Details) View history for a single season
* **Sonarr:** (Series Details) View history for a single series
* **Sonarr:** (History) Now an infinite scrolling list
* **Sonarr:** (History) Tiles are now expandable tiles with much more detail
* **Sonarr:** (Home) "History" tab has been replaced with a "More" tab
* **Sonarr:** (Season List) Display season posters
* **Sonarr:** (Queue) Option to set queue page size
* **Sonarr:** (Releases) Ability to set default filtering method
* **Sonarr:** (Releases) Now shows preferred word score
* **System:** (Analytics) Completely removed Firebase Analytics
* **System:** (Analytics) Completely removed Firebase Crashlytics
* **System:** (Images) Cache fetched images to disk
* **UI/UX:** (Icons) Added/updated brand icons for Lidarr, Sonarr, and Overseerr
* **UI/UX:** (Tile Blocks) Allow overflowing title or body lines to be horizontally scrolled


### Bug Fixes

* **Dashboard:** (Calendar) Only show type switcher icon when on the calendar page
* **Lidarr:** (Artists) Safe-guard fetching of artist quality profiles
* **Radarr:** (Add Movie) Removed ability to set PreDB or TBA minimum availability
* **Radarr:** (Edit Movie) Removed ability to set PreDB or TBA minimum availability
* **Radarr:** (Files) Failed to load when files have no media information
* **Radarr:** (Releases) Negative custom word scores would be incorrectly displayed
* **Settings:** (Calendar) Starting type would have incorrect icons
* **Settings:** (Notifications) Overseerr would not be displayed
* **Sonarr:** (API) Now only utilizes v3 API routes
* **Sonarr:** (Catalogue) Missing filter would fail to load when using Sonarr v4
* **Sonarr:** (Edit Series) Vastly speed up response time on submitting updates
* **Sonarr:** (Missing) Air date would show in days for very old content
* **Sonarr:** (Queue) Check monitored download status on pull to refresh
* **Sonarr:** (Season List) Correctly calculate the available episode count
* **System:** Update packages
* **System:** Upgrade to Firebase SDK v8.9.0
* **System:** TLS v1.3 is now fully supported
* **Tautulli:** (Activity) Activity counter badge would not completely fade away
* **Tautulli:** (Check for Updates) Checking for updates could fail in some cases
* **UI/UX:** (Bottom Sheet) Tightly size all bottom sheets to the content
* **UI/UX:** (List View) Make padding around the end of infinite list loaders and icons more consistent
* **UI/UX:** (Popup Menu) Positioning could get unaligned or broken if opened in specific views
* **UI/UX:** (Router) Slide transitions between pages could not occur on some devices
* **UI/UX:** (Snackbar) Snackbar would not be shown in some cases
* **UI/UX:** (Theme) Removed deprecated theme values


### Tweaks

* **Dashboard:** (Modules) Always use module's brand colour for module list
* **UI/UX:** (Drawer) Use module's brand colour for highlighted colour
* **UI/UX:** (Drawer) Heavily reduced the size of the header area
* **UI/UX:** (Drawer) Use the primary colour as the background colour
* **UI/UX:** (Fonts) Normalized font sizes across the UI
* **UI/UX:** (Icons) Ensure all icons are of the "rounded" family
* **UI/UX:** (Icons) Replace custom icons (except branding icons) with Flutter defaults
* **UI/UX:** (Images) Set the default image opacity to 20% (custom set values are unaffected)
* **UI/UX:** (Tile Blocks) Heavily improved build and memory performance of tiles
* **UI/UX:** (Tile Blocks) Improved consistency in trailing icon/text size
* **UI/UX:** (Tile Blocks) Improved consistency of tile height, content spacing, and padding
* **UI/UX:** (Tile Blocks) Natively draw placeholder posters for movies, series, albums, etc.
* **UI/UX:** (Tile Blocks) Fade-in background image loads
* **UI/UX:** (Tooltips) Added styling to match LunaSea theme

## 5.1.0


### Features

* **Dashboard:** (Modules) Show Wake on LAN tile
* **Drawer:** Ability to customize the order of modules
* **External Modules:** Ability to add and view external modules
* **Performance:** Build LunaSea with pre-compiled SkSL shaders


### Bug Fixes

* **Flutter:** Update packages
* **Flutter:** Upgrade to Firebase SDK v7.11.0
* **Locale:** Ensure that the date formatter uses the currently set locale
* **Radarr:** (Manual Import) Could not select movie when using Radarr v3.1.0+
* **Search:** Indexers would not load in some cases when the headers map was null/empty
* **Settings:** (Connection Test) Connection tests could fail unexpectedly
* **Settings:** (Dialogs) Ensure all bulleted lists in dialogs are left aligned
* **Sonarr:** (Edit) Grey screen could be shown when a user has no tags
* **Sonarr:** (Edit) Grey screen could be shown when a user has no language profiles
* **Tautulli:** (Graphs) Line chart tooltips had incorrect data
* **UI/UX:** Popup menus were not aligned correctly
* **UI/UX:** (Buttons) Border would incorrectly be applied to buttons with a background colour set
* **UI/UX:** (ListView) Vertical padding did not match horizontal padding


### Tweaks

* **Dashboard:** (Calendar) Add divider between calendar and calendar entries
* **Dashboard:** (Modules) Synchronize module ordering with drawer ordering
* **Drawer:** Default to sorting modules alphabetically
* **Settings:** (Configuration) Alphabetically sort the modules

### 5.0.1


### Bug Fixes

* **iOS:** LunaSea would hard crash on startup on iOS 12 or lower devices

## 5.0.0


### Features

* **-arr:** (Content Details) Added a button to the AppBar to jump directly into the edit page
* **-arr:** (Releases) Match torrent seeder colours to the web GUI
* **Android:** Attach module headers to requests when viewing the web GUI
* **Android:** Set status and navigation bar colours to match LunaSea
* **Dashboard:** "Home" has been renamed to "Dashboard"
* **Logger:** Utilize a new, custom built on-device logging system
* **Logger:** Compact/delete old log entries once the log count passes 100
* **Logger:** Exported logs are now in JSON format
* **Logger:** Switch to Firebase Crashlytics from Sentry for crash and log monitoring
* **Logger:** Added Firebase Analytics for breadcrumb tracking in crashes
* **Notifications:** Support for webhook-based rich push notifications
* **NZBGet:** (Queue) Add category to the queue tile
* **Quick Actions:** Default "Settings" quick action added to end of the list (if there is room)
* **Radarr:** Completely rewritten from the ground-up
* **Radarr:** (Catalogue) If no movie is found in the search query, given an option to search to add the movie
* **Radarr:** (Discover) Ability to discover movies from your import lists & Radarr recommendations
* **Radarr:** (Filtering/Sorting) Many additional filtering and sorting options
* **Radarr:** (History) Now an infinite scrolling list
* **Radarr:** (Manual Import) Ability to manually import content from the filesystem
* **Radarr:** (Movie) Cast information, movie-specific history, more detailed file information, & more detailed overview page
* **Radarr:** (Queue) View, update, and manage items in the queue
* **Radarr:** (System Status) Page to view status, health, and disk spaces
* **Radarr:** (Tags) Manage, set, and delete tags
* **SABnzbd:** (Queue) Add category to the queue tile
* **Search:** (Results) Show clickable comment and download links in the expanded table
* **Search:** (Results) Now supports infinite scrolling for loading additional pages of results
* **Settings:** (Notifications) Added page to setup webhook-based push notifications
* **Settings:** (Radarr) Ability to toggle on or off Radarr suggestions in the discover page
* **Settings:** (Radarr) Ability to set sorting direction, category, and filtering method
* **Settings:** (Resources) Added link to Weblate localization page
* **Settings:** (Resources) Added link to hosted services status page
* **Settings:** (Search) Ability to toggle off showing comment and download links
* **Settings:** (System) Ability to disable Firebase Analytics and Firebase Crashlytics
* **Sonarr:** (Catalogue) If no series is found in the search query, given an option to search to add the series
* **Sonarr:** (Queue) Refreshing the queue will now also refresh the monitored downloads from the clients
* **Tautulli:** (Activity) Show custom season titles from Plex's new TV agent
* **Tautulli:** (Activity) Show session type and bandwidth type breakdown on activity page
* **Tautulli:** (Activity) Show subtitle stream decision
* **UI/UX:** (Experience) Ability to tap the AppBar to scroll to top
* **UI/UX:** (Experience) If the list is in a tabbed PageView, tapping the active tab will scroll the list to the top
* **UI/UX:** (Experience) If the keyboard is open, scrolling the list, swiping between pages, or opening the drawer will dismiss the keyboard
* **UI/UX:** (Experience) Added haptic feedback to all buttons, toggles, and dropdowns


### Bug Fixes

* **Android:** Remove legacy external storage permission
* **Dashboard:** (Calendar) Stored current date would not update on date change
* **Flutter:** Fully upgrade to Flutter v2
* **Flutter:** Update packages
* **iOS:** Share sheet would not appear on iPadOS devices
* **Networking:** Headers would not get attached in some networking configurations
* **NZBGet:** (Queue) Would not refresh in some cases when switching profiles
* **Quick Actions:** Improve package internal native channel
* **SABnzbd:** (Queue) Would not refresh in some cases when switching profiles
* **Settings:** (Configuration) Newly set headers would sometimes not be passed to the connection test
* **Sonarr:** (Add) Series type would not be set correctly when adding a new series
* **Sonarr:** (Edit) Series path prompt would show an incorrect title
* **Sonarr:** (Queue) Ensure the trailing icon on queue entries is centered vertically
* **Sonarr:** (Releases) Default sorting direction was using catalogue default value
* **Strings:** Safe-guard many substring operations
* **Tautulli:** (Activity) Play/paused/buffering icon was not properly left aligned to the text
* **Tautulli:** (Graphs) Description of some graphs were not correct (Thanks @ZuluWhiskey!)
* **Tautulli:** (IPs) Fix location showing as null for local addresses
* **Tautulli:** (Users) User images would not be fetched on newer versions of Tautulli
* **UI/UX:** (Bottom Sheet) Reduce swipe down to dismiss threshold to 10% of height
* **UI/UX:** (Design) Margin/size of sort/filter buttons were off by a few pixels
* **UI/UX:** (Design) InkWell splash now clips correctly to the rounded borders of popup menu buttons
* **UI/UX:** (Design) Vertical padding around title when the profile dropdown is visible was incorrect
* **UI/UX:** (Design) Some elements were using the system colours instead of the LunaSea colours
* **UI/UX:** (Images) Normalize size of all branded logos to have the same widths for consistency
* **UI/UX:** (Images) Prevent attempting to load background images that are passed an empty URL
* **UI/UX:** (Snackbar) Remove all uses of the deprecated snackbar
* **UI/UX:** (Snackbar) All error snackbar will now have a button to view the error
* **URLs:** Safe-guard launching specific invalid URLs


### Tweaks

* **-arr:** (Releases) Improve the layout of the rejection reasons dialog
* **Dashboard:** (Calendar) Set bounds to calendar
* **Dashboard:** (Calendar) Removed month header from calendar
* **Dashboard:** (Calendar) Disable calendar days outside of the past and future date range
* **Dashboard:** (Calendar) Made the styling for calendar slightly more consistent
* **Logger:** Removed viewing the stack trace within the application (still viewable within the exported logs)
* **NZBGet:** (Queue) Submenu for queued NZBs are now accessible via a single tap on the tile
* **NZBGet:** (Queue) Reordering queue items now occurs by dragging via the handle
* **Radarr:** Now only supports v3.0.0 and higher of Radarr
* **Radarr:** Many visual changes, too many to list
* **Radarr:** The tab "History" has been replaced with "More"
* **Radarr:** (Edit) Monitor toggle has been moved to the edit prompt
* **SABnzbd:** (Queue) Submenu for queued NZBs are now accessible via a single tap on the tile
* **SABnzbd:** (Queue) Reordering queue items now occurs by dragging via the handle
* **Search:** (Results) Now returns 50 results per infinite scrolling page
* **Search:** (Results) Removed support for sorting and filtering results
* **Settings:** (Account) Removed the ability to pull user ID or device ID from help dialog
* **Settings:** (Configuration) Sort configuration options within modules for cleaner isolation and easier expansion for future configuration options
* **Settings:** (Profiles) Renaming a profile now checks for an existing profile with the same name within the prompt
* **Settings:** (Profiles) Adding a profile now checks for an existing profile with the same name within the prompt
* **Settings:** (Profiles) The delete profile prompt now hides the currently enabled profile, and shows a snackbar if only one profile exists
* **Settings:** (Wake on LAN) Allow clearing the broadcast and MAC addresses to empty values
* **Tautulli:** (Activity) Cleanup player information to more closely resemble web GUI
* **Tautulli:** (Activity) Show the full season title
* **UI/UX:** (Accessibility) Added more descriptive tooltips to all popup menu buttons
* **UI/UX:** (Bottom Sheet) Bottom modal sheets lists will now shrink wrap to match content height
* **UI/UX:** (Brands) Updated the logo to The Movie Database's new logo
* **UI/UX:** (Design) Active tab in navigation bar now has a border with the AMOLED theme
* **UI/UX:** (Design) Adjusted the style of splash/highlight inking
* **UI/UX:** (Design) Reduced the weight of bold text across the application
* **UI/UX:** (Design) Added padding to bottom of lists for devices that require a safe area
* **UI/UX:** (Design) Minor tweaks to the colour palette
* **UI/UX:** (Design) Unify the design and size of all action buttons
* **UI/UX:** (Design) Sticky primary action buttons to the bottom navigation bar area
* **UI/UX:** (Design) Removed all deprecated UI elements and usages
* **UI/UX:** (Design) Many additional, minor tweaks to the design
* **UI/UX:** (Drawer) Removed the option to use categories/folders in the drawer
* **UI/UX:** (Navigation) Jump instead of animate to page when tapping a navbar item
* **UI/UX:** (Profiles) Highlight active profile in profile switcher popup menus

### 4.2.1


### Features

* **Accounts:** Ability to send a password reset email
* **Accounts:** Associate the LunaSea website domain for better autofill support


### Bug Fixes

* **Alerts/Changelog:** Changelog would be shown again when restoring a backup from a previous version
* **Sonarr/Add:** Fixed error log showing series ID as null


### Tweaks

* **Sonarr/Upcoming:** Change "Not Downloaded" to "Missing"

## 4.2.0


### Features

* **Accounts:** Added LunaSea accounts
* **Accounts:** Ability to backup, restore, and delete cloud configurations
* **Accounts:** Register device token to database for future notification support
* **Backups:** All backups now contain all customization and configuration options in LunaSea (New backups are required to utilize this)
* **Changelog:** Show changelog on launch if a new version is installed
* **Changelog:** Use a new bottom sheet UI for the changelog
* **Settings/Modules:** Add an information/help button with module descriptions and links
* **Sonarr/Releases:** Added loading state to download buttons to prevent triggering multiple downloads of the same release


### Bug Fixes

* **Flutter:** Updated packages
* **In App Purchases:** Ensure all in app purchases are marked as consumed
* **Logging:** Updated Sentry to v4 framework to improve capturing fatal/crashing bugs
* **Settings/Logs:** Hide exception and stack trace buttons when an error is not available
* **Settings/Resources:** Updated URL endpoints
* **Sonarr/History:** Fixed cases where history fetched the oldest entries, not the newest
* **Sonarr/Upcoming:** If an episode has not aired, show it as "Unaired" instead of "Not Downloaded"
* **State:** Correctly clear state when clearing LunaSea's configuration
* **Tautulli/Activity:** Fixed consistency of hardware transcoding indicator compared to the web UI
* **UI/Divider:** Fixed consistency of divider width across regular and AMOLED dark theme


### Tweaks

* **Radarr:** Always show the amount of days content will be available instead of limiting it to only content in the next 30 days
* **Settings:** Moved "Backup & Restore" and "Logs" to "System" section
* **Settings:** Merged "Customization" and "Modules" sections into "Configuration"
* **Settings/Sonarr:** Removed the need to enable Sonarr to test the connection
* **Settings/Tautulli:** Removed the need to enable Tautulli to test the connection

### 4.1.1


### Bug Fixes

* **Sonarr/v2:** Fix inability to interactively search for releases
* **Routing:** Fix black screen when popping back from nested calendar routes

## 4.1.0


### Features

* **Backup & Restore:** Backup files now use the .LunaSea extension (older .json backups are still supported)
* **Filesystem:** Any saves to the filesystem now uses the system share sheet
* **Images:** Ability to set (or entirely disable) the opacity of the background image for cards
* **Networking:** Strict TLS/SSL validation is now disabled globally
* **Routing:** Hold the AppBar back button to pop back to the home page of the module
* **Settings/Sonarr:** Toggle to enable Sonarr v3 features
* **Sonarr:** A ground-up re-implementation of Sonarr
* **Sonarr:** State is now held across module switches
* **Sonarr/Add:** (v3 only) Tapping an already-added series will take you to the series page
* **Sonarr/Add:** Automatically navigate to a newly added series
* **Sonarr/Add:** Ability to set tags and (v3 only) language profile when adding a new series
* **Sonarr/Catalogue:** Ability to view all, only monitored, or only unmonitored series
* **Sonarr/Catalogue:** Ability to set the default sorting type and direction (in the settings)
* **Sonarr/Edit:** Ability to update tags and (v3 only) language profile
* **Sonarr/Episodes:** If the episode is in the queue, show details of the download status
* **Sonarr/Overview:** View tags and (v3 only) language profile applied to the series
* **Sonarr/Queue:** Ability to view and manage your queue
* **Sonarr/Releases:** (v3 only) Ability to interactively search for season packs
* **Sonarr/Releases:** Ability to view all, only approved, or only rejected releases
* **Sonarr/Releases:** Ability to set the default sorting type and direction (in the settings)
* **Sonarr/Tags:** Ability to add, view, and delete tags
* **Tautulli/Activity:** Show the ETA for when the session will be completed
* **Tautulli/Activity:** Show if hardware transcoding is being used on the stream


### Bug Fixes

* **Backup & Restore:** Fix grey screen when restoring a backup without a "default"-named profile (new backups are not required)
* **Build:** (Android) Update gradle
* **Build:** (iOS) Reintegrate cocoapods podfile
* **Filesystem:** (Android) Using the share sheet now fixes the issue of inaccessible logs, backups, and downloads on Android 10+ devices
* **Flutter:** Update packages
* **Images:** Images will now load for invalid/self-signed certificates
* **Networking:** Ensure that insecure (HTTP/80) connections are allowed at the platform-level
* **Tautulli/Activity:** Fix grey screen for music activity
* **TextField:** Fix TextField actions (cut, copy, paste, etc.) not showing
* **Timestamps:** Fix 12:xx AM being shown as 00:xx AM when using 12-hour time
* **UI/Checkbox:** Fix overly vibrant checkbox selected background
- Tons of additional minor bugs were fixed


### Tweaks

* **Radarr:** Use Radarr v3 icon across the UI
* **Settings/Dialogs:** Small tweaks and additional notes for entering hosts and passwords
* **Settings/Host Dialog:** Add validator on host to ensure user adds http:// or https://
* **Settings/Resources:** Hide link to documentation until I actually finish it
* **Sonarr:** Many changes to Sonarr's design
* **Sonarr/Series:** Toggling monitored state of series has now been moved to the edit prompt and edit screen

## 4.0.0


### Features

* **Module:** Tautulli support
* **Calendar:** Ability to set how many days in the past and future to fetch calendar entries for
* **Drawer:** Categorical folders are now optional
* **Drawer:** If using folders, ability to set the initial expanded state
* **Locale:** Ability to use 24 hour timestamps
* **Quick Actions:** Ability to set up to four home screen quick actions
* **Search:** Ability to set custom headers for individual indexers
* **Settings:** Complete overhaul of the settings
* **Settings/Resources:** (iOS) Added link to join TestFlight


### Bug Fixes

* **Flutter:** Updated packages & Flutter
* **General:** Many small bug fixes
* **LunaSea:** Many behind the scenes changes to reduce memory pressure
* **LunaSea:** Heavy improvements and fixes to the navigation routing
* **Settings/Logs:** Logs could be shown in reverse order
* **Text:** Fixed "squished" text on iOS 14 and higher devices


### Tweaks

* **Home/Calendar:** Separate calendar view type into its own preference
* **Home/Calendar:** Show no modules enabled message when there are no automation modules enabled, not just no modules overall
* **Home/Calendar:** Default past and future days is now 14 days for each
* **Images:** Images are no longer cached to the device storage to heavily improve performance & reduce crashing on older/lower-end devices
* **Images:** Fetch images at specific resolutions instead of full resolution to reduce network performance and decrease memory pressure
* **Search:** Improved detection of adult categories
* **Settings:** Settings now replaces the active module/route and shows the drawer on the base route
* **Settings/System:** Removed clear image cache tile
* **UI:** Added new loading animation design

## 3.3.0


### Features

* **Home/Calendar:** New "schedule" view
* **Home/Modules:** Option to use module "brand colour" or the LunaSea list colours
* **Search:** Option to hide adult categories
* **-arr/Catalogue:** Ability to sort by date added
* **-arr/Search:** Show the indexer/tracker on the collapsed tile


### Bug Fixes

* **Sonarr:** Fixed multiple errors related to parsing fetched episode data
* **Everything:** Multiple smaller crash/error fixes

## 3.2.0


### Features

* **Drawer:** Add the LunaSea logo to the header
* **Logging:** Integrated Sentry, an open-source exception/crash log aggregation tool
* **Settings/System:** Added toggle (under system -> advanced) to disable Sentry logging


### Bug Fixes

* **-arr/Details:** Fixed crash related to state management
* **radarr/Add:** Fixed crash when a searched movie does not have a minimum availability value available


### Tweaks

* **System:** Implemented new image caching backend
* **APIs:** Improved exception logging
* **Logging:** Improved on-device logger to have more useful stack traces

## 3.1.0


### Features

* **Settings/Resources:** Added Discord invite link for official server
* **-arr:** Ability to search and enter interactive search from all upcoming and missing pages
* **-arr/Add:** Ability to jump directly into newly added content from toast notification
* **Radarr/Delete:** Ability to add to exclusion list when deleting content
* **Clients:** Hide and show queue pause/start FAB on scroll
* **Clients/History:** History tiles are now expandable in-line
* **SABnzbd/Statistics:** Show both temporary and final storage space
* **Calendar:** Ability to search/enter interactive search directly from calendar tiles


### Bug Fixes

* **API/Host:** Correctly handle cases where host ends with a forward slash


### Tweaks

* **Development:** Updated Flutter packages

## 3.0.0


### Features

* **Search:** Releases are now shown as an expandable tile
* **Search/Category Results:** Ability to sort and filter results
* **Search/Search Results:** Ability to sort search results
* **-rr/Catalogue:** Many additional sorting options
* **-rr/Releases:** Releases are now shown as an expandable tile
* **-rr/Releases:** Ability to sort, hide, and filter releases
* **Sonarr/Add:** Ability to set initial episode monitoring state
* **Sonarr/Episodes:** Episodes are now shown as an expandable tile
* **Radarr/Releases:** Shows custom format tags
* **Clients:** FAB icon animates between queue state
* **Images:** Ability to clear network image cache
* **UI/AMOLED Theme:** Optional setting to add subtle border


### Bug Fixes

* **Home/Calendar:** Row height is now statically set to prevent huge calendar on larger displays
* **Sonarr/Seasons:** Fixed crash related to seasons with no statistics data for percentage of season completion
* **Sonarr/Episodes:** Episode numbers greater than 100 could cause a line-break
* **Sonarr/Episodes:** Fixed/safe-guarded layout crash on incomplete episode data received
* **Sonarr/Queue:** Safe-guarded Sonarr queue results when results are null
* **Snackbar:** Snackbar wouldn't adopt AMOLED styling when enabled
* **State:** Fixed crashes caused by setting the state of an unmounted widget


### Tweaks

* **Changelog:** Removed integrated changelog, redirects to documentation changelog
* **-rr:** Use the term "Interactive" instead of "Manual" for search
* **-rr/Links:** Normalize size of images
* **Sonarr/Upcoming:** Now shows dates in-line as a styled header
* **Sonarr/Season View:** Now shows season number in-line as a styled header
* **UI/Font:** Adjusted font size across entire application
* **UI/Dropdowns:** Change dropdowns to popup menus
* **UI:** Rounder radius around tiles, popups, etc.

## 2.3.0


### Features

* **Module:** Wake on LAN support
* **Settings/Modules:** Ability to set custom headers to be attached to module requests
* **Settings/Changelog:** Changelog is now displayed as a route, not a dialog
* **UX:** Hitting the back button on apex/primary routes will now open the drawer instead of closing the application
* **UX:** Enable landscape mode for iPhones


### Bug Fixes

* **SnackBar:** SnackBar could cause UI locking when doing swipe-back gestures


### Tweaks

* **-rr/Details:** Removed sliver AppBar and fanart as it caused unwanted scrolling interference (A revamped overview page in the future will bring back the fanart images)
* **-rr/Details:** Switched from AppBar tabs to bottom navigation bar
* **-rr/Release:** Do not show warning message when triggering a release download from details page on rejected release
* **Dialogs:** Re-implemented all dialogs
* **Dialogs:** Keyboard type is now set for all inputs
* **Dialogs:** All inputs are now validated (to some extent) and can be submitted via the Keyboard

## 2.2.0


### Features

* **Donations:** Added donation IAPs
* **Profiles:** Added rapid-profile switcher
* **Settings:** Added license attributions
* **Settings:** Added feedback link
* **-rr/Add:** Search bar will now be autofocused
* **SABnzbd:** Added statistics for individual servers
* **NZBGet:** Option to use basic authentication instead of URL-encoded authentication


### Bug Fixes

* **Database:** Cleanly exit on clean application exit to prevent corruption


### Tweaks

* **UI:** Removed custom letter spacing
* **Settings:** Added subheaders

## 2.1.0


### Features

* **Branding:** New icon & splash screen
* **Links:** Ability to set which browser you open links in (iOS only)
* **Home/Calendar:** Ability to set starting day of week
* **Home/Calendar:** Ability to set starting calendar size
* **Home/Calendar:** Ability to enable and disable specific modules that show up in the calendar
* **Appearance/Theme:** Option to enable AMOLED black theme
* **Platform:** LunaSea is now build-able & available for Android


### Bug Fixes

* **Sonarr:** Toast for toggling season monitor state would show monitor status of the series, not the season
* **Settings/Backup:** Backing up your configuration would always fail
* **Search:** Would show an empty screen if you deleted all indexers while search is open


### Tweaks

* **Settings:** Redesign of settings page
* **General:** Use the term "Modules" instead of "Services"
* **-rr/Details:** Background image header/app bar is now collapsed by default
* **-rr/Details:** Left align title to match the rest of LunaSea

### 2.0.1


### Features

* **SABnzbd:** Ability to upload .rar & .gz archives
* **-rr/Add:** All configurable values are now stored in cold database, persisting between sessions
* **-rr/Add:** Root folders now also show available space for the folder
* **Search:** When sending an NZB to a client, there is now an action in the toast to jump directly to the respective client
* **Automation/Search:** When downloading a release manually, there is now an action in the toast to pop back to the main screen of the automation service
* **Settings:** Ability to disable SSL/TLS validation for all services
* **HTTP:** With the above, support for self-signed SSL certificates


### Bug Fixes

* **HTTP:** Safer handling of redirects
* **Routes:** Make route changes asynchronous to help minimize stutters
* **Radarr/Add:** Fixed wrong title for minimum availability card
* **Restore Configuration:** Error message had typos
* **UI:** Fixed uneven font sizing in some prompts
* **NZBGet/SABnzbd:** Failure on uploading an NZB would show no error message


### Tweaks

* **Descriptions:** Adjusted alignment and consistency when no summary is available
* **Search:** Removed redundant “Sending” toast since it very quickly gets covered by the follow-up toast
* **Automation:** Edit content prompt now shows full title of the content
* **Clients:** Opening the edit menu now shows the full title of the job
* **UI:** Tweaked design of content headers
* **Settings:** Added headers to automation and client pages to separate regular and advanced configuration options

## 2.0.0

### Features

* **iOS:** Built for iOS 13.4
* **Indexers/Search:** Full support for browsing and searching Newznab-based indexers!
* **Indexers/Search:** Support for NZBHydra2
* **Indexers/Search:** Download NZB files directly to your device
* **Indexers/Search:** Send NZB files directly from the indexer to your client of choice
* **-rr/Catalogue:** Catalogue search bar is now stickied
* **-rr/History:** Ability to enter content
* **-rr/Add:** More information (year, seasons, etc.) shown in result tiles
* **NZBGet:** Ability to search through fetched history
* **SABnzbd:** Ability to search through fetched history
* **Settings/Configuration:** Ability to clear configuration
* **Drawer:** Ability to switch profiles in navigation Drawer
* **Snackbar:** New snackbar style, design, and formatting
* **Everything:** All services now dynamically reload on profile changes


### Bug Fixes

* **Sonarr/Search:** Searching for an entire season now executes a season search instead of individual episode searches
* **Logs:** Fixed bug where logs could not load in some cases and always show "Logs Not Found"
* **Radarr/Search:** Now correctly retains search state to prevent needless researching & API hits
* **Configuration:** Deleting or renaming "default" profile could cause a new "default" profile to be created on next launch


### Tweaks

* **Everything:** Re-implemented... everything
* **Everything:** Moved away from FABs (where possible) to buttons
* **Navigation:** Ability to swipe left and right between bottom navigation tabs (except Settings)
* **Navigation Bar:** Slightly redesigned
* **Home/Summary:** Redesigned summary page
* **Home/Summary:** Removed fetching of series count, movie count, and artist count
* **Home/Calendar:** Now only shows 1 dot for each day instead of 3
* **Home/Calendar:** Highlights today as well as selected day
* **Home/Calendar:** Now shows the day of the week on the calendar
* **Home/Calendar:** Now defaults to showing 1 week (swipe down to show two weeks or one month)
* **Settings:** No longer a need to save configuration settings, everything is saved automatically
* **Search Bar:** "X" to clear search bars
* **-rr/Catalogue:** Sorting now scrolls back to top
* **-rr/Catalogue:** Moved hide unmonitored button to stickied search bar
* **-rr/Add:** Selected profile, folders, etc. are stored in state until application is closed or profile is switched
* **-rr/Images:** Images now show placeholder, transition to real content on load
* **Sonarr/Episodes:** Multi-select episodes with single tap anywhere on tile, now highlighted for easier distinction
* **SABnzbd:** Limit queue to first 100 results
* **SABnzbd:** Lowered refresh rate to 2 seconds from 1 second
* **NZBGet:** Limit queue to first 100 results
* **NZBGet:** Lowered refresh rate to 2 seconds from 1 second
* **UI:** Reduced elevation of UI in general

## 1.1.0


### Features

* **Home:** Calendar view for upcoming -rr content
* **Sonarr:** Ability to toggle single episode monitored status
* **Sonarr:** Ability to delete file
* **Radarr:** Split missing tab into missing and upcoming
* **-rr:** Long-press tile on non-catalogue pages to view catalogue entry
* **-rr:** Ability to delete files when deleting catalogue entries
* **Documentation:** Added a link to WIP documentation


### Bug Fixes

* **Prompts:** All prompts now use the correct colour ordering
* **NZBGet:** Adjusted authentication method to interfere less with custom auth setups


### Tweaks

* **Drawer:** Dropdown groups are open by default until more services are added
* **Settings:** Minor tile shuffling and rewording
* **Navigation:** New style for the navigation bars
* **Navigation:** Added custom icons to navigation bars
* **Releases:** Easier to differentiate the release's protocol

## 1.0.0


### Features

* **-rr:** When adding new content, checks if content is already in your library
* **-rr:** Ability to sort catalogue by size of alphabetical
* **Settings:** Ability to rename a profile
* **SAB/NZBGet:** Ability to pause the queue for some amount of time
* **NZBGet:** Ability to filter out successful history entries


### Bug Fixes

* **Radarr:** Fetching quality profiles could fail
* **SAB/NZBGet:** Percentage calculation could fail causing a grey screen
* **SAB/NZBGet:** Connection error now cancels timer until manual refresh (cleaner logs)


### Tweaks

* **Build:** Adjusted how build number is presented
* **Sonarr:** Now shows size on disk on catalogue page
* **Lidarr:** Now shows size on disk on catalogue page
* **Settings:** Successful connection test now also triggers save
* **Settings:** Save button is now more obvious/clear
* **Settings:** Adjusted and added more tips when adding hosts
