import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum LunaDatabaseValue {
  DRAWER_AUTOMATIC_MANAGE,
  DRAWER_MANUAL_ORDER,
  ENABLED_PROFILE,
  ENABLE_FIREBASE_ANALYTICS,
  ENABLE_FIREBASE_CRASHLYTICS,
  THEME_AMOLED,
  THEME_AMOLED_BORDER,
  THEME_IMAGE_BACKGROUND_OPACITY,
  SELECTED_BROWSER,
  QUICK_ACTIONS_LIDARR,
  QUICK_ACTIONS_RADARR,
  QUICK_ACTIONS_SONARR,
  QUICK_ACTIONS_NZBGET,
  QUICK_ACTIONS_SABNZBD,
  QUICK_ACTIONS_OMBI,
  QUICK_ACTIONS_OVERSEERR,
  QUICK_ACTIONS_TAUTULLI,
  QUICK_ACTIONS_SEARCH,
  USE_24_HOUR_TIME,
}

class LunaDatabase extends LunaModuleDatabase {
  @override
  void registerAdapters() {
    Hive.registerAdapter(ExternalModuleHiveObjectAdapter());
    Hive.registerAdapter(IndexerHiveObjectAdapter());
    Hive.registerAdapter(ProfileHiveObjectAdapter());
    Hive.registerAdapter(LunaLogHiveObjectAdapter());
    Hive.registerAdapter(LunaBrowserAdapter());
    Hive.registerAdapter(LunaIndexerIconAdapter());
    Hive.registerAdapter(LunaLogTypeAdapter());
    Hive.registerAdapter(LunaModuleAdapter());
  }

  @override
  Map<String, dynamic> export() {
    Map<String, dynamic> data = {};
    for (LunaDatabaseValue value in LunaDatabaseValue.values) {
      switch (value) {
        // Non-primitive values
        case LunaDatabaseValue.SELECTED_BROWSER:
          data[value.key] =
              (LunaDatabaseValue.SELECTED_BROWSER.data as LunaBrowser).key;
          break;
        case LunaDatabaseValue.DRAWER_MANUAL_ORDER:
          data[value.key] = LunaDrawer.moduleOrderedList()
              ?.map<String>((module) => module.key)
              ?.toList();
          break;
        // Primitive values
        default:
          data[value.key] = value.data;
          break;
      }
    }
    return data;
  }

  @override
  void import(Map<String, dynamic> config) {
    for (String key in config.keys) {
      LunaDatabaseValue value = valueFromKey(key);
      if (value != null)
        switch (value) {
          // Non-primitive values
          case LunaDatabaseValue.SELECTED_BROWSER:
            value.put(LunaBrowser.APPLE_SAFARI.fromKey(config[key]));
            break;
          case LunaDatabaseValue.DRAWER_MANUAL_ORDER:
            value.put(
              (config[key] as List)
                  ?.map((item) => LunaModule.DASHBOARD.fromKey(item))
                  ?.toList(),
            );
            break;
          // Primitive values
          default:
            value.put(config[key]);
            break;
        }
    }
  }

  @override
  LunaDatabaseValue valueFromKey(String key) {
    for (LunaDatabaseValue value in LunaDatabaseValue.values) {
      if (value.key == key) return value;
    }
    return null;
  }
}

extension LunaDatabaseValueExtension on LunaDatabaseValue {
  String get key {
    if (this == LunaDatabaseValue.ENABLED_PROFILE) return 'profile';
    return 'LUNASEA_${this.name}';
  }

  dynamic get data {
    return Database.lunaSeaBox.get(this.key, defaultValue: this._defaultValue);
  }

  void put(dynamic value) {
    if (this._isTypeValid(value)) {
      Database.lunaSeaBox.put(this.key, value);
    } else {
      LunaLogger().warning(
        this.runtimeType.toString(),
        'put',
        'Invalid Database Insert (${this.key}, ${value.runtimeType})',
      );
    }
  }

  ValueListenableBuilder listen({
    Key key,
    @required Widget Function(BuildContext, dynamic, Widget) builder,
  }) {
    return ValueListenableBuilder(
      key: key,
      valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
      builder: builder,
    );
  }

  bool _isTypeValid(dynamic value) {
    switch (this) {
      case LunaDatabaseValue.ENABLED_PROFILE:
        return value is String;
      case LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE:
        return value is bool;
      case LunaDatabaseValue.DRAWER_MANUAL_ORDER:
        return value is List;
      case LunaDatabaseValue.ENABLE_FIREBASE_ANALYTICS:
        return value is bool;
      case LunaDatabaseValue.ENABLE_FIREBASE_CRASHLYTICS:
        return value is bool;
      case LunaDatabaseValue.THEME_AMOLED:
        return value is bool;
      case LunaDatabaseValue.THEME_AMOLED_BORDER:
        return value is bool;
      case LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY:
        return value is int;
      case LunaDatabaseValue.SELECTED_BROWSER:
        return value is LunaBrowser;
      case LunaDatabaseValue.QUICK_ACTIONS_LIDARR:
        return value is bool;
      case LunaDatabaseValue.QUICK_ACTIONS_RADARR:
        return value is bool;
      case LunaDatabaseValue.QUICK_ACTIONS_SONARR:
        return value is bool;
      case LunaDatabaseValue.QUICK_ACTIONS_NZBGET:
        return value is bool;
      case LunaDatabaseValue.QUICK_ACTIONS_SABNZBD:
        return value is bool;
      case LunaDatabaseValue.QUICK_ACTIONS_OMBI:
        return value is bool;
      case LunaDatabaseValue.QUICK_ACTIONS_OVERSEERR:
        return value is bool;
      case LunaDatabaseValue.QUICK_ACTIONS_TAUTULLI:
        return value is bool;
      case LunaDatabaseValue.QUICK_ACTIONS_SEARCH:
        return value is bool;
      case LunaDatabaseValue.USE_24_HOUR_TIME:
        return value is bool;
    }
    throw Exception('Invalid LunaDatabaseValue');
  }

  dynamic get _defaultValue {
    switch (this) {
      case LunaDatabaseValue.ENABLED_PROFILE:
        return 'default';
      case LunaDatabaseValue.DRAWER_AUTOMATIC_MANAGE:
        return true;
      case LunaDatabaseValue.DRAWER_MANUAL_ORDER:
        return null;
      case LunaDatabaseValue.SELECTED_BROWSER:
        return LunaBrowser.APPLE_SAFARI;
      case LunaDatabaseValue.THEME_AMOLED:
        return false;
      case LunaDatabaseValue.THEME_AMOLED_BORDER:
        return false;
      case LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY:
        return 10;
      case LunaDatabaseValue.ENABLE_FIREBASE_ANALYTICS:
        return true;
      case LunaDatabaseValue.ENABLE_FIREBASE_CRASHLYTICS:
        return true;
      case LunaDatabaseValue.QUICK_ACTIONS_LIDARR:
        return false;
      case LunaDatabaseValue.QUICK_ACTIONS_RADARR:
        return false;
      case LunaDatabaseValue.QUICK_ACTIONS_SONARR:
        return false;
      case LunaDatabaseValue.QUICK_ACTIONS_NZBGET:
        return false;
      case LunaDatabaseValue.QUICK_ACTIONS_SABNZBD:
        return false;
      case LunaDatabaseValue.QUICK_ACTIONS_OVERSEERR:
        return false;
      case LunaDatabaseValue.QUICK_ACTIONS_TAUTULLI:
        return false;
      case LunaDatabaseValue.QUICK_ACTIONS_OMBI:
        return false;
      case LunaDatabaseValue.QUICK_ACTIONS_SEARCH:
        return false;
      case LunaDatabaseValue.USE_24_HOUR_TIME:
        return false;
    }
    throw Exception('Invalid LunaDatabaseValue');
  }
}
