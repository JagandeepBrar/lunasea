/// Library containing all logic and accessors to make calls to Radarr's API.
library radarr_commands;

import 'package:dio/dio.dart';
import 'models.dart';
import 'types.dart';

// Commands
part 'src/commands/command.dart';
part 'src/commands/command/backup.dart';
part 'src/commands/command/downloaded_movies_scan.dart';
part 'src/commands/command/manual_import.dart';
part 'src/commands/command/missing_movie_search.dart';
part 'src/commands/command/movies_search.dart';
part 'src/commands/command/refresh_monitored_downloads.dart';
part 'src/commands/command/refresh_movie.dart';
part 'src/commands/command/rss_sync.dart';

// Credits
part 'src/commands/credits.dart';
part 'src/commands/credits/get_credits.dart';
// Exclusions
part 'src/commands/exclusions.dart';
part 'src/commands/exclusions/get_exclusion.dart';
part 'src/commands/exclusions/get_all_exclusions.dart';

// Extra File
part 'src/commands/extra_file.dart';
part 'src/commands/extra_file/get_extra_files.dart';

// Filesystem
part 'src/commands/filesystem.dart';
part 'src/commands/filesystem/get_all_disk_spaces.dart';
part 'src/commands/filesystem/get_filesystem.dart';

// Health Check
part 'src/commands/health_check.dart';
part 'src/commands/health_check/get_all_health_checks.dart';

// History
part 'src/commands/history.dart';
part 'src/commands/history/get_history.dart';
part 'src/commands/history/get_movie_history.dart';

// Import List
part 'src/commands/import_list.dart';
part 'src/commands/import_list/get_all_import_lists.dart';
part 'src/commands/import_list/get_import_list.dart';
part 'src/commands/import_list/get_movies_from_list.dart';

// Language
part 'src/commands/language.dart';
part 'src/commands/language/get_all_languages.dart';
part 'src/commands/language/get_language.dart';

// Manual Import
part 'src/commands/manual_import.dart';
part 'src/commands/manual_import/get_manual_import.dart';
part 'src/commands/manual_import/update_manual_import.dart';

// Movie
part 'src/commands/movie.dart';
part 'src/commands/movie/add_movie.dart';
part 'src/commands/movie/delete_movie.dart';
part 'src/commands/movie/get_movie.dart';
part 'src/commands/movie/get_all_movies.dart';
part 'src/commands/movie/update_movie.dart';

// Movie File
part 'src/commands/movie_file.dart';
part 'src/commands/movie_file/delete_movie_file.dart';
part 'src/commands/movie_file/get_movie_file.dart';

// Movie Lookup
part 'src/commands/movie_lookup.dart';
part 'src/commands/movie_lookup/get_movie_lookup.dart';

// Releases
part 'src/commands/release.dart';
part 'src/commands/release/get_releases.dart';
part 'src/commands/release/push_release.dart';

// Quality Profile
part 'src/commands/quality_profile.dart';
part 'src/commands/quality_profile/get_quality_profile.dart';
part 'src/commands/quality_profile/get_quality_definitions.dart';
part 'src/commands/quality_profile/get_all_quality_profiles.dart';

// Queue
part 'src/commands/queue.dart';
part 'src/commands/queue/delete_queue.dart';
part 'src/commands/queue/get_queue.dart';
part 'src/commands/queue/get_queue_status.dart';

// Root Folder
part 'src/commands/root_folder.dart';
part 'src/commands/root_folder/get_root_folders.dart';

// System
part 'src/commands/system.dart';
part 'src/commands/system/get_status.dart';

// Tags
part 'src/commands/tag.dart';
part 'src/commands/tag/add_tag.dart';
part 'src/commands/tag/delete_tag.dart';
part 'src/commands/tag/get_all_tags.dart';
part 'src/commands/tag/get_tag.dart';
part 'src/commands/tag/update_tag.dart';
