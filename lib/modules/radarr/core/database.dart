import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrDatabase extends LunaModuleDatabase {
    @override
    void registerAdapters() {
        Hive.registerAdapter(DeprecatedRadarrQualityProfileAdapter());
        Hive.registerAdapter(DeprecatedRadarrRootFolderAdapter());
        Hive.registerAdapter(DeprecatedRadarrAvailabilityAdapter());
    }

    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        for(RadarrDatabaseValue value in RadarrDatabaseValue.values) {
            switch(value) {
                // Primitive values
                case RadarrDatabaseValue.NAVIGATION_INDEX: data[value.key] = value.data; break;
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
            }
        }
    }

    @override
    RadarrDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'RADARR_NAVIGATION_INDEX': return RadarrDatabaseValue.NAVIGATION_INDEX;
            default: return null;
        }
    }
}

enum RadarrDatabaseValue {
    NAVIGATION_INDEX,
}

extension RadarrDatabaseValueExtension on RadarrDatabaseValue {
    String get key {
        switch(this) {
            case RadarrDatabaseValue.NAVIGATION_INDEX: return 'RADARR_NAVIGATION_INDEX';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case RadarrDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case RadarrDatabaseValue.NAVIGATION_INDEX: if(value.runtimeType == int) box.put(this.key, value); return;
        }
        LunaLogger().warning('RadarrDatabaseValueExtension', 'put', 'Attempted to enter data for invalid RadarrDatabaseValue: ${this?.toString() ?? 'null'}');
    }

    void listen(Widget Function(BuildContext, Box<dynamic>, Widget) builder) =>  ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
        builder: builder,
    );
}
