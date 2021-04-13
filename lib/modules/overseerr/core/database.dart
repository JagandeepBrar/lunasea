import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class OverseerrDatabase extends LunaModuleDatabase {
    @override
    void registerAdapters() {}

    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        for(OverseerrDatabaseValue value in OverseerrDatabaseValue.values) {
            switch(value) {
                // Primitive values
                case OverseerrDatabaseValue.NAVIGATION_INDEX: data[value.key] = value.data; break;
            }
        }
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        for(String key in config.keys) {
            OverseerrDatabaseValue value = valueFromKey(key);
            if(value != null) switch(value) {
                // Primitive values
                case OverseerrDatabaseValue.NAVIGATION_INDEX: value.put(config[key]); break;
            }
        }
    }
    
    @override
    OverseerrDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'OVERSEERR_NAVIGATION_INDEX': return OverseerrDatabaseValue.NAVIGATION_INDEX;
            default: return null;
        }
    }
}

enum OverseerrDatabaseValue {
    NAVIGATION_INDEX,
}

extension OverseerrDatabaseValueExtension on OverseerrDatabaseValue {
    String get key {
        switch(this) {
            case OverseerrDatabaseValue.NAVIGATION_INDEX: return 'OVERSEERR_NAVIGATION_INDEX';
        }
        throw Exception('Invalid OverseerrDatabaseValue instance'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case OverseerrDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
        }
        throw Exception('Invalid OverseerrDatabaseValue instance'); 
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case OverseerrDatabaseValue.NAVIGATION_INDEX: if(value is int) box.put(this.key, value); return;
        }
        LunaLogger().warning('OverseerrDatabaseValueExtension', 'put', 'Attempted to enter data for invalid OverseerrDatabaseValue: ${this?.toString() ?? 'null'}');
    }

    ValueListenableBuilder listen({ @required Widget Function(BuildContext, dynamic, Widget) builder }) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
        builder: builder,
    );
}
