/// Library containing all model definitions for Readarr data.
library readarr_models;

/// Author
export 'src/models/author/image.dart';
export 'src/models/author/rating.dart';
export 'src/models/author/season_statistics.dart';
export 'src/models/author/season.dart';
export 'src/models/author/author.dart';
export 'src/models/author/author_statistics.dart';

/// Book
export 'src/models/book/book.dart';

/// Book File
export 'src/models/book_file/book_file.dart';
export 'src/models/book_file/book_file_quality.dart';
export 'src/models/book_file/book_file_quality_quality.dart';
export 'src/models/book_file/book_file_quality_revision.dart';

/// Edition
export 'src/models/edition/edition.dart';

/// Command
export 'src/models/command/command.dart';
export 'src/models/command/command_body.dart';

/// History
export 'src/models/history/history.dart';
export 'src/models/history/history_record.dart';

/// Import List
export 'src/models/import_list/exclusion.dart';

/// Profile
export 'src/models/profile/metadata_profile.dart';
export 'src/models/profile/quality_profile_cutoff.dart';
export 'src/models/profile/quality_profile_item_quality.dart';
export 'src/models/profile/quality_profile_item.dart';
export 'src/models/profile/quality_profile.dart';

/// Queue
export 'src/models/queue/queue.dart';
export 'src/models/queue/queue_record.dart';
export 'src/models/queue/queue_status_message.dart';

/// Release
export 'src/models/release/release.dart';
export 'src/models/release/added_release.dart';

/// Root Folder
export 'src/models/root_folder/root_folder.dart';
export 'src/models/root_folder/unmapped_folder.dart';

/// System
export 'src/models/system/status.dart';

/// Tags
export 'src/models/tag/tag.dart';

/// Wanted/Missing
export 'src/models/wanted_missing/missing.dart';
