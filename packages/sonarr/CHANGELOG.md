# 2.0.1
- Added support for executing command: `RefreshMonitoredDownloads`
# 2.0.0
- Add support for setting series type when POSTing/adding a new series
- Updated for null-safety/NNBD support
# 1.1.1+1
- Updated packages
# 1.1.1
- Updated packages
# 1.1.0+1
- Remove unneeded imports to improve compatability
# 1.1.0
- Removed the option to disable strictTLS when creating a new `Sonarr` instance -- if you want to disable strict TLS, you should configure the HTTPClient yourself
# 1.0.1+1
- Updated GitHub repository information
# 1.0.1
- Fixed bug in `getHistory()` where sorting direction would not get set
# 1.0.0+1
- Updated LICENSE link for shield
# 1.0.0
- Updated pubspec.yaml to include new repository links
# 0.0.5
- Removed `language` from `SonarrRelease` to allow cross-compatibility with Sonarr v2 and v3
# 0.0.4
- Added `statusMessages` to `SonarrQueueRecord`
- Added `SonarrQueueStatusMessage` model
# 0.0.3
- `queue.getQueue()` implemented to fetch items in queue
- `queue.deleteQueue(:id)` implemented to delete item in queue with ID
- Model for `SonarrQueueRecord`
# 0.0.2
- `tag.addTag()` now returns the newly returned tag
- Implemented all `tag` API calls
- Model for `SonarrTag`
- Many additional commands implemented
- Many additional models created
# 0.0.1-pre.18
- Fix: `deleteFiles` when attempting to delete a series would have no effect
# 0.0.1-pre.17
- Implemented additional `/series` commands (`addSeries`, `updateSeries`, `deleteSeries`)
# 0.0.1-pre.16
- Implemented additional `/command` commands (`SeasonSearch`, `EpisodeSearch`)
# 0.0.1-pre.15
- Implemented `calendar` to fetch calendar entries
- Models for `SonarrCalendar` and nested models
- Implemented `episodefile` to fetch episode file details
- Models for `SonarrEpisodeFile` and nested models
# 0.0.1-pre.14
- Implemented `system/status` to fetch system information
- Models for `SonarrStatus` and nested models
- Renamed `SonarrCommandHandler_WantedMissing` to `SonarrCommandHandler_Wanted`
# 0.0.1-pre.13
- Implemented `/wanted/missing` to fetch missing episodes
- Models for `SonarrMissing` and nested models
- Added sort direction and wanted/missing sort key types
# 0.0.1-pre.12
- Removed `NULL` from `SonarrSeriesType`, instead return actual null value
# 0.0.1-pre.11
- Added `rootFolderPath` string to `SonarrSeriesLookup` for easily setting root folder
# 0.0.1-pre.10
- Implemented `/rootfolder` to fetch root folders
- Models for `SonarrRootFolder` and nested models
# 0.0.1-pre.9
- Implemented `/series/lookup` to fetch series lookup results
- Models for `SonarrSeriesLookup` and nested models
# 0.0.1-pre.8
- Implemented additional `/command` commands (`Backup`, `MissingEpisodeSearch`, `RssSync`)
- Updated README.md
# 0.0.1-pre.7
- Implemented some `/command` commands (`RescanSeries`, `RefreshSeries`)
- Models for `SonarrCommand` and nested models
# 0.0.1-pre.6
- Implemented `/v3/languageprofile` to fetch all language profiles
- Models for `SonarrLanguageProfile` and nested models
- Correctly export all model types
# 0.0.1-pre.5
- Implemented `/profile` to fetch all quality profiles
- Models for `SonarrQualityProfile` and nested models
# 0.0.1-pre.4
- Fixed DateTime parsing when date is null
# 0.0.1-pre.3
- All dates in `/series` calls now return DateTime objects
# 0.0.1-pre.2
- Implemented `/series` to fetch all series
- Implemented `/series/{id}` to fetch single series
- Models for `SonarrSeries` and nested models
# 0.0.1-pre.1
- Initial Release
