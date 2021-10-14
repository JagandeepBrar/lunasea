# 2.1.1+1
- Updated package metadata
# 2.1.1
- Fix `RadarrManualImportUpdateData` content for Radarr v3.1.0+
# 2.1.0
- Ability to fetch queue
- Ability to delete a queue record
# 2.0.0
- Ability to trigger manual import command
- Unify `RadarrQualityProfile` definitions
- Support for fetching languages
- Support for fetching quality definitions
- Add support for manual import fetching commands
- Add `images` array of `RadarrImage` to `RadarrMovieCollection`
- Added command: `DownloadedMoviesScan`
- Updated packages
- Null-safety/NNBD support
- Add support to fetch Radarr queue status
- Add support to fetch filesystem folders and files
# 1.1.4+1
- Updated packages
# 1.1.4
- Updated packages
# 1.1.3
- Removed indexerFlag from `RadarrMovieFile`
# 1.1.2
- Removed `RadarrCustomFormatSpecificationsFields` and replaced `fields` with a generic `Map<dynamic, dynamic>` as the data can be very dynamic
# 1.1.1
- Ability to fetch details about the health of your Radarr instance
# 1.1.0
- Do not write null values when converting models back to a JSON
- Set `id` to 0 when creating a new movie object in the Radarr database
# 1.0.2
- Ability to fetch import lists
- Ability to fetch movies from import lists
# 1.0.1
- Added the ability to push a release to Radarr's attached download clients
# 1.0.0
- Initial release
