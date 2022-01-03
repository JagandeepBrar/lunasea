// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart' hide LidarrDatabaseValueExtension;

enum LidarrDatabaseValue {
  NAVIGATION_INDEX,
  @Deprecated("Replaced by ADD_MONITORED_STATUS")
  ADD_MONITORED,
  ADD_MONITORED_STATUS,
  ADD_ARTIST_SEARCH_FOR_MISSING,
  ADD_ALBUM_FOLDERS,
  ADD_QUALITY_PROFILE,
  ADD_METADATA_PROFILE,
  ADD_ROOT_FOLDER,
}

class LidarrDatabase extends LunaModuleDatabase {
  @override
  void registerAdapters() {
    Hive.registerAdapter(LidarrQualityProfileAdapter());
    Hive.registerAdapter(LidarrMetadataProfileAdapter());
    Hive.registerAdapter(LidarrRootFolderAdapter());
  }

  @override
  Map<String, dynamic> export() {
    Map<String, dynamic> data = {};
    for (LidarrDatabaseValue value in LidarrDatabaseValue.values) {
      switch (value) {
        // Non-exported values
        case LidarrDatabaseValue.ADD_ALBUM_FOLDERS:
        case LidarrDatabaseValue.ADD_QUALITY_PROFILE:
        case LidarrDatabaseValue.ADD_METADATA_PROFILE:
        case LidarrDatabaseValue.ADD_ROOT_FOLDER:
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
  void import(Map<String, dynamic>? config) {
    for (String key in config!.keys) {
      LidarrDatabaseValue? value = valueFromKey(key);
      if (value != null)
        switch (value) {
          // Non-imported values
          case LidarrDatabaseValue.ADD_ALBUM_FOLDERS:
          case LidarrDatabaseValue.ADD_QUALITY_PROFILE:
          case LidarrDatabaseValue.ADD_METADATA_PROFILE:
          case LidarrDatabaseValue.ADD_ROOT_FOLDER:
            break;
          // Primitive values
          default:
            value.put(config[key]);
            break;
        }
    }
  }

  @override
  LidarrDatabaseValue? valueFromKey(String key) {
    for (LidarrDatabaseValue value in LidarrDatabaseValue.values) {
      if (value.key == key) return value;
    }
    return null;
  }
}

extension LidarrDatabaseValueExtension on LidarrDatabaseValue {
  String get key {
    return 'LIDARR_${this.name}';
  }

  dynamic get data {
    return Database.lunasea.box.get(this.key, defaultValue: this._defaultValue);
  }

  void put(dynamic value) {
    if (this._isTypeValid(value)) {
      Database.lunasea.box.put(this.key, value);
    } else {
      LunaLogger().warning(
        this.runtimeType.toString(),
        'put',
        'Invalid Database Insert (${this.key}, ${value.runtimeType})',
      );
    }
  }

  ValueListenableBuilder listen({
    Key? key,
    required Widget Function(BuildContext, dynamic, Widget?) builder,
  }) {
    return ValueListenableBuilder(
      key: key,
      valueListenable: Database.lunasea.box.listenable(keys: [this.key]),
      builder: builder,
    );
  }

  bool _isTypeValid(dynamic value) {
    switch (this) {
      case LidarrDatabaseValue.NAVIGATION_INDEX:
        return value is int;
      case LidarrDatabaseValue.ADD_MONITORED:
        return value is bool;
      case LidarrDatabaseValue.ADD_ALBUM_FOLDERS:
        return value is bool;
      case LidarrDatabaseValue.ADD_QUALITY_PROFILE:
        return value is LidarrQualityProfile;
      case LidarrDatabaseValue.ADD_METADATA_PROFILE:
        return value is LidarrMetadataProfile;
      case LidarrDatabaseValue.ADD_ROOT_FOLDER:
        return value is LidarrRootFolder;
      case LidarrDatabaseValue.ADD_MONITORED_STATUS:
        return value is String;
      case LidarrDatabaseValue.ADD_ARTIST_SEARCH_FOR_MISSING:
        return value is bool;
    }
  }

  dynamic get _defaultValue {
    switch (this) {
      case LidarrDatabaseValue.NAVIGATION_INDEX:
        return 0;
      case LidarrDatabaseValue.ADD_MONITORED:
        return true;
      case LidarrDatabaseValue.ADD_ALBUM_FOLDERS:
        return true;
      case LidarrDatabaseValue.ADD_QUALITY_PROFILE:
        return null;
      case LidarrDatabaseValue.ADD_METADATA_PROFILE:
        return null;
      case LidarrDatabaseValue.ADD_ROOT_FOLDER:
        return null;
      case LidarrDatabaseValue.ADD_MONITORED_STATUS:
        return LidarrMonitorStatus.ALL.key;
      case LidarrDatabaseValue.ADD_ARTIST_SEARCH_FOR_MISSING:
        return false;
    }
  }
}
