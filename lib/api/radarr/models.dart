/// Library containing all model definitions for Radarr data.
library radarr_models;

/// Commands
export 'models/command/command.dart';
export 'models/command/command_body.dart';

/// Custom Formats
export 'models/custom_format/custom_format.dart';
export 'models/custom_format/custom_format_specifications.dart';

/// Filesystem
export 'models/filesystem/directory.dart';
export 'models/filesystem/disk_space.dart';
export 'models/filesystem/file.dart';
export 'models/filesystem/filesystem.dart';

/// Exclusions
export 'models/exclusions/exclusion.dart';

/// Extra File
export 'models/extrafile/extra_file.dart';

/// Health Check
export 'models/health_check/health_check.dart';

/// History
export 'models/history/history.dart';
export 'models/history/history_record.dart';

/// Images
export 'models/image/image.dart';

/// Import List
export 'models/import_list/import_list.dart';

/// Manual Import
export 'models/manual_import/manual_import.dart';
export 'models/manual_import/manual_import_file.dart';
export 'models/manual_import/manual_import_rejection.dart';
export 'models/manual_import/manual_import_update.dart';
export 'models/manual_import/manual_import_update_data.dart';

/// Movie
export 'models/movie/alternate_titles.dart';
export 'models/movie/collection.dart';
export 'models/movie/credits.dart';
export 'models/movie/movie.dart';
export 'models/movie/movie_file.dart';
export 'models/movie/movie_file_media_info.dart';
export 'models/movie/movie_file_quality.dart';
export 'models/movie/rating.dart';

/// Quality Profile
export 'models/quality_profile/format_item.dart';
export 'models/quality_profile/item.dart';
export 'models/quality_profile/language.dart';
export 'models/quality_profile/quality.dart';
export 'models/quality_profile/quality_definition.dart';
export 'models/quality_profile/quality_profile.dart';
export 'models/quality_profile/quality_revision.dart';

/// Queue
export 'models/queue/queue.dart';
export 'models/queue/queue_record.dart';
export 'models/queue/queue_status.dart';
export 'models/queue/queue_status_message.dart';

/// Release
export 'models/release/release.dart';

/// Root Folder
export 'models/root_folder/root_folder.dart';
export 'models/root_folder/unmapped_folder.dart';

/// System
export 'models/system/status.dart';

/// Tag
export 'models/tag/tag.dart';
