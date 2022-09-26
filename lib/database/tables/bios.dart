import 'package:lunasea/database/table.dart';
import 'package:lunasea/modules.dart';

enum BIOSDatabase<T> with LunaTableMixin<T> {
  BOOT_MODULE<LunaModule>(LunaModule.DASHBOARD),
  SENTRY_LOGGING<bool>(true),
  FIRST_BOOT<bool>(true);

  @override
  LunaTable get table => LunaTable.bios;

  @override
  final T fallback;

  const BIOSDatabase(this.fallback);
}
