import 'package:lunasea/database/table.dart';

enum NZBGetDatabase<T> with LunaTableMixin<T> {
  NAVIGATION_INDEX<int>(0);

  @override
  String get table => TABLE_NZBGET_KEY;

  @override
  final T defaultValue;

  const NZBGetDatabase(this.defaultValue);
}
