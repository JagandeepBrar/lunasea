//import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';

class TautulliDatabase {
    TautulliDatabase._();

    static void registerAdapters() {}
}

enum TautulliDatabaseValue {
    NAVIGATION_INDEX,
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
            case TautulliDatabaseValue.REFRESH_RATE: return _box.get(this.key, defaultValue: 10);
            case TautulliDatabaseValue.CONTENT_LOAD_LENGTH: return _box.get(this.key, defaultValue: 125);
            case TautulliDatabaseValue.STATISTICS_STATS_COUNT: return _box.get(this.key, defaultValue: 3);
            case TautulliDatabaseValue.TERMINATION_MESSAGE: return _box.get(this.key, defaultValue: '');
            case TautulliDatabaseValue.GRAPHS_DAYS: return _box.get(this.key, defaultValue: 30);
            case TautulliDatabaseValue.GRAPHS_LINECHART_DAYS: return _box.get(this.key, defaultValue: 14);
            case TautulliDatabaseValue.GRAPHS_MONTHS: return _box.get(this.key, defaultValue: 6);
        }
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
