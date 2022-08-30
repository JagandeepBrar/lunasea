/// Library containing all logic and accessors to make calls to Radarr's API.
library radarr_commands;

import 'package:dio/dio.dart';
import 'package:lunasea/api/radarr/models.dart';
import 'package:lunasea/api/radarr/types.dart';

// Commands
part 'commands/command.dart';
part 'commands/command/backup.dart';
part 'commands/command/downloaded_movies_scan.dart';
part 'commands/command/manual_import.dart';
part 'commands/command/missing_movie_search.dart';
part 'commands/command/movies_search.dart';
part 'commands/command/refresh_monitored_downloads.dart';
part 'commands/command/refresh_movie.dart';
part 'commands/command/rss_sync.dart';

// Credits
part 'commands/credits.dart';
part 'commands/credits/get_credits.dart';
// Exclusions
part 'commands/exclusions.dart';
part 'commands/exclusions/get_exclusion.dart';
part 'commands/exclusions/get_all_exclusions.dart';

// Extra File
part 'commands/extra_file.dart';
part 'commands/extra_file/get_extra_files.dart';

// Filesystem
part 'commands/filesystem.dart';
part 'commands/filesystem/get_all_disk_spaces.dart';
part 'commands/filesystem/get_filesystem.dart';

// Health Check
part 'commands/health_check.dart';
part 'commands/health_check/get_all_health_checks.dart';

// History
part 'commands/history.dart';
part 'commands/history/get_history.dart';
part 'commands/history/get_movie_history.dart';

// Import List
part 'commands/import_list.dart';
part 'commands/import_list/get_all_import_lists.dart';
part 'commands/import_list/get_import_list.dart';
part 'commands/import_list/get_movies_from_list.dart';

// Language
part 'commands/language.dart';
part 'commands/language/get_all_languages.dart';
part 'commands/language/get_language.dart';

// Manual Import
part 'commands/manual_import.dart';
part 'commands/manual_import/get_manual_import.dart';
part 'commands/manual_import/update_manual_import.dart';

// Movie
part 'commands/movie.dart';
part 'commands/movie/add_movie.dart';
part 'commands/movie/delete_movie.dart';
part 'commands/movie/get_movie.dart';
part 'commands/movie/get_all_movies.dart';
part 'commands/movie/update_movie.dart';

// Movie File
part 'commands/movie_file.dart';
part 'commands/movie_file/delete_movie_file.dart';
part 'commands/movie_file/get_movie_file.dart';

// Movie Lookup
part 'commands/movie_lookup.dart';
part 'commands/movie_lookup/get_movie_lookup.dart';

// Releases
part 'commands/release.dart';
part 'commands/release/get_releases.dart';
part 'commands/release/push_release.dart';

// Quality Profile
part 'commands/quality_profile.dart';
part 'commands/quality_profile/get_quality_profile.dart';
part 'commands/quality_profile/get_quality_definitions.dart';
part 'commands/quality_profile/get_all_quality_profiles.dart';

// Queue
part 'commands/queue.dart';
part 'commands/queue/delete_queue.dart';
part 'commands/queue/get_queue.dart';
part 'commands/queue/get_queue_status.dart';

// Root Folder
part 'commands/root_folder.dart';
part 'commands/root_folder/get_root_folders.dart';

// System
part 'commands/system.dart';
part 'commands/system/get_status.dart';

// Tags
part 'commands/tag.dart';
part 'commands/tag/add_tag.dart';
part 'commands/tag/delete_tag.dart';
part 'commands/tag/get_all_tags.dart';
part 'commands/tag/get_tag.dart';
part 'commands/tag/update_tag.dart';
