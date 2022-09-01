import 'package:lunasea/database/table.dart';

enum BIOSDatabase<T> with LunaTableMixin<T> {
  DATABASE_CORRUPTION<bool>(false),
  SENTRY_LOGGING<bool>(true),
  FIRST_BOOT<bool>(true);

  @override
  LunaTable get table => LunaTable.bios;

  @override
  final T fallback;

  const BIOSDatabase(this.fallback);
}
