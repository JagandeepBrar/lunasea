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
        Hive.registerAdapter(SonarrSeriesSortingAdapter());
        Hive.registerAdapter(SonarrReleasesSortingAdapter());
    }
}

enum SonarrDatabaseValue {
    NAVIGATION_INDEX,
    NAVIGATION_INDEX_SERIES_DETAILS,
    ADD_SERIES_DEFAULT_MONITORED,
    ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS,
    ADD_SERIES_DEFAULT_SERIES_TYPE,
    ADD_SERIES_DEFAULT_MONITOR_STATUS,
    ADD_SERIES_DEFAULT_LANGUAGE_PROFILE,
    ADD_SERIES_DEFAULT_QUALITY_PROFILE,
    ADD_SERIES_DEFAULT_ROOT_FOLDER,
    DEFAULT_SORTING_SERIES,
    DEFAULT_SORTING_RELEASES,
    UPCOMING_FUTURE_DAYS,
    QUEUE_REFRESH_RATE,
    CONTENT_LOAD_LENGTH,
}

extension SonarrDatabaseValueExtension on SonarrDatabaseValue {
    String get key {
        switch(this) {
            case SonarrDatabaseValue.NAVIGATION_INDEX: return 'SONARR_NAVIGATION_INDEX';
            case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS: return 'SONARR_NAVIGATION_INDEX_SERIES_DETAILS';
            case SonarrDatabaseValue.UPCOMING_FUTURE_DAYS: return 'SONARR_UPCOMING_FUTURE_DAYS';
            case SonarrDatabaseValue.QUEUE_REFRESH_RATE: return 'SONARR_QUEUE_REFRESH_RATE';
            case SonarrDatabaseValue.CONTENT_LOAD_LENGTH: return 'SONARR_CONTENT_LOAD_LENGTH';
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED: return 'SONARR_ADD_SERIES_DEFAULT_MONITORED';
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS: return 'SONARR_ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS';
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE: return 'SONARR_ADD_SERIES_DEFAULT_SERIES_TYPE';
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS: return 'SONARR_ADD_SERIES_DEFAULT_MONITOR_STATUS';
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE: return 'SONARR_ADD_SERIES_DEFAULT_LANGUAGE_PROFILE';
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE: return 'SONARR_ADD_SERIES_DEFAULT_QUALITY_PROFILE';
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER: return 'SONARR_ADD_SERIES_DEFAULT_ROOT_FOLDER';
            case SonarrDatabaseValue.DEFAULT_SORTING_SERIES: return 'SONARR_DEFAULT_SORTING_SERIES';
            case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES: return 'SONARR_DEFAULT_SORTING_RELEASES';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case SonarrDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
            case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS: return _box.get(this.key, defaultValue: 0);
            case SonarrDatabaseValue.UPCOMING_FUTURE_DAYS: return _box.get(this.key, defaultValue: 7);
            case SonarrDatabaseValue.QUEUE_REFRESH_RATE: return _box.get(this.key, defaultValue: 60);
            case SonarrDatabaseValue.CONTENT_LOAD_LENGTH: return _box.get(this.key, defaultValue: 125);
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED: return _box.get(this.key, defaultValue: true);
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS: return _box.get(this.key, defaultValue: true);
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE: return _box.get(this.key, defaultValue: 'standard');
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS: return _box.get(this.key, defaultValue: SonarrMonitorStatus.ALL);
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE : return _box.get(this.key, defaultValue: null);
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE : return _box.get(this.key, defaultValue: null);
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER : return _box.get(this.key, defaultValue: null);
            case SonarrDatabaseValue.DEFAULT_SORTING_SERIES: return _box.get(this.key, defaultValue: SonarrSeriesSorting.ALPHABETICAL);
            case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES: return _box.get(this.key, defaultValue: SonarrReleasesSorting.WEIGHT);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
