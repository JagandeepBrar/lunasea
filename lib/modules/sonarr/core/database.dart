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
}

extension SonarrDatabaseValueExtension on SonarrDatabaseValue {
    String get key {
        switch(this) {
            case SonarrDatabaseValue.NAVIGATION_INDEX: return 'SONARR_NAVIGATION_INDEX';
            case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS: return 'SONARR_NAVIGATION_INDEX_SERIES_DETAILS';
            case SonarrDatabaseValue.ADD_MONITORED: return 'SONARR_ADD_MONITORED';
            case SonarrDatabaseValue.ADD_SEASON_FOLDERS: return 'SONARR_ADD_SEASON_FOLDERS';
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
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
