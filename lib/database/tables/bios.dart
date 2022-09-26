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

  @override
  dynamic export() {
    BIOSDatabase db = this;
    switch (db) {
      case BIOSDatabase.BOOT_MODULE:
        return BIOSDatabase.BOOT_MODULE.read().key;
      default:
        return super.export();
    }
  }

  @override
  void import(dynamic value) {
    BIOSDatabase db = this;
    dynamic result;

    switch (db) {
      case BIOSDatabase.BOOT_MODULE:
        result = LunaModule.fromKey(value.toString());
        break;
      default:
        result = value;
        break;
    }

    return super.import(result);
  }
}
