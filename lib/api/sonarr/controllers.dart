/// Library containing all logic and accessors to make calls to Sonarr's API.
library sonarr_commands;

import 'package:lunasea/api/sonarr/models.dart';
import 'package:lunasea/api/sonarr/types.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

// Calendar
part 'controllers/calendar.dart';
part 'controllers/calendar/get_calendar.dart';

// Command
part 'controllers/command.dart';
part 'controllers/command/backup.dart';
part 'controllers/command/episode_search.dart';
part 'controllers/command/missing_episode_search.dart';
part 'controllers/command/queue.dart';
part 'controllers/command/refresh_monitored_downloads.dart';
part 'controllers/command/refresh_series.dart';
part 'controllers/command/rescan_series.dart';
part 'controllers/command/rss_sync.dart';
part 'controllers/command/season_search.dart';
part 'controllers/command/series_search.dart';

// Episode File
part 'controllers/episode_file.dart';
part 'controllers/episode_file/delete_episode_file.dart';
part 'controllers/episode_file/delete_episode_files.dart';
part 'controllers/episode_file/get_episode_file.dart';
part 'controllers/episode_file/get_series_episode_files.dart';

// Episode
part 'controllers/episode.dart';
part 'controllers/episode/get_episode.dart';
part 'controllers/episode/get_episodes.dart';
part 'controllers/episode/set_monitored.dart';
part 'controllers/episode/update_episode.dart';

// History
part 'controllers/history.dart';
part 'controllers/history/get_history.dart';
part 'controllers/history/get_history_by_series.dart';

// Import List
part 'controllers/import_list.dart';
part 'controllers/import_list/get_exclusion_list.dart';

// Profile
part 'controllers/profile.dart';
part 'controllers/profile/get_language_profiles.dart';
part 'controllers/profile/get_quality_profiles.dart';

// Queue
part 'controllers/queue.dart';
part 'controllers/queue/delete_queue.dart';
part 'controllers/queue/get_queue.dart';
part 'controllers/queue/get_queue_details.dart';

// Releases
part 'controllers/release.dart';
part 'controllers/release/add_release.dart';
part 'controllers/release/get_release.dart';
part 'controllers/release/get_season_release.dart';

// Root Folder
part 'controllers/root_folder.dart';
part 'controllers/root_folder/get_root_folders.dart';

// Series
part 'controllers/series.dart';
part 'controllers/series/add_series.dart';
part 'controllers/series/delete_series.dart';
part 'controllers/series/get_all_series.dart';
part 'controllers/series/get_series.dart';
part 'controllers/series/update_series.dart';

// Series Lookup
part 'controllers/series_lookup.dart';
part 'controllers/series_lookup/lookup.dart';

// System
part 'controllers/system.dart';
part 'controllers/system/get_status.dart';

// Tags
part 'controllers/tag.dart';
part 'controllers/tag/add_tag.dart';
part 'controllers/tag/delete_tag.dart';
part 'controllers/tag/get_all_tags.dart';
part 'controllers/tag/get_tag.dart';
part 'controllers/tag/update_tag.dart';

// Wanted/Missing
part 'controllers/wanted.dart';
part 'controllers/wanted/get_missing.dart';
