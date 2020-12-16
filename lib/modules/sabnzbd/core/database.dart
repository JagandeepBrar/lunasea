import 'package:lunasea/core.dart';

class SABnzbdDatabase extends LunaModuleDatabase {
    void registerAdapters() {}

    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        for(SABnzbdDatabaseValue value in SABnzbdDatabaseValue.values) {
            switch(value) {
                // Primitive values
                case SABnzbdDatabaseValue.NAVIGATION_INDEX: data[value.key] = value.data; break;
            }
        }
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        for(String key in config.keys) {
            SABnzbdDatabaseValue value = valueFromKey(key);
            if(value != null) switch(value) {
                // Primitive values
                case SABnzbdDatabaseValue.NAVIGATION_INDEX: value.put(config[key]); break;
            }
        }
    }

    @override
    SABnzbdDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'SABNZBD_NAVIGATION_INDEX': return SABnzbdDatabaseValue.NAVIGATION_INDEX;
            default: return null;
        }
    }
}

enum SABnzbdDatabaseValue {
    NAVIGATION_INDEX,
}

extension SABnzbdDatabaseValueExtension on SABnzbdDatabaseValue {
    String get key {
        switch(this) {
            case SABnzbdDatabaseValue.NAVIGATION_INDEX: return 'SABNZBD_NAVIGATION_INDEX';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case SABnzbdDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
        }
        throw Exception('data not found'); 
    }
    
    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case SABnzbdDatabaseValue.NAVIGATION_INDEX: if(value.runtimeType == int) box.put(this.key, value); return;
        }
        LunaLogger.warning('SABnzbdDatabaseValueExtension', 'put', 'Attempted to enter data for invalid SABnzbdDatabaseValue: ${this?.toString() ?? 'null'}');
    }
}
