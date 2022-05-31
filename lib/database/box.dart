import 'package:lunasea/core/models/configuration/external_module.dart';
import 'package:lunasea/core/models/configuration/indexer.dart';
import 'package:lunasea/core/models/configuration/profile.dart';
import 'package:lunasea/core/models/logs/log.dart';
import 'package:lunasea/system/logger.dart';
import 'package:lunasea/vendor.dart';

const BOX_ALERTS_KEY = 'alerts';
const BOX_EXTERNAL_MODULES_KEY = 'external_modules';
const BOX_INDEXERS_KEY = 'indexers';
const BOX_LOGS_KEY = 'logs';
const BOX_LUNASEA_KEY = 'lunasea';
const BOX_PROFILES_KEY = 'profiles';

enum LunaBox<T> {
  alerts<dynamic>(BOX_ALERTS_KEY),
  externalModules<ExternalModuleHiveObject>(BOX_EXTERNAL_MODULES_KEY),
  indexers<IndexerHiveObject>(BOX_INDEXERS_KEY),
  logs<LunaLogHiveObject>(BOX_LOGS_KEY),
  lunasea<dynamic>(BOX_LUNASEA_KEY),
  profiles<ProfileHiveObject>(BOX_PROFILES_KEY);

  final String key;
  const LunaBox(this.key);

  Box<T> get box => Hive.box<T>(key);
  Future<void> clear() async => box.keys.forEach((k) => box.delete(k));
  Future<int> size() async => box.length;
  Future<void> open() async => await Hive.openBox<T>(key);
}

extension LunaBoxExtension on LunaBox {
  List<Map<String, dynamic>> export() {
    try {
      return box.keys
          .map<Map<String, dynamic>>((k) => box.get(k)!.toMap())
          .toList();
    } catch (error, stack) {
      LunaLogger().error('Failed to export LunaBox', error, stack);
      return [];
    }
  }
}
