import 'package:lunasea/core.dart';

class NZBGetDatabase extends LunaModuleDatabase {
    void registerAdapters() {}

    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        for(NZBGetDatabaseValue value in NZBGetDatabaseValue.values) {
            switch(value) {
                // Primitive values
                case NZBGetDatabaseValue.NAVIGATION_INDEX: data[value.key] = value.data; break;
            }
        }
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        for(String key in config.keys) {
            NZBGetDatabaseValue value = valueFromKey(key);
            if(value != null) switch(value) {
                // Primitive values
                case NZBGetDatabaseValue.NAVIGATION_INDEX: value.put(config[key]); break;
            }
        }
    }

    @override
    NZBGetDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'NZBGET_NAVIGATION_INDEX': return NZBGetDatabaseValue.NAVIGATION_INDEX;
            default: return null;
        }
    }
}

enum NZBGetDatabaseValue {
    NAVIGATION_INDEX,
}

extension NZBGetDatabaseValueExtension on NZBGetDatabaseValue {
    String get key {
        switch(this) {
            case NZBGetDatabaseValue.NAVIGATION_INDEX: return 'NZBGET_NAVIGATION_INDEX';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case NZBGetDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case NZBGetDatabaseValue.NAVIGATION_INDEX: if(value.runtimeType == int) box.put(this.key, value); return;
        }
        LunaLogger().warning('NZBGetDatabaseValueExtension', 'put', 'Attempted to enter data for invalid NZBGetDatabaseValue: ${this?.toString() ?? 'null'}');
    }
}
