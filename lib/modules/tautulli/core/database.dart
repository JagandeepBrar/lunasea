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
}

extension TautulliDatabaseValueExtension on TautulliDatabaseValue {
    String get key {
        switch(this) {
            case TautulliDatabaseValue.NAVIGATION_INDEX: return 'TAUTULLI_NAVIGATION_INDEX';
            case TautulliDatabaseValue.REFRESH_RATE: return 'TAUTULLI_REFRESH_RATE';
            case TautulliDatabaseValue.CONTENT_LOAD_LENGTH: return 'TAUTULLI_CONTENT_LOAD_LENGTH';
            case TautulliDatabaseValue.STATISTICS_STATS_COUNT: return 'TAUTULLI_STATISTICS_STATS_COUNT';
            case TautulliDatabaseValue.TERMINATION_MESSAGE: return 'TAUTULLI_TERMINATION_MESSAGE';
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
        }
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
