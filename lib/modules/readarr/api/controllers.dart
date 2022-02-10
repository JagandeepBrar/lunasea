/// Library containing all logic and accessors to make calls to Readarr's API.
library readarr_commands;

import './types.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'models.dart';

// Author
part 'src/controllers/author.dart';
part 'src/controllers/author/add_author.dart';
part 'src/controllers/author/delete_author.dart';
part 'src/controllers/author/get_all_authors.dart';
part 'src/controllers/author/get_author.dart';
part 'src/controllers/author/update_author.dart';

// Author Lookup
part 'src/controllers/author_lookup.dart';
part 'src/controllers/author_lookup/lookup.dart';

// Book
part 'src/controllers/book.dart';
part 'src/controllers/book/get_all_books.dart';
part 'src/controllers/book/set_monitored.dart';
part 'src/controllers/book/update_book.dart';
part 'src/controllers/book/delete_book.dart';

// Book File
part 'src/controllers/book_file.dart';
part 'src/controllers/book_file/delete_book_file.dart';
part 'src/controllers/book_file/get_book_file.dart';
part 'src/controllers/book_file/get_author_book_files.dart';

// Calendar
part 'src/controllers/calendar.dart';
part 'src/controllers/calendar/get_calendar.dart';

// Command
part 'src/controllers/command.dart';
part 'src/controllers/command/author_search.dart';
part 'src/controllers/command/backup.dart';
part 'src/controllers/command/book_search.dart';
part 'src/controllers/command/missing_episode_search.dart';
part 'src/controllers/command/queue.dart';
part 'src/controllers/command/refresh_monitored_downloads.dart';
part 'src/controllers/command/refresh_author.dart';
part 'src/controllers/command/refresh_book.dart';
part 'src/controllers/command/rescan_author.dart';
part 'src/controllers/command/rss_sync.dart';
part 'src/controllers/command/season_search.dart';

// History
part 'src/controllers/history.dart';
part 'src/controllers/history/get_history.dart';
part 'src/controllers/history/get_history_by_author.dart';

// Import List
part 'src/controllers/import_list.dart';
part 'src/controllers/import_list/get_exclusion_list.dart';

// Profile
part 'src/controllers/profile.dart';
part 'src/controllers/profile/get_metadata_profiles.dart';
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
