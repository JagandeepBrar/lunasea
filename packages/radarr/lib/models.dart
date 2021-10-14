/// Library containing all model definitions for Radarr data.
library radarr_models;

/// Commands
export 'src/models/command/command.dart';
export 'src/models/command/command_body.dart';

/// Custom Formats
export 'src/models/custom_format/custom_format.dart';
export 'src/models/custom_format/custom_format_specifications.dart';

/// Filesystem
export 'src/models/filesystem/directory.dart';
export 'src/models/filesystem/disk_space.dart';
export 'src/models/filesystem/file.dart';
export 'src/models/filesystem/filesystem.dart';

/// Exclusions
export 'src/models/exclusions/exclusion.dart';

/// Extra File
export 'src/models/extrafile/extra_file.dart';

/// Health Check
export 'src/models/health_check/health_check.dart';

/// History
export 'src/models/history/history.dart';
export 'src/models/history/history_record.dart';

/// Images
export 'src/models/image/image.dart';

/// Import List
export 'src/models/import_list/import_list.dart';

/// Manual Import
export 'src/models/manual_import/manual_import.dart';
export 'src/models/manual_import/manual_import_file.dart';
export 'src/models/manual_import/manual_import_rejection.dart';
export 'src/models/manual_import/manual_import_update.dart';
export 'src/models/manual_import/manual_import_update_data.dart';

/// Movie
export 'src/models/movie/alternate_titles.dart';
export 'src/models/movie/collection.dart';
export 'src/models/movie/credits.dart';
export 'src/models/movie/movie.dart';
export 'src/models/movie/movie_file.dart';
export 'src/models/movie/movie_file_media_info.dart';
export 'src/models/movie/movie_file_quality.dart';
export 'src/models/movie/rating.dart';

/// Quality Profile
export 'src/models/quality_profile/format_item.dart';
export 'src/models/quality_profile/item.dart';
export 'src/models/quality_profile/language.dart';
export 'src/models/quality_profile/quality.dart';
export 'src/models/quality_profile/quality_definition.dart';
export 'src/models/quality_profile/quality_profile.dart';
export 'src/models/quality_profile/quality_revision.dart';

/// Queue
export 'src/models/queue/queue.dart';
export 'src/models/queue/queue_record.dart';
export 'src/models/queue/queue_status.dart';
export 'src/models/queue/queue_status_message.dart';

/// Release
export 'src/models/release/release.dart';

/// Root Folder
export 'src/models/root_folder/root_folder.dart';
export 'src/models/root_folder/unmapped_folder.dart';

/// System
export 'src/models/system/status.dart';

/// Tag
export 'src/models/tag/tag.dart';
