/// Library containing all model definitions for Sonarr data.
library sonarr_models;

/// Calendar
export 'src/models/calendar/calendar.dart';

/// Command
export 'src/models/command/command.dart';
export 'src/models/command/command_body.dart';

/// Episode
export 'src/models/episode/episode.dart';

/// Episode File
export 'src/models/episode_file/episode_file.dart';
export 'src/models/episode_file/episode_file_language.dart';
export 'src/models/episode_file/episode_file_media_info.dart';
export 'src/models/episode_file/episode_file_quality.dart';
export 'src/models/episode_file/episode_file_quality_quality.dart';
export 'src/models/episode_file/episode_file_quality_revision.dart';

/// History
export 'src/models/history/history.dart';
export 'src/models/history/history_record.dart';
export 'src/models/history/history_record_data.dart';

/// Profile
export 'src/models/profile/language_profile_cutoff.dart';
export 'src/models/profile/language_profile_item.dart';
export 'src/models/profile/language_profile_item_language.dart';
export 'src/models/profile/language_profile.dart';
export 'src/models/profile/quality_profile_cutoff.dart';
export 'src/models/profile/quality_profile_item_quality.dart';
export 'src/models/profile/quality_profile_item.dart';
export 'src/models/profile/quality_profile.dart';

/// Queue
export 'src/models/queue/queue_record.dart';
export 'src/models/queue/queue_status_message.dart';

/// Release
export 'src/models/release/release.dart';
export 'src/models/release/added_release.dart';

/// Root Folder
export 'src/models/root_folder/root_folder.dart';
export 'src/models/root_folder/unmapped_folder.dart';

/// Series
export 'src/models/series/alternate_title.dart';
export 'src/models/series/image.dart';
export 'src/models/series/rating.dart';
export 'src/models/series/season_statistics.dart';
export 'src/models/series/season.dart';
export 'src/models/series/series.dart';
export 'src/models/series/series_statistics.dart';

/// Series/Lookup
export 'src/models/series_lookup/series_lookup.dart';

/// System
export 'src/models/system/status.dart';

/// Tags
export 'src/models/tag/tag.dart';

/// Wanted/Missing
export 'src/models/wanted_missing/missing.dart';
export 'src/models/wanted_missing/missing_record.dart';
