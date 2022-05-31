import 'package:lunasea/database/table.dart';

enum SABnzbdDatabase<T> with LunaTableMixin<T> {
  NAVIGATION_INDEX<int>(0);

  @override
  String get table => TABLE_SABNZBD_KEY;

  @override
  final T defaultValue;

  const SABnzbdDatabase(this.defaultValue);
}
