# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

### [10.2.4](https://github.com/JagandeepBrar/lunasea/compare/v10.2.3...v10.2.4) (2023-04-09)


### Features

* **settings:** add direct link to documentation for service notifications ([0f4ac9a](https://github.com/JagandeepBrar/lunasea/commit/0f4ac9a893d5b13a732db49e0bfc7b09fe7c05d9))
* **settings:** replace all strings with localizable strings ([5ce1279](https://github.com/JagandeepBrar/lunasea/commit/5ce12795e7223a543bd037151b1a3eaa484f2634))


### Bug Fixes

* **images:** utilize new technique to persistently cache images ([f1a82c0](https://github.com/JagandeepBrar/lunasea/commit/f1a82c06aa58fe493af2b2b0bf9ef8a93011802b))
* **routing:** handle pushing route which may return data ([3500d83](https://github.com/JagandeepBrar/lunasea/commit/3500d83477880b8ee490132bc270e632af4a4bb1))
* **uiux:** remove fading edge on horizontal scrollviews ([781727a](https://github.com/JagandeepBrar/lunasea/commit/781727abbab0dc70d959c723c3d101e66430ac60))


### Tweaks

* **flavors:** remove candidate flavor and merge with beta ([fe3d41a](https://github.com/JagandeepBrar/lunasea/commit/fe3d41af57717b994e71370968404fc05f20f72b))
* remove cupertino_icons and email_validator packages ([605002f](https://github.com/JagandeepBrar/lunasea/commit/605002f5bd4b015791d3d1f260e03b4127c5020d))
* remove riverpod state management ([2f94c42](https://github.com/JagandeepBrar/lunasea/commit/2f94c42da1a97847be4a77e79d096eb0212a9657))

### [10.2.3](https://github.com/JagandeepBrar/lunasea/compare/v10.2.2...v10.2.3) (2023-03-22)


### Features

* **flutter:** replace Skia with Impeller rendering engine ([6241ee4](https://github.com/JagandeepBrar/lunasea/commit/6241ee462989f1f65fa8f1e18378579e2e77197b))
* **flutter:** upgrade to Flutter 3.7/b06b8b2710 ([f1b831a](https://github.com/JagandeepBrar/lunasea/commit/f1b831a118e56c480aae72042ee4eb7013f954b2))
* **tautulli:** add ability to open media in Plex ([5cf1a06](https://github.com/JagandeepBrar/lunasea/commit/5cf1a06cec079aa66c77425c0ed8d4fa7897bbd3))
* **tautulli:** display audio language, subtitle language, and video dynamic range for activity ([6de8063](https://github.com/JagandeepBrar/lunasea/commit/6de806316efaa61c5ddbac1b8f5b214949f0bcf8))


### Bug Fixes

* **http:** correctly set content type for POST requests ([aca5d0e](https://github.com/JagandeepBrar/lunasea/commit/aca5d0eb826b38ebeec33e3495045bf21e8a49c7))
* **links:** use platform default method to laucnh URLs ([596eab4](https://github.com/JagandeepBrar/lunasea/commit/596eab4bad1aa183e3c0dfc8d20a32c15ecdb78d))
* **macos:** set minimum platform version to 10.15 ([d612ae2](https://github.com/JagandeepBrar/lunasea/commit/d612ae221cac741b3a36893d4bc7f05f5055c7b8))
* **uiux:** update bottom modal sheet package to support Flutter 3.7 ([8042c04](https://github.com/JagandeepBrar/lunasea/commit/8042c0475ecff05d9337842eef7cfe4117d05528))

### [10.2.2](https://github.com/JagandeepBrar/lunasea/compare/v10.2.1...v10.2.2) (2022-12-22)


### Features

* **android:** add option to disable back action to open drawer ([d4774b0](https://github.com/JagandeepBrar/lunasea/commit/d4774b054204546490ef9f78090e28303eefc1fc))
* **linux:** include MD5 sums in Debian distributions ([c46924c](https://github.com/JagandeepBrar/lunasea/commit/c46924c99645a2d9c27e2d3532d30ecf93882e2a))
* **linux:** publish Linux builds as Debian archive (.deb) ([b1d01e0](https://github.com/JagandeepBrar/lunasea/commit/b1d01e02ca4cdb8a2775700930ada2d1d40a1031))
* **linux:** publish Linux builds as tarball (.tar.gz) ([a390a80](https://github.com/JagandeepBrar/lunasea/commit/a390a80ef1897d4c95812045a3472527ff38fd49))


### Bug Fixes

* **calendar:** scroll to last past date with content when selected date has no content ([3f10675](https://github.com/JagandeepBrar/lunasea/commit/3f10675422b9a32c43f4f49c16b6e9723f267f50))
* **linux:** install binaries to /usr/share instead of /usr/local/lib ([edb645f](https://github.com/JagandeepBrar/lunasea/commit/edb645f8871d8f3a59c122191e8d8219e9957924))
* **tautulli:** cached or downloaded activity sessions could not be opened ([4c99ecf](https://github.com/JagandeepBrar/lunasea/commit/4c99ecf927e21538f875bb7ee93fc7aaf20de479))


### Tweaks

* **uiux:** disable horizontal swiping/scrolling between pages ([968fe9c](https://github.com/JagandeepBrar/lunasea/commit/968fe9cbbc4aff3ae584682e462defbf09ea5699))

### [10.2.1](https://github.com/JagandeepBrar/lunasea/compare/v10.2.0...v10.2.1) (2022-11-06)


### Features

* **-arr:** button to open indexer information page ([bccd1a4](https://github.com/JagandeepBrar/lunasea/commit/bccd1a43c42b349901137f8fc605f393b51d541a))
* **calendar:** remove option to show previous days in schedule view, now always shows them ([3ac2c5d](https://github.com/JagandeepBrar/lunasea/commit/3ac2c5d791f94208a4004d161bb046c24b698345))
* **calendar:** scroll to selected date when switching from calendar to schedule view ([f1226e5](https://github.com/JagandeepBrar/lunasea/commit/f1226e563899cfc0950865a9734448d4e00601b9))
* launch recovery mode on bootstrap failure ([c062b3d](https://github.com/JagandeepBrar/lunasea/commit/c062b3d786e55bc3ba7fe767dd946d73efbef64f))
* **lidarr:** add MusicBrainz to links ([c76418d](https://github.com/JagandeepBrar/lunasea/commit/c76418d26f1a5f52f5cb1e46951f1cf6726508c2))
* **modules:** ability to set the boot module ([3dd087e](https://github.com/JagandeepBrar/lunasea/commit/3dd087e361619889057a0b037b1eef35157a0988))
* **radarr:** support moving files when editing the storage path ([c9bd02b](https://github.com/JagandeepBrar/lunasea/commit/c9bd02b75086579f60ad8987c42ab217c12f6d43))
* **web:** support local filesystem read/save actions ([7d437d5](https://github.com/JagandeepBrar/lunasea/commit/7d437d5c3a34a8681c372570fc366e869f0b2090))


### Bug Fixes

* **android:** apply Google Play Services plugin during gradle build ([71f597b](https://github.com/JagandeepBrar/lunasea/commit/71f597baa7c23102b711c3ca3c1ea5b2f8e1f5e9))
* **android:** revert applying Google Play Services plugin during gradle build ([250a494](https://github.com/JagandeepBrar/lunasea/commit/250a49490333f4de726226dc4aa15a681f32a70c))
* **android:** support Android 13 filesystem access ([25e0d05](https://github.com/JagandeepBrar/lunasea/commit/25e0d051422b399de8c90e0fc71e57349e3355b7))
* **android:** utilize Kotlin v1.7.20 & Gradle v7.1.2 ([b7ceebc](https://github.com/JagandeepBrar/lunasea/commit/b7ceebcb679dbca935b6a1810c0c67a14002e358))
* **backup:** edge-case where backup/restore would fail ([f3931c6](https://github.com/JagandeepBrar/lunasea/commit/f3931c6b08025a70920039e5cbbc9cf7120c0b36))
* **calendar:** label unreleased movies as unreleased instead of missing ([70ed750](https://github.com/JagandeepBrar/lunasea/commit/70ed750652ff419e6fed659a0785adc5064654e7))
* **calendar:** start to current date when past days are enabled ([6eff6c9](https://github.com/JagandeepBrar/lunasea/commit/6eff6c902cd7bcd523d83be09034098234679a79))
* **firebase:** inject service file for older OS versions ([38f2eb4](https://github.com/JagandeepBrar/lunasea/commit/38f2eb4cb2a8e400ce2ecb0b6f2854469c9626fc))
* **firebase:** upgrade to Firebase v10 ([#717](https://github.com/JagandeepBrar/lunasea/issues/717)) ([f3a3f22](https://github.com/JagandeepBrar/lunasea/commit/f3a3f222bd56beb4e961817b18d71f01fb7c5e81))
* **uiux:** add circular radius to linear progression bars ([d9623e9](https://github.com/JagandeepBrar/lunasea/commit/d9623e992d2ac2039eaa4f069c739d968c921cc6))


### Tweaks

* **settings:** consolidate appearance, network, and localization pages ([ac838f9](https://github.com/JagandeepBrar/lunasea/commit/ac838f99a9c839ce4e36e5eae80f1100e2787dc5))
* **uiux:** remove forced-upper case on headers ([958e6f1](https://github.com/JagandeepBrar/lunasea/commit/958e6f156862c1092399649baa361cd955299c88))

## [10.2.0](https://github.com/JagandeepBrar/lunasea/compare/v10.1.1...v10.2.0) (2022-09-22)


### Features

* **-arr:** view download client queue via overlay sheet ([0c59886](https://github.com/JagandeepBrar/lunasea/commit/0c59886657db0ed05a9d741c82689cb1272c6ad2))
* **android:** add support for monochromatic adaptive icon ([#701](https://github.com/JagandeepBrar/lunasea/issues/701)) ([96b2b1b](https://github.com/JagandeepBrar/lunasea/commit/96b2b1b5b010507dd7ece3421bf02eac6ba32486))
* **locale:** support Croatian ([a160f09](https://github.com/JagandeepBrar/lunasea/commit/a160f0941f2e0c86d2e2fab5e01a577ceba2a8f3))
* **logging:** integrate Sentry logging support for all platforms ([57bbb80](https://github.com/JagandeepBrar/lunasea/commit/57bbb80a0188d3bed9ca70846a89df6a3c2c0953))
* **logo:** add Vectorized app logos ([113b294](https://github.com/JagandeepBrar/lunasea/commit/113b2943469464598ce07b931818c7e29c6cc63a))
* **router:** re-implementation of routing via go_router ([1d4207a](https://github.com/JagandeepBrar/lunasea/commit/1d4207ae5106c2a0648b77a3b3ef6508665561e8))
* **sabnzbd:** rewrite SABnzbd API interface ([a1b736a](https://github.com/JagandeepBrar/lunasea/commit/a1b736ae0c9bf754d913e86c69d15c27f256c413))
* **search:** view download client queue via overlay sheet ([a6be658](https://github.com/JagandeepBrar/lunasea/commit/a6be658164fed7dd2411a167dec6b4c53eab70f0))
* **settings:** re-add option to disable Sentry logging ([3d0c520](https://github.com/JagandeepBrar/lunasea/commit/3d0c5209cb3e796629817dee986634154e7ffe9e))
* **web:** enable service worker processing of notifications ([4b41110](https://github.com/JagandeepBrar/lunasea/commit/4b411107f74f048e6f3d571845590a5d29720ac3))


### Bug Fixes

* **android:** support Android 13 notification prompt ([83e8374](https://github.com/JagandeepBrar/lunasea/commit/83e8374c33977c82096fcf8d5a4d94da5c291f8f))
* **cache:** add type-safety to LRU cache ([7aae480](https://github.com/JagandeepBrar/lunasea/commit/7aae4807221184dbe1d02454f73998a0458dd7f6))
* **database:** prevent deadlock in database deletion actions ([9960124](https://github.com/JagandeepBrar/lunasea/commit/9960124d3219e2ab72e14443a1a79a1bac6b2cd3))
* **graphs:** support fl_chart@0.55.1 ([b812c7b](https://github.com/JagandeepBrar/lunasea/commit/b812c7b4a12b4766e04b5d4023b45320e6b7927c))
* **images:** validate image availability before fading-in ([6f9e0e8](https://github.com/JagandeepBrar/lunasea/commit/6f9e0e87ce3d02dfff7dec439a2e975585c5b986))
* **notifications:** correctly inject service worker for notification handling ([82ef5f0](https://github.com/JagandeepBrar/lunasea/commit/82ef5f0c529a9e30475f86f496fa63c18785e87c))
* **notifications:** enable in-app notifications config was inversed ([3593eb3](https://github.com/JagandeepBrar/lunasea/commit/3593eb329b38fb4a5b776cf1b165ad6f463e371b))
* **resources:** remove feedback board resource ([d3d090e](https://github.com/JagandeepBrar/lunasea/commit/d3d090e277f7dda7d4ef3d7808e7341cf79178fe))
* **scrolling:** remove custom scrolling behaviour ([864082f](https://github.com/JagandeepBrar/lunasea/commit/864082fd4045ef7dea0e0ab6a17d41ca86015fcb))
* **settings:** show notification settings area on web ([136cda5](https://github.com/JagandeepBrar/lunasea/commit/136cda5215ae1d44dcd898e8e8e0b1e1912b3a41))
* **sheets:** set default overlay theme for sheets, remove bottom radius clipping ([3a5e19b](https://github.com/JagandeepBrar/lunasea/commit/3a5e19b02c048df21bd169a0a06f1e9ae741debb))
* **sonarr:** support Sonarr v4 API changes ([e477eca](https://github.com/JagandeepBrar/lunasea/commit/e477ecafcce268d7de112f33711fc02a089a4206))
* **web:** correctly register notification service worker ([579531c](https://github.com/JagandeepBrar/lunasea/commit/579531c30a17e2c8d53d011dbecf710f42598ec8))


### Tweaks

* **remove logos:** removes unused logo pngs ([2adfe59](https://github.com/JagandeepBrar/lunasea/commit/2adfe59bd5cd289beb7f7c703fe26397310dbc90))

### [10.1.1](https://github.com/JagandeepBrar/lunasea/compare/v10.1.0...v10.1.1) (2022-08-21)


### Features

* **changelog:** do not show changelog on first boot of new installs ([52fd7fc](https://github.com/JagandeepBrar/lunasea/commit/52fd7fca0c5076b4b98458d449a4b1f581726a52))


### Bug Fixes

* **config:** log restoration error after resetting the database to default ([b02fe81](https://github.com/JagandeepBrar/lunasea/commit/b02fe81df697066be6172a7d423768490639593e))
* **indexer:** remove LunaIndexerIcon from model definition ([cf3d9bb](https://github.com/JagandeepBrar/lunasea/commit/cf3d9bbc17cd67f0c5e8be22b9450563046a2127))

## [10.1.0](https://github.com/JagandeepBrar/lunasea/compare/v10.0.3...v10.1.0) (2022-08-21)


### Features

* **calendar:** show current month in header ([925f163](https://github.com/JagandeepBrar/lunasea/commit/925f163e1534aeb45e5b22e8254eaf391eabd79f))
* **changelog:** prepare and show changelog on pre-release builds ([df65f53](https://github.com/JagandeepBrar/lunasea/commit/df65f53a4b00d11abc998f681274d22d94254f14))
* **locale:** support Vietnamese (vi) ([8b57450](https://github.com/JagandeepBrar/lunasea/commit/8b5745044e3af64a6c9bc593a9877400ac8a2dc2))


### Bug Fixes

* **android:** correctly handle back-button to open drawer on applicable routes ([c91ba2c](https://github.com/JagandeepBrar/lunasea/commit/c91ba2ce8134fdc796d0431ba1c9134908fddd91))
* **changelog:** group changelog item rows by key feature change ([2ababbd](https://github.com/JagandeepBrar/lunasea/commit/2ababbd1b32abd153fa73fcdfe292c7791edbf52))
* **ci:** utilize latest standard for Snapcraft login ([aff6e2c](https://github.com/JagandeepBrar/lunasea/commit/aff6e2ca184e9539f28dd326c06478ca2dbfee4c))
* **database:** correctly store manually ordered module list ([8fe81d1](https://github.com/JagandeepBrar/lunasea/commit/8fe81d11ab5c5aa484f0c2b471932d5364e6209c))
* **database:** detect and recover from database corruption ([758756f](https://github.com/JagandeepBrar/lunasea/commit/758756fcf2456996c7ee02be2bd523cca91c45d3))
* **database:** fallback to defaults on null values in profile ([fb3e8e5](https://github.com/JagandeepBrar/lunasea/commit/fb3e8e53255c457d0922505ad6c2d91f5c0fcf03))
* **database:** safely type indexer fields and headers ([f1dcd0c](https://github.com/JagandeepBrar/lunasea/commit/f1dcd0c36d558882bfbc7f4465ed56fac0743c55))
* **database:** utilize stricter typing for module headers map ([d4d9816](https://github.com/JagandeepBrar/lunasea/commit/d4d9816c945b1930ecfda0382d809a7c67839a26))
* **database:** validate enabled profile exists on restore ([d8506ee](https://github.com/JagandeepBrar/lunasea/commit/d8506ee2834ca6a83394c11f6d4d329f03a3647f))
* display 0-length timestamps as "0 Minutes" instead of "Under a Minute" ([e05b17a](https://github.com/JagandeepBrar/lunasea/commit/e05b17ae5ed35cec85ade5b910b82869cb7ad3f2))
* **lidarr:** (history) sort list by date descending ([ad22820](https://github.com/JagandeepBrar/lunasea/commit/ad22820d6662371d3d2bc7fbf596f86619002d20))
* **lists:** reorderable lists could not be reordered on some platforms ([95a645c](https://github.com/JagandeepBrar/lunasea/commit/95a645c06cf2a76231c4b8dbea87ec593961c205))
* **locale:** create stub primary language localization assets ([18ef4cf](https://github.com/JagandeepBrar/lunasea/commit/18ef4cf1d4032a3f9db54b5da56158ffaf9b50c8))
* **overseerr:** issues/requests list view translation keys ([136b92b](https://github.com/JagandeepBrar/lunasea/commit/136b92b8a7bdd5cd0ec2322444443d054df6daed))
* **radarr:** (queue) allow loading queue list when associated movie is not found ([22bf728](https://github.com/JagandeepBrar/lunasea/commit/22bf728a3dab6b7d76c7674cb4d97dc73e849201))
* **sonarr:** fanart image requests not including headers ([b5bb300](https://github.com/JagandeepBrar/lunasea/commit/b5bb300046431d8c1c26fd8ac4a26c42444f4f53))
* **sonarr:** invalid linking to theTVDB content ([80678a7](https://github.com/JagandeepBrar/lunasea/commit/80678a75bb871a4835d1c73934e043564d80b6b0))


### Tweaks

* **changelog:** do not show documentation changes in in-app changelog ([2367050](https://github.com/JagandeepBrar/lunasea/commit/2367050a66f2929d1ead17cc9191f47ddcb07f3a))
* **core:** destructure core folder and reintegrate extensions ([5d52440](https://github.com/JagandeepBrar/lunasea/commit/5d52440a43e4b605a8ac95bcb02b909f489ef7e2))
* **database:** rewrite interface to key-value database ([a0eaca0](https://github.com/JagandeepBrar/lunasea/commit/a0eaca084a399a2e249b142cb720cc50739a3f51))
* **environment:** load environment using environment_config ([c4dd509](https://github.com/JagandeepBrar/lunasea/commit/c4dd509e3210847c0ddba4c7982f38099228a2d6))
* refactored in-app purchase interface ([9cb3fab](https://github.com/JagandeepBrar/lunasea/commit/9cb3fabdf1f5fa10d65770a181ced937413642a2))
* utilize statics and class functions for LunaModule enum ([9f3c3f7](https://github.com/JagandeepBrar/lunasea/commit/9f3c3f779dda1b2da007abe5c2079dcfa834eb99))

### [10.0.3](https://github.com/JagandeepBrar/lunasea/compare/v10.0.2...v10.0.3) (2022-05-26)


### Features

* **-arr:** updated UI for viewing content links ([8b559e0](https://github.com/JagandeepBrar/lunasea/commit/8b559e00b01305af6d1f8139a75aa25391127626))
* **ci:** build web docker images ([73fbb10](https://github.com/JagandeepBrar/lunasea/commit/73fbb1076ec8e951d99ad2df28a28454ca8189a1))
* **notifications:** option to disable in-app notifications ([da0c44c](https://github.com/JagandeepBrar/lunasea/commit/da0c44c8b1bc846acc4a1d0a4b7f1ee7c4c2e44d))
* **settings:** ability to check for updates ([b3caf34](https://github.com/JagandeepBrar/lunasea/commit/b3caf34074ecc72257b26d091a332e8f54a47587))


### Bug Fixes

* correctly calculate age of releases in -arrs ([e35433a](https://github.com/JagandeepBrar/lunasea/commit/e35433af314b13ff3c951eef4c99f42e460f2b28))
* **ui:** enable interactivity on all scrollbars on all platforms ([174fa96](https://github.com/JagandeepBrar/lunasea/commit/174fa969517b00e611534defc12ca3768348623a))

### [10.0.2](https://github.com/JagandeepBrar/lunasea/compare/v10.0.1...v10.0.2) (2022-04-12)


### Features

* **account:** ability to update account email and password ([5ea6269](https://github.com/JagandeepBrar/lunasea/commit/5ea6269bca9cc21f9a3ec34ff9840ea22384b717))
* **firebase:** allow building LunaSea without setting up Firebase [skip ci] ([d7431b1](https://github.com/JagandeepBrar/lunasea/commit/d7431b110217ff868e662be4a34af656ca1d6515))
* **firebase:** conditionally load Firebase depending on the platform ([91f556d](https://github.com/JagandeepBrar/lunasea/commit/91f556d07833c9be6a4d176d663e7889361b8ec2))
* **linux:** initial linux support ([12fab1d](https://github.com/JagandeepBrar/lunasea/commit/12fab1d6c22104cbf18ff695b1c636cc48236126))
* **resources:** add link to build bucket [skip ci] ([64db574](https://github.com/JagandeepBrar/lunasea/commit/64db574155182942dabbaffba5dbf43e0cca950c))
* **resources:** add link to information about build channels ([fb31aba](https://github.com/JagandeepBrar/lunasea/commit/fb31aba7f9b2678736f2d9abacdbf244edd1048a))
* **ui:** ability to set background color on LunaBlock tiles [skip ci] ([e108cfb](https://github.com/JagandeepBrar/lunasea/commit/e108cfbac5f5bb2a1cd7404af0a331fadba85612))
* **windows:** initial windows support ([313e05c](https://github.com/JagandeepBrar/lunasea/commit/313e05c8f519ca0c17efbec3d0587418e712cb81))


### Bug Fixes

* **charts:** rollback to fl_charts@0.46.0 ([cc81ee7](https://github.com/JagandeepBrar/lunasea/commit/cc81ee7f14adc49b84556224dfef54c735c54758))
* **database:** write to LunaSea parent folder on Linux and Windows ([6e89796](https://github.com/JagandeepBrar/lunasea/commit/6e89796a15622f82759a6f8f02a82b1494ea1f8d))
* **desktop:** prevent flickering by waiting for window settings to apply ([5a2a9b7](https://github.com/JagandeepBrar/lunasea/commit/5a2a9b780b94d27aa2005823e1a18e225970967f))
* **desktop:** set initial and minimum window sizes ([dd30c3a](https://github.com/JagandeepBrar/lunasea/commit/dd30c3a0a32201a6503c81685dfdbc928a4aee90))


### Tweaks

* **flavor:** rename build flavors [skip ci] ([26cc258](https://github.com/JagandeepBrar/lunasea/commit/26cc2585b28f17342caf034ef9ef76dad06eb474))
* **settings:** do not show version code [skip ci] ([ac807a8](https://github.com/JagandeepBrar/lunasea/commit/ac807a8a01993939b86baad2dcb11e7d2a73e509))
* **ui:** remove usages of tab indentations [skip ci] ([d9e7009](https://github.com/JagandeepBrar/lunasea/commit/d9e70090007b402d2596e09195da5324ac1aafd0))

### [10.0.1](https://github.com/JagandeepBrar/lunasea/compare/v10.0.0...v10.0.1) (2022-03-25)


### Features

* **config:** support retrying entering encryption password on failure ([cd9a3d2](https://github.com/JagandeepBrar/lunasea/commit/cd9a3d295e87b7d8987e508e6c77b02c1c5290f8))
* **filesystem:** rewrite filesystem interface for better compatibility ([4c60df5](https://github.com/JagandeepBrar/lunasea/commit/4c60df5523b98da3a7f135bb26fa20b36ed653e9))
* **ios:** enable landscape support on iOS devices ([f8e6760](https://github.com/JagandeepBrar/lunasea/commit/f8e676015c26f1e33f8680043663ea4f25dbc872))
* **web:** initial web support ([91e1fa0](https://github.com/JagandeepBrar/lunasea/commit/91e1fa03d9fae7cf82d158f00587075b29c610ea))
* **window_manager:** rewrite window manager to be platform-safe ([d6aed6c](https://github.com/JagandeepBrar/lunasea/commit/d6aed6c707ad75c0a02c3a4fa496ee6d8adeb55e))


### Bug Fixes

* **android:** prevent multiple splash screens from appearing on Android 12 ([26523e5](https://github.com/JagandeepBrar/lunasea/commit/26523e58ed12c8789c5c2c0df8d9f6e75e719f11))
* **web:** set notification vapid key ([1ddcc27](https://github.com/JagandeepBrar/lunasea/commit/1ddcc279dd6adf629a2f99939a567481e3675bd2))


### Tweaks

* **images:** guard and fallback image cache implementation ([601d82c](https://github.com/JagandeepBrar/lunasea/commit/601d82cf89a22890d4197d10e1b74dbe110b0755))
* **platform:** guard usages of dart:io and dart:html for future compatibility ([c7bd62d](https://github.com/JagandeepBrar/lunasea/commit/c7bd62de2ee5669b41e6ccbc5e706ecb237cbcac))
* **wake_on_lan:** refactor wake on LAN support, support loading API with dart:html ([403edc1](https://github.com/JagandeepBrar/lunasea/commit/403edc16fb8188bba9bb6dd5b60a128dc8c2b0d4))

## [10.0.0](https://github.com/JagandeepBrar/lunasea/tree/v10.0.0) (2022-03-12)


### Features

* **debug:** debug page for multiple UI elements ([80c5d21](https://github.com/JagandeepBrar/lunasea/commit/80c5d2118a68129690cde5acbf70a23746d30acf))
* **http:** set User-Agent to "LunaSea/{version} {build}" ([420d11c](https://github.com/JagandeepBrar/lunasea/commit/420d11c37188fe1d56d76b51b98325b384a45cff))
* **overseerr:** integrate request list and request tiles ([b7fc3c0](https://github.com/JagandeepBrar/lunasea/commit/b7fc3c0a0fe917ca13513be74159af022c956465))
* **overseerr:** issues (de)serialization & list integration ([db4dfda](https://github.com/JagandeepBrar/lunasea/commit/db4dfdaf9ca1976d1a6e4b0ebc451b2e0f08b19e))
* **overseerr:** serialized movie & tv objects ([2b778dc](https://github.com/JagandeepBrar/lunasea/commit/2b778dc437559549df7404fa5266719979c3cce3))
* **settings:** add test build information to resources ([be2d3e6](https://github.com/JagandeepBrar/lunasea/commit/be2d3e63c27dc8eb5f2f01740df02d23b75eec8e))
* **sonarr:** support for searching entire series for monitored episodes [skip ci] ([ba958b5](https://github.com/JagandeepBrar/lunasea/commit/ba958b59a6445d422ae1ea9533f9a6ada188962b))
* **ui:** support skeleton-state loading on LunaBlock ([8ab5f80](https://github.com/JagandeepBrar/lunasea/commit/8ab5f80d004ead52a40a69f33482f371fe0f8c8b))


### Bug Fixes

* **desktop:** handle pull-to-refresh drag action ([d38fc77](https://github.com/JagandeepBrar/lunasea/commit/d38fc770d2de4c2e2471aa4b61f8c4eb231ee134))
* **firebase:** remove remaining references to crashlytics and analytics [skip ci] ([67afaa0](https://github.com/JagandeepBrar/lunasea/commit/67afaa05f22163b95faff7be526c7a7ddbd5ac5e))
* **overseerr:** rehydrate missing cached media content when required after cache ejection ([b09353b](https://github.com/JagandeepBrar/lunasea/commit/b09353ba6e35992ce90613a198f7eb39759522a1))
* **radarr:** localized strings and correctly display disk/root folder tiles ([490ecf6](https://github.com/JagandeepBrar/lunasea/commit/490ecf60d1d2267a1e2a6677db8e58c0dea9e096))
* **radarr:** match file details to web GUI ([a42aa41](https://github.com/JagandeepBrar/lunasea/commit/a42aa4109ecde42dd2226ee13d398ca09c66a4b3))
* **radarr:** prevent using preDB availability when adding movie ([9d71c1a](https://github.com/JagandeepBrar/lunasea/commit/9d71c1ac9ae5505692c24c425be2ce22ae292a25))
* **tautulli:** set graph padding to theme-default padding ([1229e5e](https://github.com/JagandeepBrar/lunasea/commit/1229e5ee5ba1534d3e694fb85657b79b7dfcbf78))


### Tweaks

* **flavor:** rename "internal" to "develop" ([5652cb0](https://github.com/JagandeepBrar/lunasea/commit/5652cb04bc7a23292d0ea9d65d6e919218975905))
* **modules:** remove canonical module import file [skip ci] ([0cbd61e](https://github.com/JagandeepBrar/lunasea/commit/0cbd61eac5c8e8675b3dd5702977c99e06ca81d5))
* **overseerr:** utilize JsonEnum generators in enum types [skip ci] ([76d530e](https://github.com/JagandeepBrar/lunasea/commit/76d530ed0810724d9b61bb73b689d6afb23d4ebd))

---

Previous version changelogs are no longer available.