import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsDatabase extends LunaModuleDatabase {
    @override
    void registerAdapters() {}

    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        for(SettingsDatabaseValue value in SettingsDatabaseValue.values) {
            switch(value) {
                // Primitive values
                case SettingsDatabaseValue.NAVIGATION_INDEX: data[value.key] = value.data; break;
            }
        }
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        for(String key in config.keys) {
            SettingsDatabaseValue value = valueFromKey(key);
            if(value != null) switch(value) {
                // Primitive values
                case SettingsDatabaseValue.NAVIGATION_INDEX: value.put(config[key]); break;
            }
        }
    }

    @override
    SettingsDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'SETTINGS_NAVIGATION_INDEX': return SettingsDatabaseValue.NAVIGATION_INDEX;
            default: return null;
        }
    }
}

enum SettingsDatabaseValue {
    NAVIGATION_INDEX,
}

extension SettingsDatabaseValueExtension on SettingsDatabaseValue {
    String get key {
        switch(this) {
            case SettingsDatabaseValue.NAVIGATION_INDEX: return 'SETTINGS_NAVIGATION_INDEX';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case SettingsDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case SettingsDatabaseValue.NAVIGATION_INDEX: if(value.runtimeType == int) box.put(this.key, value); return;
        }
        LunaLogger().warning('SettingsDatabaseValueExtension', 'put', 'Attempted to enter data for invalid SettingsDatabaseValue: ${this?.toString() ?? 'null'}');
    }

    void listen(Widget Function(BuildContext, Box<dynamic>, Widget) builder) =>  ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
        builder: builder,
    );
}
