import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrDatabase {
    SonarrDatabase._();

    static void registerAdapters() {
        // Deprecated, not in use but necessary to avoid Hive read errors
        Hive.registerAdapter(DeprecatedSonarrQualityProfileAdapter());
        Hive.registerAdapter(DeprecatedSonarrRootFolderAdapter());
        Hive.registerAdapter(DeprecatedSonarrSeriesTypeAdapter());
        // Active adapters
        Hive.registerAdapter(SonarrMonitorStatusAdapter());
    }
}

enum SonarrDatabaseValue {
    NAVIGATION_INDEX,
    NAVIGATION_INDEX_SERIES_DETAILS,
    ADD_MONITORED,
    ADD_SEASON_FOLDERS,
    QUEUE_REFRESH_RATE,
    CONTENT_LOAD_LENGTH,
}

extension SonarrDatabaseValueExtension on SonarrDatabaseValue {
    String get key {
        switch(this) {
            case SonarrDatabaseValue.NAVIGATION_INDEX: return 'SONARR_NAVIGATION_INDEX';
            case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS: return 'SONARR_NAVIGATION_INDEX_SERIES_DETAILS';
            case SonarrDatabaseValue.ADD_MONITORED: return 'SONARR_ADD_MONITORED';
            case SonarrDatabaseValue.ADD_SEASON_FOLDERS: return 'SONARR_ADD_SEASON_FOLDERS';
            case SonarrDatabaseValue.QUEUE_REFRESH_RATE: return 'SONARR_QUEUE_REFRESH_RATE';
            case SonarrDatabaseValue.CONTENT_LOAD_LENGTH: return 'SONARR_CONTENT_LOAD_LENGTH';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case SonarrDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
            case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS: return _box.get(this.key, defaultValue: 0);
            case SonarrDatabaseValue.ADD_MONITORED: return _box.get(this.key, defaultValue: true);
            case SonarrDatabaseValue.ADD_SEASON_FOLDERS: return _box.get(this.key, defaultValue: true);
            case SonarrDatabaseValue.QUEUE_REFRESH_RATE: return _box.get(this.key, defaultValue: 60);
            case SonarrDatabaseValue.CONTENT_LOAD_LENGTH: return _box.get(this.key, defaultValue: 125);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
