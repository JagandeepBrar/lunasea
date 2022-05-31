import 'package:lunasea/database/table.dart';

enum OverseerrDatabase<T> with LunaTableMixin<T> {
  NAVIGATION_INDEX<int>(0),
  CONTENT_PAGE_SIZE<int>(10);

  @override
  String get table => TABLE_OVERSEERR_KEY;

  @override
  final T defaultValue;

  const OverseerrDatabase(this.defaultValue);
}
