import 'package:lunasea/core/models/configuration/profile.dart';
import 'package:lunasea/database/box.dart';
import 'package:lunasea/database/table.dart';
import 'package:lunasea/database/tables/lunasea.dart';
import 'package:lunasea/system/platform.dart';
import 'package:lunasea/system/profile.dart';
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
    await LunaBox.open();

    if (LunaBox.profiles.isEmpty) await bootstrap();
  }

  Future<void> bootstrap() async {
    await clear();

    const defaultProfile = LunaProfile.DEFAULT_PROFILE;
    LunaBox.profiles.update(defaultProfile, ProfileHiveObject.empty());
    LunaSeaDatabase.ENABLED_PROFILE.update(defaultProfile);
  }

  Future<void> clear() async {
    for (final box in LunaBox.values) await box.clear();
  }

  Future<void> deinitialize() async {
    await Hive.close();
  }
}
