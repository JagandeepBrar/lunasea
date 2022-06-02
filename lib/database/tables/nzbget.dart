import 'package:lunasea/database/table.dart';

enum NZBGetDatabase<T> with LunaTableMixin<T> {
  NAVIGATION_INDEX<int>(0);

  @override
  LunaTable get table => LunaTable.nzbget;

  @override
  final T fallback;

  const NZBGetDatabase(this.fallback);
}
