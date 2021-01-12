import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrDatabase extends LunaModuleDatabase {
    @override
    void registerAdapters() {
        Hive.registerAdapter(RadarrQualityProfileAdapter());
        Hive.registerAdapter(RadarrRootFolderAdapter());
        Hive.registerAdapter(RadarrAvailabilityAdapter());
    }

    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        for(RadarrDatabaseValue value in RadarrDatabaseValue.values) {
            switch(value) {
                // Primitive values
                case RadarrDatabaseValue.NAVIGATION_INDEX: data[value.key] = value.data; break;
                // Non-exported values
                case RadarrDatabaseValue.ADD_MONITORED:
                case RadarrDatabaseValue.ADD_QUALITY_PROFILE:
                case RadarrDatabaseValue.ADD_ROOT_FOLDER:
                case RadarrDatabaseValue.ADD_AVAILABILITY: break;
            }
        }
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        for(String key in config.keys) {
            RadarrDatabaseValue value = valueFromKey(key);
            if(value != null) switch(value) {
                // Primitive values
                case RadarrDatabaseValue.NAVIGATION_INDEX: value.put(config[key]); break;
                // Non-imported values
                case RadarrDatabaseValue.ADD_MONITORED:
                case RadarrDatabaseValue.ADD_QUALITY_PROFILE:
                case RadarrDatabaseValue.ADD_AVAILABILITY:
                case RadarrDatabaseValue.ADD_ROOT_FOLDER: break;
            }
        }
    }

    @override
    RadarrDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'RADARR_NAVIGATION_INDEX': return RadarrDatabaseValue.NAVIGATION_INDEX;
            case 'RADARR_ADD_MONITORED': return RadarrDatabaseValue.ADD_MONITORED;
            case 'RADARR_ADD_QUALITY_PROFILE': return RadarrDatabaseValue.ADD_QUALITY_PROFILE;
            case 'RADARR_ADD_ROOT_FOLDER': return RadarrDatabaseValue.ADD_ROOT_FOLDER;
            case 'RADARR_ADD_AVAILABILITY': return RadarrDatabaseValue. ADD_AVAILABILITY;
            default: return null;
        }
    }
}

enum RadarrDatabaseValue {
    NAVIGATION_INDEX,
    ADD_MONITORED,
    ADD_QUALITY_PROFILE,
    ADD_ROOT_FOLDER,
    ADD_AVAILABILITY,
}

extension RadarrDatabaseValueExtension on RadarrDatabaseValue {
    String get key {
        switch(this) {
            case RadarrDatabaseValue.NAVIGATION_INDEX: return 'RADARR_NAVIGATION_INDEX';
            case RadarrDatabaseValue.ADD_MONITORED: return 'RADARR_ADD_MONITORED';
            case RadarrDatabaseValue.ADD_QUALITY_PROFILE: return 'RADARR_ADD_QUALITY_PROFILE';
            case RadarrDatabaseValue.ADD_ROOT_FOLDER: return 'RADARR_ADD_ROOT_FOLDER';
            case RadarrDatabaseValue.ADD_AVAILABILITY: return 'RADARR_ADD_AVAILABILITY';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case RadarrDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
            case RadarrDatabaseValue.ADD_MONITORED: return _box.get(this.key, defaultValue: true);
            case RadarrDatabaseValue.ADD_QUALITY_PROFILE: return _box.get(this.key);
            case RadarrDatabaseValue.ADD_ROOT_FOLDER: return _box.get(this.key);
            case RadarrDatabaseValue.ADD_AVAILABILITY: return _box.get(this.key);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case RadarrDatabaseValue.NAVIGATION_INDEX: if(value.runtimeType == int) box.put(this.key, value); return;
            case RadarrDatabaseValue.ADD_MONITORED: if(value.runtimeType == bool) box.put(this.key, value); return;
            case RadarrDatabaseValue.ADD_QUALITY_PROFILE: if(value.runtimeType == RadarrQualityProfile) box.put(this.key, value); return;
            case RadarrDatabaseValue.ADD_ROOT_FOLDER: if(value.runtimeType == RadarrRootFolder) box.put(this.key, value); return;
            case RadarrDatabaseValue.ADD_AVAILABILITY: if(value.runtimeType == RadarrAvailability) box.put(this.key, value); return;
        }
        LunaLogger().warning('RadarrDatabaseValueExtension', 'put', 'Attempted to enter data for invalid RadarrDatabaseValue: ${this?.toString() ?? 'null'}');
    }

    void listen(Widget Function(BuildContext, Box<dynamic>, Widget) builder) =>  ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
        builder: builder,
    );
}
