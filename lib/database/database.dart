import 'package:lunasea/database/box.dart';
import 'package:lunasea/database/models/profile.dart';
import 'package:lunasea/database/table.dart';
import 'package:lunasea/database/tables/bios.dart';
import 'package:lunasea/database/tables/lunasea.dart';
import 'package:lunasea/system/platform.dart';
import 'package:lunasea/vendor.dart';

class LunaDatabase {
  static const String _DATABASE_LEGACY_PATH = 'database';
  static const String _DATABASE_PATH = 'LunaSea/database';

  String get _path {
    if (LunaPlatform.isWindows || LunaPlatform.isLinux) return _DATABASE_PATH;
    return _DATABASE_LEGACY_PATH;
  }

  Future<void> initialize() async {
    await Hive.initFlutter(_path);
    LunaTable.register();
    await open();
  }

  Future<void> open() async {
    try {
      await LunaBox.open();
      if (LunaBox.profiles.isEmpty) await bootstrap();
    } catch (error) {
      for (final box in LunaBox.values) {
        await Hive.deleteBoxFromDisk(box.key);
      }

      await LunaBox.open();
      await bootstrap(databaseCorruption: true);
    }
  }

  Future<void> bootstrap({
    bool databaseCorruption = false,
  }) async {
    const defaultProfile = LunaProfile.DEFAULT_PROFILE;
    await clear();

    LunaBox.profiles.update(defaultProfile, LunaProfile());
    LunaSeaDatabase.ENABLED_PROFILE.update(defaultProfile);
    BIOSDatabase.DATABASE_CORRUPTION.update(databaseCorruption);
  }

  Future<void> clear() async {
    for (final box in LunaBox.values) await box.clear();
  }

  Future<void> deinitialize() async {
    await Hive.close();
  }
}
