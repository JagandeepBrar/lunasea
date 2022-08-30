/// Library containing all model definitions for Sonarr data.
library sonarr_models;

/// Calendar
export 'models/calendar/calendar.dart';

/// Command
export 'models/command/command.dart';
export 'models/command/command_body.dart';

/// Episode
export 'models/episode/episode.dart';

/// Episode File
export 'models/episode_file/episode_file.dart';
export 'models/episode_file/episode_file_language.dart';
export 'models/episode_file/episode_file_media_info.dart';
export 'models/episode_file/episode_file_quality.dart';
export 'models/episode_file/episode_file_quality_quality.dart';
export 'models/episode_file/episode_file_quality_revision.dart';

/// History
export 'models/history/history.dart';
export 'models/history/history_record.dart';

/// Import List
export 'models/import_list/exclusion.dart';

/// Profile
export 'models/profile/language_profile_cutoff.dart';
export 'models/profile/language_profile_item.dart';
export 'models/profile/language_profile_item_language.dart';
export 'models/profile/language_profile.dart';
export 'models/profile/quality_profile_cutoff.dart';
export 'models/profile/quality_profile_item_quality.dart';
export 'models/profile/quality_profile_item.dart';
export 'models/profile/quality_profile.dart';

/// Queue
export 'models/queue/queue.dart';
export 'models/queue/queue_record.dart';
export 'models/queue/queue_status_message.dart';

/// Release
export 'models/release/release.dart';
export 'models/release/added_release.dart';

/// Root Folder
export 'models/root_folder/root_folder.dart';
export 'models/root_folder/unmapped_folder.dart';

/// Series
export 'models/series/alternate_title.dart';
export 'models/series/image.dart';
export 'models/series/rating.dart';
export 'models/series/season_statistics.dart';
export 'models/series/season.dart';
export 'models/series/series.dart';
export 'models/series/series_statistics.dart';

/// System
export 'models/system/status.dart';

/// Tags
export 'models/tag/tag.dart';

/// Wanted/Missing
export 'models/wanted_missing/missing.dart';
export 'models/wanted_missing/missing_record.dart';
