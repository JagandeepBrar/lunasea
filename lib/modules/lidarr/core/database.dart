import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart' hide LidarrDatabaseValueExtension;

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
        for(LidarrDatabaseValue value in LidarrDatabaseValue.values) {
            switch(value) {
                // Primitive values
                case LidarrDatabaseValue.NAVIGATION_INDEX: data[value.key] = value.data; break;
                // Non-exported values
                case LidarrDatabaseValue.ADD_MONITORED: 
                case LidarrDatabaseValue.ADD_ALBUM_FOLDERS: 
                case LidarrDatabaseValue.ADD_QUALITY_PROFILE: 
                case LidarrDatabaseValue.ADD_METADATA_PROFILE: 
                case LidarrDatabaseValue.ADD_ROOT_FOLDER: break;
            }
        }
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        for(String key in config.keys) {
            LidarrDatabaseValue value = valueFromKey(key);
            if(value != null) switch(value) {
                // Primitive values
                case LidarrDatabaseValue.NAVIGATION_INDEX: value.put(config[key]); break;
                // Non-imported values
                case LidarrDatabaseValue.ADD_MONITORED:
                case LidarrDatabaseValue.ADD_ALBUM_FOLDERS:
                case LidarrDatabaseValue.ADD_QUALITY_PROFILE:
                case LidarrDatabaseValue.ADD_METADATA_PROFILE:
                case LidarrDatabaseValue.ADD_ROOT_FOLDER: break;
            }
        }
    }

    @override
    LidarrDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'LIDARR_NAVIGATION_INDEX': return LidarrDatabaseValue.NAVIGATION_INDEX;
            case 'LIDARR_ADD_MONITORED': return LidarrDatabaseValue.ADD_MONITORED;
            case 'LIDARR_ADD_ALBUM_FOLDERS': return LidarrDatabaseValue.ADD_ALBUM_FOLDERS;
            case 'LIDARR_ADD_QUALITY_PROFILE': return LidarrDatabaseValue.ADD_QUALITY_PROFILE;
            case 'LIDARR_ADD_METADATA_PROFILE': return LidarrDatabaseValue.ADD_METADATA_PROFILE; 
            case 'LIDARR_ADD_ROOT_FOLDER': return LidarrDatabaseValue.ADD_ROOT_FOLDER;
            default: return null;
        }
    }
}

enum LidarrDatabaseValue {
    NAVIGATION_INDEX,
    ADD_MONITORED,
    ADD_ALBUM_FOLDERS,
    ADD_QUALITY_PROFILE,
    ADD_METADATA_PROFILE,
    ADD_ROOT_FOLDER,
}

extension LidarrDatabaseValueExtension on LidarrDatabaseValue {
    String get key {
        switch(this) {
            case LidarrDatabaseValue.NAVIGATION_INDEX: return 'LIDARR_NAVIGATION_INDEX';
            case LidarrDatabaseValue.ADD_MONITORED: return 'LIDARR_ADD_MONITORED';
            case LidarrDatabaseValue.ADD_ALBUM_FOLDERS: return 'LIDARR_ADD_ALBUM_FOLDERS';
            case LidarrDatabaseValue.ADD_QUALITY_PROFILE: return 'LIDARR_ADD_QUALITY_PROFILE';
            case LidarrDatabaseValue.ADD_METADATA_PROFILE: return 'LIDARR_ADD_METADATA_PROFILE';
            case LidarrDatabaseValue.ADD_ROOT_FOLDER: return 'LIDARR_ADD_ROOT_FOLDER';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case LidarrDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
            case LidarrDatabaseValue.ADD_MONITORED: return _box.get(this.key, defaultValue: true);
            case LidarrDatabaseValue.ADD_ALBUM_FOLDERS: return _box.get(this.key, defaultValue: true);
            case LidarrDatabaseValue.ADD_QUALITY_PROFILE: return _box.get(this.key);
            case LidarrDatabaseValue.ADD_METADATA_PROFILE: return _box.get(this.key);
            case LidarrDatabaseValue.ADD_ROOT_FOLDER: return _box.get(this.key);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case LidarrDatabaseValue.NAVIGATION_INDEX: if(value.runtimeType == int) box.put(this.key, value); return;
            case LidarrDatabaseValue.ADD_MONITORED: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LidarrDatabaseValue.ADD_ALBUM_FOLDERS: if(value.runtimeType == bool) box.put(this.key, value); return;
            case LidarrDatabaseValue.ADD_QUALITY_PROFILE: if(value.runtimeType == LidarrQualityProfile) box.put(this.key, value); return;
            case LidarrDatabaseValue.ADD_METADATA_PROFILE: if(value.runtimeType == LidarrMetadataProfile) box.put(this.key, value); return;
            case LidarrDatabaseValue.ADD_ROOT_FOLDER: if(value.runtimeType == LidarrRootFolder) box.put(this.key, value); return;
        }
        LunaLogger().warning('LidarrDatabaseValueExtension', 'put', 'Attempted to enter data for invalid LidarrDatabaseValue: ${this?.toString() ?? 'null'}');
    }

    ValueListenableBuilder listen({ @required Widget Function(BuildContext, dynamic, Widget) builder }) =>  ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
        builder: builder,
    );
}
