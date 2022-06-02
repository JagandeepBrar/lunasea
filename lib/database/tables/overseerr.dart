import 'package:lunasea/database/table.dart';

enum OverseerrDatabase<T> with LunaTableMixin<T> {
  NAVIGATION_INDEX<int>(0),
  CONTENT_PAGE_SIZE<int>(10);

  @override
  LunaTable get table => LunaTable.overseerr;

  @override
  final T fallback;

  const OverseerrDatabase(this.fallback);
}
