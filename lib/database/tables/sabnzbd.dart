import 'package:lunasea/database/table.dart';

enum SABnzbdDatabase<T> with LunaTableMixin<T> {
  NAVIGATION_INDEX<int>(0);

  @override
  LunaTable get table => LunaTable.sabnzbd;

  @override
  final T fallback;

  const SABnzbdDatabase(this.fallback);
}
