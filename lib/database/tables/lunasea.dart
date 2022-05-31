import 'package:lunasea/core/models/configuration/external_module.dart';
import 'package:lunasea/core/models/configuration/indexer.dart';
import 'package:lunasea/core/models/configuration/profile.dart';
import 'package:lunasea/core/models/logs/log.dart';
import 'package:lunasea/core/models/logs/log_type.dart';
import 'package:lunasea/core/models/types/browser.dart';
import 'package:lunasea/core/models/types/indexer_icon.dart';
import 'package:lunasea/core/models/types/list_view_option.dart';
import 'package:lunasea/core/modules.dart';
import 'package:lunasea/database/table.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/ui.dart';

enum LunaSeaDatabase<T> with LunaTableMixin<T> {
  DRAWER_AUTOMATIC_MANAGE<bool>(true),
  DRAWER_MANUAL_ORDER<List<LunaModule>?>(null),
  ENABLED_PROFILE<String>('default'),
  NETWORKING_TLS_VALIDATION<bool>(false),
  THEME_AMOLED<bool>(false),
  THEME_AMOLED_BORDER<bool>(false),
  THEME_IMAGE_BACKGROUND_OPACITY<int>(20),
  QUICK_ACTIONS_LIDARR<bool>(false),
  QUICK_ACTIONS_RADARR<bool>(false),
  QUICK_ACTIONS_SONARR<bool>(false),
  QUICK_ACTIONS_NZBGET<bool>(false),
  QUICK_ACTIONS_SABNZBD<bool>(false),
  QUICK_ACTIONS_OVERSEERR<bool>(false),
  QUICK_ACTIONS_TAUTULLI<bool>(false),
  QUICK_ACTIONS_SEARCH<bool>(false),
  USE_24_HOUR_TIME<bool>(false),
  DEFAULT_LAUNCH_MODULE<LunaModule>(LunaModule.DASHBOARD),
  ENABLE_IN_APP_NOTIFICATIONS<bool>(true),
  CHANGELOG_LAST_BUILD<String>('0.0.0');

  @override
  String get table => TABLE_LUNASEA_KEY;

  @override
  final T defaultValue;

  const LunaSeaDatabase(this.defaultValue);

  @override
  void registerAdapters() {
    // Deprecated
    Hive.registerAdapter(DeprecatedLunaBrowserAdapter());
    // Active
    Hive.registerAdapter(ExternalModuleHiveObjectAdapter());
    Hive.registerAdapter(IndexerHiveObjectAdapter());
    Hive.registerAdapter(ProfileHiveObjectAdapter());
    Hive.registerAdapter(LunaLogHiveObjectAdapter());
    Hive.registerAdapter(LunaIndexerIconAdapter());
    Hive.registerAdapter(LunaLogTypeAdapter());
    Hive.registerAdapter(LunaModuleAdapter());
    Hive.registerAdapter(LunaListViewOptionAdapter());
  }

  @override
  dynamic export() {
    if (this == LunaSeaDatabase.DEFAULT_LAUNCH_MODULE) {
      return LunaSeaDatabase.DEFAULT_LAUNCH_MODULE.read().key;
    }
    if (this == LunaSeaDatabase.DRAWER_MANUAL_ORDER) {
      return LunaDrawer.moduleOrderedList()
          .map<String>((module) => module.key)
          .toList();
    }
    return super.export();
  }

  @override
  void import(dynamic value) {
    if (this == LunaSeaDatabase.DEFAULT_LAUNCH_MODULE) {
      final item = LunaModule.DASHBOARD.fromKey(value.toString());
      if (item != null) update(item as T);
      return;
    }
    if (this == LunaSeaDatabase.DRAWER_MANUAL_ORDER) {
      final item = (value as List)
          .map((module) => LunaModule.DASHBOARD.fromKey(module))
          .toList();
      item.removeWhere((i) => i == null);
      update(item.cast<LunaModule>() as T);
      return;
    }
    return super.import(value);
  }
}
