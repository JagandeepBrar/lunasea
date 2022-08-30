/// Library containing all logic and accessors to make calls to Sonarr's API.
library sonarr_commands;

import 'package:lunasea/api/sonarr/models.dart';
import 'package:lunasea/api/sonarr/types.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

// Calendar
part 'src/controllers/calendar.dart';
part 'src/controllers/calendar/get_calendar.dart';

// Command
part 'src/controllers/command.dart';
part 'src/controllers/command/backup.dart';
part 'src/controllers/command/episode_search.dart';
part 'src/controllers/command/missing_episode_search.dart';
part 'src/controllers/command/queue.dart';
part 'src/controllers/command/refresh_monitored_downloads.dart';
part 'src/controllers/command/refresh_series.dart';
part 'src/controllers/command/rescan_series.dart';
part 'src/controllers/command/rss_sync.dart';
part 'src/controllers/command/season_search.dart';
part 'src/controllers/command/series_search.dart';

// Episode File
part 'src/controllers/episode_file.dart';
part 'src/controllers/episode_file/delete_episode_file.dart';
part 'src/controllers/episode_file/get_episode_file.dart';
part 'src/controllers/episode_file/get_series_episode_files.dart';

// Episode
part 'src/controllers/episode.dart';
part 'src/controllers/episode/get_episode.dart';
part 'src/controllers/episode/get_episodes.dart';
part 'src/controllers/episode/set_monitored.dart';
part 'src/controllers/episode/update_episode.dart';

// History
part 'src/controllers/history.dart';
part 'src/controllers/history/get_history.dart';
part 'src/controllers/history/get_history_by_series.dart';

// Import List
part 'src/controllers/import_list.dart';
part 'src/controllers/import_list/get_exclusion_list.dart';

// Profile
part 'src/controllers/profile.dart';
part 'src/controllers/profile/get_language_profiles.dart';
part 'src/controllers/profile/get_quality_profiles.dart';

// Queue
part 'src/controllers/queue.dart';
part 'src/controllers/queue/delete_queue.dart';
part 'src/controllers/queue/get_queue.dart';
part 'src/controllers/queue/get_queue_details.dart';

// Releases
part 'src/controllers/release.dart';
part 'src/controllers/release/add_release.dart';
part 'src/controllers/release/get_release.dart';
part 'src/controllers/release/get_season_release.dart';

// Root Folder
part 'src/controllers/root_folder.dart';
part 'src/controllers/root_folder/get_root_folders.dart';

// Series
part 'src/controllers/series.dart';
part 'src/controllers/series/add_series.dart';
part 'src/controllers/series/delete_series.dart';
part 'src/controllers/series/get_all_series.dart';
part 'src/controllers/series/get_series.dart';
part 'src/controllers/series/update_series.dart';

// Series Lookup
part 'src/controllers/series_lookup.dart';
part 'src/controllers/series_lookup/lookup.dart';

// System
part 'src/controllers/system.dart';
part 'src/controllers/system/get_status.dart';

// Tags
part 'src/controllers/tag.dart';
part 'src/controllers/tag/add_tag.dart';
part 'src/controllers/tag/delete_tag.dart';
part 'src/controllers/tag/get_all_tags.dart';
part 'src/controllers/tag/get_tag.dart';
part 'src/controllers/tag/update_tag.dart';

// Wanted/Missing
part 'src/controllers/wanted.dart';
part 'src/controllers/wanted/get_missing.dart';
