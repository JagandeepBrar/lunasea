import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart' hide SonarrDatabaseValueExtension;

class SonarrDatabase {
    SonarrDatabase._();

    static void registerAdapters() {
        Hive.registerAdapter(SonarrQualityProfileAdapter());
        Hive.registerAdapter(SonarrRootFolderAdapter());
        Hive.registerAdapter(SonarrSeriesTypeAdapter());
        Hive.registerAdapter(SonarrMonitorStatusAdapter());
    }
}

enum SonarrDatabaseValue {
    NAVIGATION_INDEX,
    ADD_MONITORED,
    ADD_SEASON_FOLDERS,
    ADD_QUALITY_PROFILE,
    ADD_ROOT_FOLDER,
    ADD_SERIES_TYPE,
    ADD_MONITOR_STATUS,
}

extension SonarrDatabaseValueExtension on SonarrDatabaseValue {
    String get key {
        switch(this) {
            case SonarrDatabaseValue.NAVIGATION_INDEX: return 'SONARR_NAVIGATION_INDEX';
            case SonarrDatabaseValue.ADD_MONITORED: return 'SONARR_ADD_MONITORED';
            case SonarrDatabaseValue.ADD_SEASON_FOLDERS: return 'SONARR_ADD_SEASON_FOLDERS';
            case SonarrDatabaseValue.ADD_QUALITY_PROFILE: return 'SONARR_ADD_QUALITY_PROFILE';
            case SonarrDatabaseValue.ADD_ROOT_FOLDER: return 'SONARR_ADD_ROOT_FOLDER';
            case SonarrDatabaseValue.ADD_SERIES_TYPE: return 'SONARR_ADD_SERIES_TYPE';
            case SonarrDatabaseValue.ADD_MONITOR_STATUS: return 'SONARR_ADD_MONITOR_STATUS';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case SonarrDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
            case SonarrDatabaseValue.ADD_MONITORED: return _box.get(this.key, defaultValue: true);
            case SonarrDatabaseValue.ADD_SEASON_FOLDERS: return _box.get(this.key, defaultValue: true);
            case SonarrDatabaseValue.ADD_QUALITY_PROFILE: return _box.get(this.key);
            case SonarrDatabaseValue.ADD_ROOT_FOLDER: return _box.get(this.key);
            case SonarrDatabaseValue.ADD_SERIES_TYPE: return _box.get(this.key);
            case SonarrDatabaseValue.ADD_MONITOR_STATUS: return _box.get(this.key);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
