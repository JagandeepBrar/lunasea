import 'package:lunasea/core.dart';

class TautulliDatabase extends LunaModuleDatabase {
    void registerAdapters() {}

    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        for(TautulliDatabaseValue value in TautulliDatabaseValue.values) {
            switch(value) {
                // Primitive values
                case TautulliDatabaseValue.NAVIGATION_INDEX: 
                case TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS: 
                case TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS: 
                case TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS: 
                case TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS: 
                case TautulliDatabaseValue.REFRESH_RATE: 
                case TautulliDatabaseValue.CONTENT_LOAD_LENGTH: 
                case TautulliDatabaseValue.STATISTICS_STATS_COUNT: 
                case TautulliDatabaseValue.TERMINATION_MESSAGE: 
                case TautulliDatabaseValue.GRAPHS_DAYS: 
                case TautulliDatabaseValue.GRAPHS_LINECHART_DAYS: 
                case TautulliDatabaseValue.GRAPHS_MONTHS: data[value.key] = value.data; break;
            }
        }
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        for(String key in config.keys) {
            TautulliDatabaseValue value = valueFromKey(key);
            if(value != null) switch(value) {
                // Primitive values
                case TautulliDatabaseValue.NAVIGATION_INDEX:
                case TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS:
                case TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS:
                case TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS:
                case TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS:
                case TautulliDatabaseValue.REFRESH_RATE:
                case TautulliDatabaseValue.CONTENT_LOAD_LENGTH:
                case TautulliDatabaseValue.STATISTICS_STATS_COUNT:
                case TautulliDatabaseValue.TERMINATION_MESSAGE:
                case TautulliDatabaseValue.GRAPHS_DAYS:
                case TautulliDatabaseValue.GRAPHS_LINECHART_DAYS:
                case TautulliDatabaseValue.GRAPHS_MONTHS: value.put(config[key]); break;
            }
        }
    }

    @override
    TautulliDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'TAUTULLI_NAVIGATION_INDEX': return TautulliDatabaseValue.NAVIGATION_INDEX;
            case 'TAUTULLI_NAVIGATION_INDEX_GRAPHS': return TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS;
            case 'TAUTULLI_NAVIGATION_INDEX_LIBRARIES_DETAILS': return TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS;
            case 'TAUTULLI_NAVIGATION_INDEX_MEDIA_DETAILS': return TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS;
            case 'TAUTULLI_NAVIGATION_INDEX_USER_DETAILS': return TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS;
            case 'TAUTULLI_REFRESH_RATE': return TautulliDatabaseValue.REFRESH_RATE;
            case 'TAUTULLI_CONTENT_LOAD_LENGTH': return TautulliDatabaseValue.CONTENT_LOAD_LENGTH;
            case 'TAUTULLI_STATISTICS_STATS_COUNT': return TautulliDatabaseValue.STATISTICS_STATS_COUNT;
            case 'TAUTULLI_TERMINATION_MESSAGE': return TautulliDatabaseValue.TERMINATION_MESSAGE;
            case 'TAUTULLI_GRAPHS_DAYS': return TautulliDatabaseValue.GRAPHS_DAYS;
            case 'TAUTULLI_GRAPHS_LINECHART_DAYS': return TautulliDatabaseValue.GRAPHS_LINECHART_DAYS;
            case 'TAUTULLI_GRAPHS_MONTHS': return TautulliDatabaseValue.GRAPHS_MONTHS;
            default: return null;
        }
    }
}

enum TautulliDatabaseValue {
    NAVIGATION_INDEX,
    NAVIGATION_INDEX_GRAPHS,
    NAVIGATION_INDEX_LIBRARIES_DETAILS,
    NAVIGATION_INDEX_MEDIA_DETAILS,
    NAVIGATION_INDEX_USER_DETAILS,
    REFRESH_RATE,
    CONTENT_LOAD_LENGTH,
    STATISTICS_STATS_COUNT,
    TERMINATION_MESSAGE,
    GRAPHS_DAYS,
    GRAPHS_LINECHART_DAYS,
    GRAPHS_MONTHS,
}

extension TautulliDatabaseValueExtension on TautulliDatabaseValue {
    String get key {
        switch(this) {
            case TautulliDatabaseValue.NAVIGATION_INDEX: return 'TAUTULLI_NAVIGATION_INDEX';
            case TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS: return 'TAUTULLI_NAVIGATION_INDEX_GRAPHS';
            case TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS: return 'TAUTULLI_NAVIGATION_INDEX_LIBRARIES_DETAILS';
            case TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS: return 'TAUTULLI_NAVIGATION_INDEX_MEDIA_DETAILS';
            case TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS: return 'TAUTULLI_NAVIGATION_INDEX_USER_DETAILS'; 
            case TautulliDatabaseValue.REFRESH_RATE: return 'TAUTULLI_REFRESH_RATE';
            case TautulliDatabaseValue.CONTENT_LOAD_LENGTH: return 'TAUTULLI_CONTENT_LOAD_LENGTH';
            case TautulliDatabaseValue.STATISTICS_STATS_COUNT: return 'TAUTULLI_STATISTICS_STATS_COUNT';
            case TautulliDatabaseValue.TERMINATION_MESSAGE: return 'TAUTULLI_TERMINATION_MESSAGE';
            case TautulliDatabaseValue.GRAPHS_DAYS: return 'TAUTULLI_GRAPHS_DAYS';
            case TautulliDatabaseValue.GRAPHS_LINECHART_DAYS: return 'TAUTULLI_GRAPHS_LINECHART_DAYS';
            case TautulliDatabaseValue.GRAPHS_MONTHS: return 'TAUTULLI_GRAPHS_MONTHS';
        }
        throw Exception('key not found');
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case TautulliDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
            case TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS: return _box.get(this.key, defaultValue: 0);
            case TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS: return _box.get(this.key, defaultValue: 0);
            case TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS: return _box.get(this.key, defaultValue: 0);
            case TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS: return _box.get(this.key, defaultValue: 0);
            case TautulliDatabaseValue.REFRESH_RATE: return _box.get(this.key, defaultValue: 10);
            case TautulliDatabaseValue.CONTENT_LOAD_LENGTH: return _box.get(this.key, defaultValue: 125);
            case TautulliDatabaseValue.STATISTICS_STATS_COUNT: return _box.get(this.key, defaultValue: 3);
            case TautulliDatabaseValue.TERMINATION_MESSAGE: return _box.get(this.key, defaultValue: '');
            case TautulliDatabaseValue.GRAPHS_DAYS: return _box.get(this.key, defaultValue: 30);
            case TautulliDatabaseValue.GRAPHS_LINECHART_DAYS: return _box.get(this.key, defaultValue: 14);
            case TautulliDatabaseValue.GRAPHS_MONTHS: return _box.get(this.key, defaultValue: 6);
        }
        throw Exception('data not found');
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case TautulliDatabaseValue.NAVIGATION_INDEX: if(value.runtimeType == int) box.put(this.key, value); return;
            case TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS: if(value.runtimeType == int) box.put(this.key, value); return;
            case TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS: if(value.runtimeType == int) box.put(this.key, value); return;
            case TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS: if(value.runtimeType == int) box.put(this.key, value); return;
            case TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS: if(value.runtimeType == int) box.put(this.key, value); return;
            case TautulliDatabaseValue.REFRESH_RATE: if(value.runtimeType == int) box.put(this.key, value); return;
            case TautulliDatabaseValue.CONTENT_LOAD_LENGTH: if(value.runtimeType == int) box.put(this.key, value); return;
            case TautulliDatabaseValue.STATISTICS_STATS_COUNT: if(value.runtimeType == int) box.put(this.key, value); return;
            case TautulliDatabaseValue.TERMINATION_MESSAGE: if(value.runtimeType == String) box.put(this.key, value); return;
            case TautulliDatabaseValue.GRAPHS_DAYS: if(value.runtimeType == int) box.put(this.key, value); return;
            case TautulliDatabaseValue.GRAPHS_LINECHART_DAYS: if(value.runtimeType == int) box.put(this.key, value); return;
            case TautulliDatabaseValue.GRAPHS_MONTHS: if(value.runtimeType == int) box.put(this.key, value); return;
        }
        LunaLogger().warning('TautulliDatabaseValueExtension', 'put', 'Attempted to enter data for invalid TautulliDatabaseValue: ${this?.toString() ?? 'null'}');
    }
}
