/// Library containing all logic and accessors to make calls to Sonarr's API.
library sonarr_commands;

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:sonarr/types.dart';
import 'models.dart';

// Calendar
part 'src/commands/calendar.dart';
part 'src/commands/calendar/get_calendar.dart';

// Command
part 'src/commands/command.dart';
part 'src/commands/command/backup.dart';
part 'src/commands/command/episode_search.dart';
part 'src/commands/command/missing_episode_search.dart';
part 'src/commands/command/queue.dart';
part 'src/commands/command/refresh_monitored_downloads.dart';
part 'src/commands/command/refresh_series.dart';
part 'src/commands/command/rescan_series.dart';
part 'src/commands/command/rss_sync.dart';
part 'src/commands/command/season_search.dart';

// Episode File
part 'src/commands/episode_file.dart';
part 'src/commands/episode_file/delete_episode_file.dart';
part 'src/commands/episode_file/get_episode_file.dart';
part 'src/commands/episode_file/get_series_episode_files.dart';

// Episode
part 'src/commands/episode.dart';
part 'src/commands/episode/get_all_episodes.dart';
part 'src/commands/episode/get_episode.dart';
part 'src/commands/episode/update_episode.dart';

// History
part 'src/commands/history.dart';
part 'src/commands/history/get_history.dart';

// Profile
part 'src/commands/profile.dart';
part 'src/commands/profile/get_language_profiles.dart';
part 'src/commands/profile/get_quality_profiles.dart';

// Queue
part 'src/commands/queue.dart';
part 'src/commands/queue/delete_queue.dart';
part 'src/commands/queue/get_queue.dart';

// Releases
part 'src/commands/release.dart';
part 'src/commands/release/add_release.dart';
part 'src/commands/release/get_release.dart';
part 'src/commands/release/get_season_release.dart';

// Root Folder
part 'src/commands/root_folder.dart';
part 'src/commands/root_folder/get_root_folders.dart';

// Series
part 'src/commands/series.dart';
part 'src/commands/series/add_series.dart';
part 'src/commands/series/delete_series.dart';
part 'src/commands/series/get_all_series.dart';
part 'src/commands/series/get_series.dart';
part 'src/commands/series/update_series.dart';

// Series Lookup
part 'src/commands/series_lookup.dart';
part 'src/commands/series_lookup/lookup.dart';

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

// Wanted/Missing
part 'src/commands/wanted.dart';
part 'src/commands/wanted/get_missing.dart';
