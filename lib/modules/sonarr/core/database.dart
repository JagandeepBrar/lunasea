import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrDatabase extends LunaModuleDatabase {
    @override
    void registerAdapters() {
        // Deprecated, not in use but necessary to avoid Hive read errors
        Hive.registerAdapter(DeprecatedSonarrQualityProfileAdapter());
        Hive.registerAdapter(DeprecatedSonarrRootFolderAdapter());
        Hive.registerAdapter(DeprecatedSonarrSeriesTypeAdapter());
        // Active adapters
        Hive.registerAdapter(SonarrMonitorStatusAdapter());
        Hive.registerAdapter(SonarrSeriesSortingAdapter());
        Hive.registerAdapter(SonarrReleasesSortingAdapter());
    }

    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        for(SonarrDatabaseValue value in SonarrDatabaseValue.values) {
            switch(value) {
                // Non-primitive values
                case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS: data[value.key] = (SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS.data as SonarrMonitorStatus).key; break;
                case SonarrDatabaseValue.DEFAULT_SORTING_SERIES: data[value.key] = (SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data as SonarrSeriesSorting).key; break;
                case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES: data[value.key] = (SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.data as SonarrReleasesSorting).key; break;
                // Primitive values
                case SonarrDatabaseValue.NAVIGATION_INDEX:
                case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS:
                case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED:
                case SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS:
                case SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE:
                case SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE:
                case SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE:
                case SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER:
                case SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING:
                case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING:
                case SonarrDatabaseValue.UPCOMING_FUTURE_DAYS:
                case SonarrDatabaseValue.QUEUE_REFRESH_RATE:
                case SonarrDatabaseValue.CONTENT_LOAD_LENGTH: data[value.key] = value.data; break;
            }
        }
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        for(String key in config.keys) {
            SonarrDatabaseValue value = valueFromKey(key);
            if(value != null) switch(value) {
                // Non-primitive values
                case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS: value.put(SonarrMonitorStatus.ALL.fromKey(config[key])); break;
                case SonarrDatabaseValue.DEFAULT_SORTING_SERIES: value.put(SonarrSeriesSorting.ALPHABETICAL.fromKey(config[key])); break;
                case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES: value.put(SonarrReleasesSorting.ALPHABETICAL.fromKey(config[key])); break;
                // Primitive values
                case SonarrDatabaseValue.NAVIGATION_INDEX: 
                case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS: 
                case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED: 
                case SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS: 
                case SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE: 
                case SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE: 
                case SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE: 
                case SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER: 
                case SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING: 
                case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING: 
                case SonarrDatabaseValue.UPCOMING_FUTURE_DAYS: 
                case SonarrDatabaseValue.QUEUE_REFRESH_RATE: 
                case SonarrDatabaseValue.CONTENT_LOAD_LENGTH: value.put(config[key]); break;
            }
        }
    }

    @override
    SonarrDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'SONARR_NAVIGATION_INDEX': return SonarrDatabaseValue.NAVIGATION_INDEX;
            case 'SONARR_NAVIGATION_INDEX_SERIES_DETAILS': return SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS;
            case 'SONARR_UPCOMING_FUTURE_DAYS': return SonarrDatabaseValue.UPCOMING_FUTURE_DAYS;
            case 'SONARR_QUEUE_REFRESH_RATE': return SonarrDatabaseValue.QUEUE_REFRESH_RATE;
            case 'SONARR_CONTENT_LOAD_LENGTH': return SonarrDatabaseValue.CONTENT_LOAD_LENGTH;
            case 'SONARR_ADD_SERIES_DEFAULT_MONITORED': return SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED;
            case 'SONARR_ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS': return SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS;
            case 'SONARR_ADD_SERIES_DEFAULT_SERIES_TYPE': return SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE;
            case 'SONARR_ADD_SERIES_DEFAULT_MONITOR_STATUS': return SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS;
            case 'SONARR_ADD_SERIES_DEFAULT_LANGUAGE_PROFILE': return SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE;
            case 'SONARR_ADD_SERIES_DEFAULT_QUALITY_PROFILE': return SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE;
            case 'SONARR_ADD_SERIES_DEFAULT_ROOT_FOLDER': return SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER;
            case 'SONARR_DEFAULT_SORTING_SERIES': return SonarrDatabaseValue.DEFAULT_SORTING_SERIES;
            case 'SONARR_DEFAULT_SORTING_RELEASES': return SonarrDatabaseValue.DEFAULT_SORTING_RELEASES;
            case 'SONARR_DEFAULT_SORTING_SERIES_ASCENDING': return SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING;
            case 'SONARR_DEFAULT_SORTING_RELEASES_ASCENDING': return SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING;
            default: return null;
        }
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
    DEFAULT_SORTING_SERIES_ASCENDING,
    DEFAULT_SORTING_RELEASES_ASCENDING,
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
            case SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING: return 'SONARR_DEFAULT_SORTING_SERIES_ASCENDING';
            case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING: return 'SONARR_DEFAULT_SORTING_RELEASES_ASCENDING';
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
            case SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING: return _box.get(this.key, defaultValue: true);
            case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING: return _box.get(this.key, defaultValue: true);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case SonarrDatabaseValue.NAVIGATION_INDEX: if(value.runtimeType == int) box.put(this.key, value); return;
            case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS: if(value.runtimeType == int) box.put(this.key, value); return;
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED: if(value.runtimeType == bool) box.put(this.key, value); return;
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS: if(value.runtimeType == bool) box.put(this.key, value); return;
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE: if(value.runtimeType == String) box.put(this.key, value); return;
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_STATUS: if(value.runtimeType == SonarrMonitorStatus) box.put(this.key, value); return;
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE: if(value.runtimeType == int) box.put(this.key, value); return;
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE: if(value.runtimeType == int) box.put(this.key, value); return;
            case SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER: if(value.runtimeType == int) box.put(this.key, value); return;
            case SonarrDatabaseValue.DEFAULT_SORTING_SERIES: if(value.runtimeType == SonarrSeriesSorting) box.put(this.key, value); return;
            case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES: if(value.runtimeType == SonarrReleasesSorting) box.put(this.key, value); return;
            case SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING: if(value.runtimeType == bool) box.put(this.key, value); return;
            case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING: if(value.runtimeType == bool) box.put(this.key, value); return;
            case SonarrDatabaseValue.UPCOMING_FUTURE_DAYS: if(value.runtimeType == int) box.put(this.key, value); return;
            case SonarrDatabaseValue.QUEUE_REFRESH_RATE: if(value.runtimeType == int) box.put(this.key, value); return;
            case SonarrDatabaseValue.CONTENT_LOAD_LENGTH: if(value.runtimeType == int) box.put(this.key, value); return;
        }
        LunaLogger().warning('SonarrDatabaseValueExtension', 'put', 'Attempted to enter data for invalid SonarrDatabaseValue: ${this?.toString() ?? 'null'}');
    }//=> Database.lunaSeaBox.put(this.key, value);

    ValueListenableBuilder listen({ @required Widget Function(BuildContext, dynamic, Widget) builder }) =>  ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
        builder: builder,
    );
}
