import 'package:lunasea/database/table.dart';

enum TautulliDatabase<T> with LunaTableMixin<T> {
  NAVIGATION_INDEX<int>(0),
  NAVIGATION_INDEX_GRAPHS<int>(0),
  NAVIGATION_INDEX_LIBRARIES_DETAILS<int>(0),
  NAVIGATION_INDEX_MEDIA_DETAILS<int>(0),
  NAVIGATION_INDEX_USER_DETAILS<int>(0),
  REFRESH_RATE<int>(10),
  CONTENT_LOAD_LENGTH<int>(125),
  STATISTICS_STATS_COUNT<int>(3),
  TERMINATION_MESSAGE<String>(''),
  GRAPHS_DAYS<int>(30),
  GRAPHS_LINECHART_DAYS<int>(14),
  GRAPHS_MONTHS<int>(6);

  @override
  LunaTable get table => LunaTable.tautulli;

  @override
  final T fallback;

  const TautulliDatabase(this.fallback);
}
