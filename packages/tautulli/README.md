# tautulli

[![Pubdev][pubdev-shield]][pubdev]
![License][license-shield]

Dart library package to facilitate the connection to and from [Tautulli](https://tautulli.com)'s API, a Python based monitoring and tracking tool for Plex Media Server.

## Getting Started

In order to use this package, you need to have enabled and created an API key within Tautulli. Please ensure you do not publicly reveal your API key, as it will give any user with access full control of your Tautulli instance. To get started simply import the tautulli package, and initialize a connection to your instance:

```dart
Tautulli tautulli = Tautulli(host: '<your instance URL>', apiKey: '<your API key>');
```

Once initialized, you can access any of the command handlers ([detailed below](#commands)) to quickly and easily make calls to Tautulli. For most calls that return data, model definitions have been created. Typings have also been created for parameters that have a set, finite list of options.

## Optional Parameters

There are a few optional parameters when initializing a Tautulli instance.

### `headers` | Map<dynamic, String> (default: null)

Allows you to add on any custom headers to each request.

```dart
Tautulli(
    host: '<your instance URL>',
    apiKey: '<your API key>',
    headers: {
        'authorization': '<auth_token>',
    },
);
```

### `followRedirects` | Boolean (default: true)

Allows you to define if the HTTP client should follow redirects.

```dart
Tautulli(
    host: '<your instance URL>',
    apiKey: '<your API key>',
    followRedirects: false, // Disables following redirects
);
```

### `maxRedirects` | Integer (default: 5)

Allows you to define the maximum amount of redirects the HTTP client should follow. If `followRediects` is set to false, then this parameter does nothing.

```dart
Tautulli(
    host: '<your instance URL>',
    apiKey: '<your API key>',
    maxRedirects: 1, // Only follow 1 redirect at most
);
```

## Custom Dio HTTP Client

This package uses [dio](https://pub.dev/packages/dio) to make all HTTP connections. The default constructor will create the HTTP client for you, or you can create your own Dio instance and create a `Tautulli` instance from it using the factory constructor:

```dart
Dio dio = Dio(
    BaseOptions(
        baseUrl: '<your instance URL>',
        queryParameters: {
            'apikey': '<your API key>',
        },
    ),
);
Tautulli tautulli = Tautulli.from(dio);
```

> You must ensure you set the BaseOptions specified above, specifically `baseUrl` and `queryParameters` otherwise the instance will not be able to create a successful connection to your machine.

## Commands

All commands have been split into categories, each with their own respective handler, and can be accessed via an initialized `Tautulli` object.
- [Activity](#activity)
- [History](#history)
- [Libraries](#libraries)
- [Miscellaneous](#miscellaneous)
- [Notifications](#notifications)
- [System](#system)
- [Users](#users)

Any command handler can be initialized directly, but will require you to create your own Dio HTTP client. You will still need to ensure you set the `BaseOptions` as specified above.

### Activity

All commands that are activity related. All commands in this category can be accessed via:
- A `TautulliCommandHandler_Activity` instance.
- `activity` within an initialized `Tautulli` object.

| API Command | Method |
| :---------- | -----: |
| [delete_temp_sessions][api:delete_temp_sessions] | `deleteTempSessions()` |
| [get_activity][api:get_activity]                 | `getActivity()`        |
| [terminate_session][api:terminate_session]       | `terminateSession()`   |

### History

All commands that are history related. All commands in this category can be accessed via:
- A `TautulliCommandHandler_History` instance.
- `history` within an initialized `Tautulli` object.

| API Command | Method |
| :---------- | -----: |
| [delete_history][api:delete_history]                                           | `deleteHistory()`                  |
| [get_history][api:get_history]                                                 | `getHistory()`                     |
| [get_home_stats][api:get_home_stats]                                           | `getHomeStats()`                   |
| [get_plays_by_date][api:get_plays_by_date]                                     | `getPlaysByDate()`                 |
| [get_plays_by_dayofweek][api:get_plays_by_dayofweek]                           | `getPlaysByDayOfWeek()`            |
| [get_plays_by_hourofday][api:get_plays_by_hourofday]                           | `getPlaysByHourOfDay()`            |
| [get_plays_by_source_resolution][api:get_plays_by_source_resolution]           | `getPlaysBySourceResolution()`     |
| [get_plays_by_stream_resolution][api:get_plays_by_stream_resolution]           | `getPlaysByStreamResolution()`     |
| [get_plays_by_stream_type][api:get_plays_by_stream_type]                       | `getPlaysByStreamType()`           |
| [get_plays_by_top_10_platforms][api:get_plays_by_top_10_platforms]             | `getPlaysByTopTenPlatforms()`      |
| [get_plays_by_top_10_users][api:get_plays_by_top_10_users]                     | `getPlaysByTopTenUsers()`          |
| [get_plays_per_month][api:get_plays_per_month]                                 | `getPlaysPerMonth()`               |
| [get_stream_data][api:get_stream_data]                                         | `getStreamData()`                  |
| [get_stream_type_by_top_10_platforms][api:get_stream_type_by_top_10_platforms] | `getStreamTypeByTopTenPlatforms()` |
| [get_stream_type_by_top_10_users][api:get_stream_type_by_top_10_users]         | `getStreamTypeByTopTenUsers()`     |

### Libraries

All commands that are library related. All commands in this category can be accessed via:
- A `TautulliCommandHandler_Libraries` instance.
- `libraries` within an initialized `Tautulli` object.

| API Command | Method |
| :---------- | -----: |
| [delete_all_library_history][api:delete_all_library_history]     | `deleteAllLibraryHistory()`  |
| [delete_library][api:delete_library]                             | `deleteLibrary()`            |
| [delete_recently_added][api:delete_recently_added]               | `deleteRecentlyAdded()`      |
| [edit_library][api:edit_library]                                 | `editLibrary()`              |
| [get_libraries][api:get_libraries]                               | `getLibraries()`             |
| [get_libraries_table][api:get_libraries_table]                   | `getLibrariesTable()`        |
| [get_library][api:get_library]                                   | `getLibrary()`               |
| [get_library_media_info][api:get_library_media_info]             | `getLibraryMediaInfo()`      |
| [get_library_names][api:get_library_names]                       | `getLibraryNames()`          |
| [get_library_user_stats][api:get_library_user_stats]             | `getLibraryUserStats()`      |
| [get_library_watch_time_stats][api:get_library_watch_time_stats] | `getLibraryWatchTimeStats()` |
| [get_metadata][api:get_metadata]                                 | `getMetadata()`              |
| [get_new_rating_keys][api:get_new_rating_keys]                   | `getNewRatingKeys()`         |
| [get_old_rating_keys][api:get_old_rating_keys]                   | `getOldRatingKeys()`         |
| [get_recently_added][api:get_recently_added]                     | `getRecentlyAdded()`         |
| [get_synced_items][api:get_synced_items]                         | `getSyncedItems()`           |
| [refresh_libraries_list][api:refresh_libraries_list]             | `refreshLibrariesList()`     |
| [search][api:search]                                             | `search()`                   |
| [undelete_library][api:undelete_library]                         | `undeleteLibrary()`          |
| [update_metadata_details][api:update_metadata_details]           | `updateMetadataDetails()`    |

### Miscellaneous

All commands that couldn't be sorted into the other categories. All commands in this category can be accessed via:
- A `TautulliCommandHandler_Miscellaneous` instance.
- `miscellaneous` within an initialized `Tautulli` object.

| API Command | Method |
| :---------- | -----: |
| [arnold][api:arnold]                                     | `arnold()`                |
| [docs][api:docs]                                         | `docs()`                  |
| [docs_md][api:docs_md]                                   | `docsMd()`                |
| [download_config][api:download_config]                   | `downloadConfig()`        |
| [download_database][api:download_database]               | `downloadDatabase()`      |
| [download_log][api:download_log]                         | `downloadLog()`           |
| [download_plex_log][api:download_plex_log]               | `downloadPlexLog()`       |
| [get_date_formats][api:get_date_formats]                 | `getDateFormats()`        |
| [get_geoip_lookup][api:get_geoip_lookup]                 | `getGeoIPLookup()`        |
| [get_logs][api:get_logs]                                 | `getLogs()`               |
| [get_plex_log][api:get_plex_log]                         | `getPlexLog()`            |
| [get_server_friendly_name][api:get_server_friendly_name] | `getServerFriendlyName()` |
| [get_server_id][api:get_server_id]                       | `getServerID()`           |
| [get_server_identity][api:get_server_identity]           | `getServerIdentity()`     |
| [get_server_list][api:get_server_list]                   | `getServerList()`         |
| [get_server_pref][api:get_server_pref]                   | `getServerPref()`         |
| [get_servers_info][api:get_servers_info]                 | `getServersInfo()`        |
| [get_whois_lookup][api:get_whois_lookup]                 | `getWHOISLookup()`        |
| [pms_image_proxy][api:pms_image_proxy]                   | `pmsImageProxy()`         |
| [sql][api:sql]                                           | `sql()`                   |

### Notifications

All commands that are notification (newsletter/notifier) related. All commands in this category can be accessed via:
- A `TautulliCommandHandler_Notifications` instance.
- `notifications` within an initialized `Tautulli` object.

| API Command | Method |
| :---------- | -----: |
| [add_newsletter_config][api:add_newsletter_config]       | `addNewsletterConfig()`   |
| [add_notifier_config][api:add_notifier_config]           | `addNotifierConfig()`     |
| [delete_mobile_device][api:delete_mobile_device]         | `deleteMobileDevive()`    |
| [delete_newsletter][api:delete_newsletter]               | `deleteNewsletter()`      |
| [delete_notifier][api:delete_notifier]                   | `deleteNotifier()`        |
| [get_newsletter_config][api:get_newsletter_config]       | `getNewsletterConfig()`   |
| [get_newsletter_log][api:get_newsletter_log]             | `getNewsletterLog()`      |
| [get_newsletters][api:get_newsletters]                   | `getNewsletters()`        |
| [get_notification_log][api:get_notification_log]         | `getNotificationLog()`    |
| [get_notifier_config][api:get_notifier_config]           | `getNotifierConfig()`     |
| [get_notifier_parameters][api:get_notifier_parameters]   | `getNotifierParameters()` |
| [get_notifiers][api:get_notifiers]                       | `getNotifiers()`          |
| [notify][api:notify]                                     | `notify()`                |
| [notify_newsletter][api:notify_newsletter]               | `notifyNewsletter()`      |
| [notify_recently_added][api:notify_recently_added]       | `notifyRecentlyAdded()`   |
| [register_device][api:register_device]                   | `registerDevice()`        |
| [set_mobile_device_config][api:set_mobile_device_config] | `setMobileDeviceConfig()` |
| [set_newsletter_config][api:set_newsletter_config]       | `setNewsletterConfig()`   |
| [set_notifier_config][api:set_notifier_config]           | `setNotifierConfig()`     |

### System

All commands that are system related. All commands in this category can be accessed via:
- A `TautulliCommandHandler_System` instance.
- `system` within an initialized `Tautulli` object.

| API Command | Method |
| :---------- | -----: |
| [backup_config][api:backup_config]                     | `backupConfig()`          |
| [backup_db][api:backup_db]                             | `backupDB()`              |
| [delete_cache][api:delete_cache]                       | `deleteCache()`           |
| [delete_hosted_images][api:delete_hosted_images]       | `deleteHostedImages()`    |
| [delete_image_cache][api:delete_image_cache]           | `deleteImageCache()`      |
| [delete_login_log][api:delete_login_log]               | `deleteLoginLog()`        |
| [delete_lookup_info][api:delete_lookup_info]           | `deleteLookupInfo()`      |
| [delete_media_info_cache][api:delete_media_info_cache] | `deleteMediaInfoCache()`  |
| [delete_newsletter_log][api:delete_newsletter_log]     | `deleteNewsletterLog()`   |
| [delete_notification_log][api:delete_notification_log] | `deleteNotificationLog()` |
| [get_pms_token][api:get_pms_token]                     | `getPMSToken()`           |
| [get_pms_update][api:get_pms_update]                   | `getPMSUpdate()`          |
| [get_settings][api:get_settings]                       | `getSettings()`           |
| [restart][api:restart]                                 | `restart()`               |
| [status][api:status]                                   | `status()`                |
| [update][api:update]                                   | `update()`                |
| [update_check][api:update_check]                       | `updateCheck()`           |

### Users

All commands that are user related. All commands in this category can be accessed via:
- A `TautulliCommandHandler_Users` instance.
- `users` within an initialized `Tautulli` object.

| API Command | Method |
| :---------- | -----: |
| [delete_all_user_history][api:delete_all_user_history]     | `deleteAllUserHistory()`  |
| [delete_user][api:delete_user]                             | `deleteUser()`            |
| [edit_user][api:edit_user]                                 | `editUser()`              |
| [get_user][api:get_user]                                   | `getUser()`               |
| [get_user_ips][api:get_user_ips]                           | `getUserIPs()`            |
| [get_user_logins][api:get_user_logins]                     | `getUserLogins()`         |
| [get_user_names][api:get_user_names]                       | `getUserNames()`          |
| [get_user_player_stats][api:get_user_player_stats]         | `getUserPlayerStats()`    |
| [get_user_watch_time_stats][api:get_user_watch_time_stats] | `getUserWatchTimeStats()` |
| [get_users][api:get_users]                                 | `getUsers()`              |
| [get_users_table][api:get_users_table]                     | `getUsersTable()`         |
| [refresh_users_list][api:refresh_users_list]               | `refreshUsersList()`      |
| [undelete_user][api:undelete_user]                         | `undeleteUser()`          |

### Not Implemented

All commands that have not been implemented by this package.

| API Command | Reason |
| :---------- | :----- |
| [get_apikey][api:get_apikey]           | In order to use this package a user would need their API key, making it redundant.                          |
| [import_database][api:import_database] | A function like importing a new database should be done through the web GUI to ensure no user errors occur. |

[api:add_newsletter_config]: https://github.com/Tautulli/Tautulli/blob/master/API.md#add_newsletter_config
[api:add_notifier_config]: https://github.com/Tautulli/Tautulli/blob/master/API.md#add_notifier_config
[api:arnold]: https://github.com/Tautulli/Tautulli/blob/master/API.md#arnold
[api:backup_config]: https://github.com/Tautulli/Tautulli/blob/master/API.md#backup_config
[api:backup_db]: https://github.com/Tautulli/Tautulli/blob/master/API.md#backup_db
[api:delete_all_library_history]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_all_library_history
[api:delete_all_user_history]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_all_user_history
[api:delete_cache]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_cache
[api:delete_history]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_history
[api:delete_hosted_images]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_hosted_images
[api:delete_image_cache]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_image_cache
[api:delete_library]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_library
[api:delete_login_log]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_login_log
[api:delete_lookup_info]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_lookup_info
[api:delete_media_info_cache]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_media_info_cache
[api:delete_mobile_device]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_mobile_device
[api:delete_newsletter]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_newsletter
[api:delete_newsletter_log]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_newsletter_log
[api:delete_notification_log]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_notification_log
[api:delete_notifier]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_notifier
[api:delete_recently_added]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_recently_added
[api:delete_temp_sessions]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_newsletter
[api:delete_user]: https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_user
[api:docs]: https://github.com/Tautulli/Tautulli/blob/master/API.md#docs
[api:docs_md]: https://github.com/Tautulli/Tautulli/blob/master/API.md#docs_md
[api:download_config]: https://github.com/Tautulli/Tautulli/blob/master/API.md#download_config
[api:download_database]: https://github.com/Tautulli/Tautulli/blob/master/API.md#download_database
[api:download_log]: https://github.com/Tautulli/Tautulli/blob/master/API.md#download_log
[api:download_plex_log]: https://github.com/Tautulli/Tautulli/blob/master/API.md#download_plex_log
[api:edit_library]: https://github.com/Tautulli/Tautulli/blob/master/API.md#edit_library
[api:edit_user]: https://github.com/Tautulli/Tautulli/blob/master/API.md#edit_user
[api:get_activity]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_activity
[api:get_apikey]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_apikey
[api:get_date_formats]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_date_formats
[api:get_geoip_lookup]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_geoip_lookup
[api:get_history]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_history
[api:get_home_stats]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_home_stats
[api:get_libraries]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_libraries
[api:get_libraries_table]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_libraries_table
[api:get_library]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_library
[api:get_library_media_info]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_library_media_info
[api:get_library_names]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_library_names
[api:get_library_user_stats]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_library_user_stats
[api:get_library_watch_time_stats]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_library_watch_time_stats
[api:get_logs]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_logs
[api:get_metadata]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_metadata
[api:get_new_rating_keys]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_new_rating_keys
[api:get_newsletter_config]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_newsletter_config
[api:get_newsletter_log]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_newsletter_log
[api:get_newsletters]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_newsletters
[api:get_notification_log]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_notification_log
[api:get_notifier_config]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_notifier_config
[api:get_notifier_parameters]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_notifier_parameters
[api:get_notifiers]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_notifiers
[api:get_old_rating_keys]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_old_rating_keys
[api:get_plays_by_date]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_date
[api:get_plays_by_dayofweek]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_dayofweek
[api:get_plays_by_hourofday]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_hourofday
[api:get_plays_by_source_resolution]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_source_resolution
[api:get_plays_by_stream_resolution]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_stream_resolution
[api:get_plays_by_stream_type]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_stream_type
[api:get_plays_by_top_10_platforms]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_top_10_platforms
[api:get_plays_by_top_10_users]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_top_10_users
[api:get_plays_per_month]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_per_month
[api:get_plex_log]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plex_log
[api:get_pms_token]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_pms_token
[api:get_pms_update]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_pms_update
[api:get_recently_added]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_recently_added
[api:get_server_friendly_name]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_server_friendly_name
[api:get_server_id]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_server_id
[api:get_server_identity]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_server_identity
[api:get_server_list]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_server_list
[api:get_server_pref]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_server_pref
[api:get_servers_info]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_servers_info
[api:get_settings]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_settings
[api:get_stream_data]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_stream_data
[api:get_stream_type_by_top_10_platforms]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_stream_type_by_top_10_platforms
[api:get_stream_type_by_top_10_users]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_stream_type_by_top_10_users
[api:get_synced_items]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_synced_items
[api:get_user]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user
[api:get_user_ips]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_ips
[api:get_user_logins]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_logins
[api:get_user_names]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_names
[api:get_user_player_stats]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_player_stats
[api:get_user_watch_time_stats]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_watch_time_stats
[api:get_users]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_users
[api:get_users_table]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_users_table
[api:get_whois_lookup]: https://github.com/Tautulli/Tautulli/blob/master/API.md#get_whois_lookup
[api:import_database]: https://github.com/Tautulli/Tautulli/blob/master/API.md#import_database
[api:notify]: https://github.com/Tautulli/Tautulli/blob/master/API.md#notify
[api:notify_newsletter]: https://github.com/Tautulli/Tautulli/blob/master/API.md#notify_newsletter
[api:notify_recently_added]: https://github.com/Tautulli/Tautulli/blob/master/API.md#notify_recently_added
[api:pms_image_proxy]: https://github.com/Tautulli/Tautulli/blob/master/API.md#pms_image_proxy
[api:refresh_libraries_list]: https://github.com/Tautulli/Tautulli/blob/master/API.md#refresh_libraries_list
[api:refresh_users_list]: https://github.com/Tautulli/Tautulli/blob/master/API.md#refresh_users_list
[api:register_device]: https://github.com/Tautulli/Tautulli/blob/master/API.md#register_device
[api:restart]: https://github.com/Tautulli/Tautulli/blob/master/API.md#restart
[api:search]: https://github.com/Tautulli/Tautulli/blob/master/API.md#search
[api:set_mobile_device_config]: https://github.com/Tautulli/Tautulli/blob/master/API.md#set_mobile_device_config
[api:set_newsletter_config]: https://github.com/Tautulli/Tautulli/blob/master/API.md#set_newsletter_config
[api:set_notifier_config]: https://github.com/Tautulli/Tautulli/blob/master/API.md#set_notifier_config
[api:sql]: https://github.com/Tautulli/Tautulli/blob/master/API.md#sql
[api:status]: https://github.com/Tautulli/Tautulli/blob/master/API.md#status
[api:terminate_session]: https://github.com/Tautulli/Tautulli/blob/master/API.md#terminate_session
[api:undelete_library]: https://github.com/Tautulli/Tautulli/blob/master/API.md#undelete_library
[api:undelete_user]: https://github.com/Tautulli/Tautulli/blob/master/API.md#undelete_user
[api:update]: https://github.com/Tautulli/Tautulli/blob/master/API.md#update
[api:update_check]: https://github.com/Tautulli/Tautulli/blob/master/API.md#update_check
[api:update_metadata_details]: https://github.com/Tautulli/Tautulli/blob/master/API.md#update_metadata_details

[license-shield]: https://img.shields.io/github/license/CometTools/Dart-Packages?style=for-the-badge
[pubdev]: https://pub.dev/packages/tautulli/
[pubdev-shield]: https://img.shields.io/pub/v/tautulli.svg?style=for-the-badge
