import 'package:lunasea/database/table.dart';

enum RssDatabase<T> with LunaTableMixin<T> {
  REFRESH_RATE<int>(300);

  @override
  LunaTable get table => LunaTable.rss;

  @override
  final T fallback;

  const RssDatabase(this.fallback);
}
