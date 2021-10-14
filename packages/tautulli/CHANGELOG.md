# 2.0.0+1
- Updated package metadata
# 2.0.0
- Support for null-safety/NNBD.
# 1.2.2+1
- Updated packages
# 1.2.2
- Updated packages
# 1.2.1
- Added "Burn" transcode decision to `TautulliTranscodeDecision`
# 1.2.0
- Removed the option to disable strictTLS when creating a new `Tautulli` instance -- if you want to disable strict TLS, you should configure the HTTPClient yourself
# 1.1.0+3
- Updated GitHub repository information
# 1.1.0+2
- Updated LICENSE link for shield
# 1.1.0+1
- Updated pubspec.yaml to include new references to GitHub repository
# 1.1.0
- Added `TautulliUpdateCheck` model
- BREAKING: `updateCheck()` now returns `TautulliUpdateCheck` object instead of a boolean
# 1.0.5
- Fix `TautulliPlexLogType` value not being set when fetching Plex Media * logs
# 1.0.4
- BREAKING: Removed `NULL` value from `TautulliStatsType`
# 1.0.3
- `getActivity()` now returns null instead of throwing an error on an unfound sessionKey or sessionId.
# 1.0.2
- BREAKING: Renamed `device_name` to `deviceName` in TautulliSyncedItem
# 1.0.1
- Add `.name` to TautulliTranscodeDecision to get a readable/formatted string of the transcode decision
# 1.0.0+3
- Fixed dartdocs on `teriminateSession()`
# 1.0.0+2
- Cleanup some comments
# 1.0.0+1
- Updated example with more commands
# 1.0.0
- Implemented all additional commands
- Ensure typing in all deserializing operations
- General code cleanup
# 0.0.8
- Commands: `get_logs`
- Commands: `get_stream_type_by_top_10_users`
- Commands: `get_stream_type_by_top_10_platforms`
- Commands: `get_plays_per_month`
- Commands: `get_plays_by_top_10_users`
- Commands: `get_plays_by_top_10_platforms`
- Commands: `get_plays_by_stream_type`
- Commands: `get_plays_by_stream_resolution`
- Commands: `get_plays_by_source_resolution`
- Commands: `get_plays_by_hourofday`
- Commands: `get_plays_by_dayofweek`
- Commands: `get_plays_by_date`
- Commands: `get_newsletter_log`
# 0.0.7
- Commands: `get_server_pref`
- Commands: `get_newsletters`
- Commands: `get_user_logins`
- Commands: `get_servers_info`
- Commands: `sql`
- Commands: `get_settings`
- Commands: `get_notification_log`
- Commands: `get_notifier_parameters`
- Commands: `get_notifiers`
- Commands: `get_plex_log`
- Commands: `get_user_names`
# 0.0.6
- Commands: `download_log`
- Commands: `download_database`
- Commnads: `download_plex_log`
- Commands: `download_config`
- Commands: `get_library_user_stats`
- Commands: `get_library_watch_time_stats`
- Commands: `get_pms_update`
- Models: TautulliPMSUpdate
- Models: TautulliLibraryUserStats
- Models: TautulliLibraryWatchTimeStats
# 0.0.5
- Commands: `get_library_names`
- Commands: `get_library`
- Commands: `get_libraries`
- Commands: `get_server_list`
- Commands: `get_synced_items`
- Commands: `get_user`
- Commands: `get_users`
- Models: TautulliLibraryName
- Models: TautulliLibrary
- Models: TautulliSingleLibrary
- Models: TautulliSyncedItem
- Models: TautulliTableUser
# 0.0.4
- Commands: `delete_recently_added`
- Commands: `delete_temp_sessions`
- Commands: `delete_user`
- Commands: `edit_library`
- Commands: `edit_user`
- Commands: `get_pms_token`
- Commands: `get_server_friendly_name`
- Commands: `get_server_id`
- Commands: `pms_image_proxy`
- Models: TautulliServerIdentity
- Types: TautulliFallbackImage
# 0.0.3+1
- Fixed Exception throwing
- Fixed some comments
# 0.0.3
- Commands: `refresh_users_list`
- Commands: `refresh_libraries_list`
- Commands: `delete_mobile_device`
- Commands: `delete_newsletter`
- Commands: `delete_newsletter_log`
- Commands: `delete_notifier_log`
- Commands: `delete_notifier`
- Commands: `notify_recently_added`
- Commands: `notify_newsletter`
- Commands: `notify`
- Commands: `get_whois_lookup`
- Commands: `get_users_table`
- Models: TautulliUsersTable
- Models: TautulliUser
- Models: TautulliWHOISInfo
- Models: TautulliWHOISSubnet
- Types: TautulliUsersOrderColumn
- BREAKING: Changed `TautulliCommandHandler_User` to `TautulliCommandHandler_Users`
- BREAKING: Changed `TautulliCommandHandler_Library` to `TautulliCommandHandler_Libraries`
# 0.0.2
- Commands: Added history command handler
- Commands: `delete_all_user_history`
- Commands: `delete_history`
- Commands: `delete_hosted_images`
- Commands: `delete_library`
- Commands: `delete_lookup_info`
- Commands: `delete_media_info_cache`
- Commands: `get_geoip_lookup`
- Commands: `get_histoy`
- Models: TautulliHistory
- Models: TautulliHistoryRecord
- Models: TautulliGeolocationInfo
# 0.0.1
- Models: Full deserialization of `TautulliSession`
- Commands: Combined Notifier & Newsletter handlers into Notifications
- Commands: Implemented `add_newsletter_config`
- Commands: Implemented `add_notifier_config`
- Commands: Implemented `status`
- Commands: Implemented `set_notifier_config`
- Commands: Implemented `set_newsletter_config`
- Commands: Implemented `set_mobile_device_config`
- Commands: Implemented `register_device`
- Commands: Implemented `delete_all_library_history`
- Types: TautulliSessionState
- Types: TautulliSessionLocation
- Types: TautulliTranscodeDecision
- Types: Added null/empty value safety
# 0.0.1-pre.6
- Implemented [backup_config](https://github.com/Tautulli/Tautulli/blob/master/API.md#backup_config)
- Implemented [backup_db](https://github.com/Tautulli/Tautulli/blob/master/API.md#backup_db)
# 0.0.1-pre.5
- Updated pubspec.yaml
# 0.0.1-pre.4
- Implemented [restart](https://github.com/Tautulli/Tautulli/blob/master/API.md#restart)
- Implemented [terminate_session](https://github.com/Tautulli/Tautulli/blob/master/API.md#terminate_session)
# 0.0.1-pre.3
- Implemented [update](https://github.com/Tautulli/Tautulli/blob/master/API.md#update)
- Implemented [update_check](https://github.com/Tautulli/Tautulli/blob/master/API.md#update_check)
# 0.0.1-pre.2
- Implemented HTTP client
- Implemented [arnold](https://github.com/Tautulli/Tautulli/blob/master/API.md#arnold)
# 0.0.1-pre.1
- Initial Release
