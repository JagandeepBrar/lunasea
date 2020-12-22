import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class OmbiDatabase extends LunaModuleDatabase {
    @override
    void registerAdapters() {}
    
    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        for(OmbiDatabaseValue value in OmbiDatabaseValue.values) {
            switch(value) {
                // Primitive values
                case OmbiDatabaseValue.NAVIGATION_INDEX: data[value.key] = value.data; break;
            }
        }
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        for(String key in config.keys) {
            OmbiDatabaseValue value = valueFromKey(key);
            if(value != null) switch(value) {
                // Primitive values
                case OmbiDatabaseValue.NAVIGATION_INDEX: value.put(config[key]); break;
            }
        }
    }

    @override
    OmbiDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'OMBI_NAVIGATION_INDEX': return OmbiDatabaseValue.NAVIGATION_INDEX;
            default: return null;
        }
    }
}

enum OmbiDatabaseValue {
    NAVIGATION_INDEX,
}

extension OmbiDatabaseValueExtension on OmbiDatabaseValue {
    String get key {
        switch(this) {
            case OmbiDatabaseValue.NAVIGATION_INDEX: return 'OMBI_NAVIGATION_INDEX';
        }
        throw Exception('key not found');
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case OmbiDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
        }
        throw Exception('data not found');
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case OmbiDatabaseValue.NAVIGATION_INDEX: if(value.runtimeType == int) box.put(this.key, value); return;
        }
        LunaLogger().warning('OmbiDatabaseValueExtension', 'put', 'Attempted to enter data for invalid OmbiDatabaseValue: ${this?.toString() ?? 'null'}');
    }

    void listen(Widget Function(BuildContext, Box<dynamic>, Widget) builder) =>  ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
        builder: builder,
    );
}
