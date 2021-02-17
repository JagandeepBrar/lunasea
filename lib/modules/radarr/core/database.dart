import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/modules/radarr/core/deprecated/availability.dart';
import 'package:lunasea/modules/radarr/core/deprecated/qualityprofile.dart';
import 'package:lunasea/modules/radarr/core/deprecated/rootfolder.dart';

class RadarrDatabase extends LunaModuleDatabase {
    @override
    void registerAdapters() {
        // Deprecated, not in use but necessary to avoid Hive read errors
        Hive.registerAdapter(DeprecatedRadarrQualityProfileAdapter());
        Hive.registerAdapter(DeprecatedRadarrRootFolderAdapter());
        Hive.registerAdapter(DeprecatedRadarrAvailabilityAdapter());
        // Active adapters
        Hive.registerAdapter(RadarrMoviesSortingAdapter());
        Hive.registerAdapter(RadarrMoviesFilterAdapter());
        Hive.registerAdapter(RadarrReleasesSortingAdapter());
        Hive.registerAdapter(RadarrReleasesFilterAdapter());
    }

    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        for(RadarrDatabaseValue value in RadarrDatabaseValue.values) {
            switch(value) {
                // Non-primative values
                case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES: data[value.key] = (RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.data as RadarrMoviesSorting).key; break;
                case RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES: data[value.key] = (RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES.data as RadarrMoviesFilter).key; break;
                case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES: data[value.key] = (RadarrDatabaseValue.DEFAULT_SORTING_RELEASES.data as RadarrReleasesSorting).key; break;
                case RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES: data[value.key] = (RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES.data as RadarrReleasesFilter).key; break;
                // Primitive values
                case RadarrDatabaseValue.NAVIGATION_INDEX:
                case RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS:
                case RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE:
                case RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS:
                case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING:
                case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING:
                case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MONITORED_STATE:
                case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_ROOT_FOLDER_ID:
                case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_QUALITY_PROFILE_ID:
                case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MINIMUM_AVAILABILITY_ID:
                case RadarrDatabaseValue.REMOVE_MOVIE_IMPORT_LIST:
                case RadarrDatabaseValue.REMOVE_MOVIE_DELETE_FILES:
                case RadarrDatabaseValue.CONTENT_PAGE_SIZE: data[value.key] = value.data; break;
            }
        }
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        for(String key in config.keys) {
            RadarrDatabaseValue value = valueFromKey(key);
            if(value != null) switch(value) {
                // Non-primative values
                case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES: value.put(RadarrMoviesSorting.ALPHABETICAL.fromKey(config[key])); break;
                case RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES: value.put(RadarrMoviesFilter.ALL.fromKey(config[key])); break;
                case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES: value.put(RadarrReleasesSorting.ALPHABETICAL.fromKey(config[key])); break;
                case RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES: value.put(RadarrReleasesFilter.ALL.fromKey(config[key])); break;
                // Primitive values
                case RadarrDatabaseValue.NAVIGATION_INDEX:
                case RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS:
                case RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE:
                case RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS:
                case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING:
                case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING:
                case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MONITORED_STATE:
                case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_ROOT_FOLDER_ID:
                case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_QUALITY_PROFILE_ID:
                case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MINIMUM_AVAILABILITY_ID:
                case RadarrDatabaseValue.REMOVE_MOVIE_DELETE_FILES:
                case RadarrDatabaseValue.REMOVE_MOVIE_IMPORT_LIST:
                case RadarrDatabaseValue.CONTENT_PAGE_SIZE: value.put(config[key]); break;
            }
        }
    }

    @override
    RadarrDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'RADARR_NAVIGATION_INDEX': return RadarrDatabaseValue.NAVIGATION_INDEX;
            case 'RADARR_NAVIGATION_INDEX_MOVIE_DETAILS': return RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS;
            case 'RADARR_NAVIGATION_INDEX_ADD_MOVIE': return RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE;
            case 'RADARR_NAVIGATION_INDEX_SYSTEM_STATUS': return RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS;
            case 'RADARR_DEFAULT_SORTING_MOVIES': return RadarrDatabaseValue.DEFAULT_SORTING_MOVIES;
            case 'RADARR_DEFAULT_SORTING_MOVIES_ASCENDING': return RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING;
            case 'RADARR_DEFAULT_FILTERING_MOVIES': return RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES;
            case 'RADARR_DEFAULT_SORTING_RELEASES': return RadarrDatabaseValue.DEFAULT_SORTING_RELEASES;
            case 'RADARR_DEFAULT_SORTING_RELEASES_ASCENDING': return RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING;
            case 'RADARR_DEFAULT_FILTERING_RELEASES': return RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES;
            case 'RADARR_ADD_MOVIE_DEFAULT_MONITORED_STATE': return RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MONITORED_STATE;
            case 'RADARR_ADD_MOVIE_DEFAULT_ROOT_FOLDER_ID': return RadarrDatabaseValue.ADD_MOVIE_DEFAULT_ROOT_FOLDER_ID;
            case 'RADARR_ADD_MOVIE_DEFAULT_QUALITY_PROFILE_ID': return RadarrDatabaseValue.ADD_MOVIE_DEFAULT_QUALITY_PROFILE_ID;
            case 'RADARR_ADD_MOVIE_DEFAULT_MINIMUM_AVAILABILITY_ID': return RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MINIMUM_AVAILABILITY_ID;
            case 'RADARR_REMOVE_MOVIE_IMPORT_LIST': return RadarrDatabaseValue.REMOVE_MOVIE_IMPORT_LIST;
            case 'RADARR_REMOVE_MOVIE_DELETE_FILES': return RadarrDatabaseValue.REMOVE_MOVIE_DELETE_FILES;
            case 'RADARR_CONTENT_PAGE_SIZE': return RadarrDatabaseValue.CONTENT_PAGE_SIZE;
            default: return null;
        }
    }
}

enum RadarrDatabaseValue {
    NAVIGATION_INDEX,
    NAVIGATION_INDEX_MOVIE_DETAILS,
    NAVIGATION_INDEX_ADD_MOVIE,
    NAVIGATION_INDEX_SYSTEM_STATUS,
    DEFAULT_SORTING_MOVIES,
    DEFAULT_SORTING_MOVIES_ASCENDING,
    DEFAULT_FILTERING_MOVIES,
    DEFAULT_SORTING_RELEASES,
    DEFAULT_SORTING_RELEASES_ASCENDING,
    DEFAULT_FILTERING_RELEASES,
    ADD_MOVIE_DEFAULT_MONITORED_STATE,
    ADD_MOVIE_DEFAULT_ROOT_FOLDER_ID,
    ADD_MOVIE_DEFAULT_QUALITY_PROFILE_ID,
    ADD_MOVIE_DEFAULT_MINIMUM_AVAILABILITY_ID,
    REMOVE_MOVIE_IMPORT_LIST,
    REMOVE_MOVIE_DELETE_FILES,
    CONTENT_PAGE_SIZE,
}

extension RadarrDatabaseValueExtension on RadarrDatabaseValue {
    String get key {
        switch(this) {
            case RadarrDatabaseValue.NAVIGATION_INDEX: return 'RADARR_NAVIGATION_INDEX';
            case RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS: return 'RADARR_NAVIGATION_INDEX_MOVIE_DETAILS';
            case RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE: return 'RADARR_NAVIGATION_INDEX_ADD_MOVIE';
            case RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS: return 'RADARR_NAVIGATION_INDEX_SYSTEM_STATUS';
            case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES: return 'RADARR_DEFAULT_SORTING_MOVIES';
            case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING: return 'RADARR_DEFAULT_SORTING_MOVIES_ASCENDING';
            case RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES: return 'RADARR_DEFAULT_FILTERING_MOVIES';
            case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES: return 'RADARR_DEFAULT_SORTING_RELEASES';
            case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING: return 'RADARR_DEFAULT_SORTING_RELEASES_ASCENDING';
            case RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES: return 'RADARR_DEFAULT_FILTERING_RELEASES';
            case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MONITORED_STATE: return 'RADARR_ADD_MOVIE_DEFAULT_MONITORED_STATE';
            case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_ROOT_FOLDER_ID: return 'RADARR_ADD_MOVIE_DEFAULT_ROOT_FOLDER_ID';
            case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_QUALITY_PROFILE_ID: return 'RADARR_ADD_MOVIE_DEFAULT_QUALITY_PROFILE_ID';
            case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MINIMUM_AVAILABILITY_ID: return 'RADARR_ADD_MOVIE_DEFAULT_MINIMUM_AVAILABILITY_ID';
            case RadarrDatabaseValue.REMOVE_MOVIE_IMPORT_LIST: return 'RADARR_REMOVE_MOVIE_IMPORT_LIST';
            case RadarrDatabaseValue.REMOVE_MOVIE_DELETE_FILES: return 'RADARR_REMOVE_MOVIE_DELETE_FILES';
            case RadarrDatabaseValue.CONTENT_PAGE_SIZE: return 'RADARR_CONTENT_PAGE_SIZE';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case RadarrDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
            case RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS: return _box.get(this.key, defaultValue: 0);
            case RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE: return _box.get(this.key, defaultValue: 0);
            case RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS: return _box.get(this.key, defaultValue: 0);
            case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES: return _box.get(this.key, defaultValue: RadarrMoviesSorting.ALPHABETICAL);
            case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING: return _box.get(this.key, defaultValue: true);
            case RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES: return _box.get(this.key, defaultValue: RadarrMoviesFilter.ALL);
            case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES: return _box.get(this.key, defaultValue: RadarrReleasesSorting.WEIGHT);
            case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING: return _box.get(this.key, defaultValue: true);
            case RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES: return _box.get(this.key, defaultValue: RadarrReleasesFilter.ALL);
            case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MONITORED_STATE: return _box.get(this.key, defaultValue: true);
            case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_ROOT_FOLDER_ID: return _box.get(this.key, defaultValue: null);
            case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_QUALITY_PROFILE_ID: return _box.get(this.key, defaultValue: null);
            case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MINIMUM_AVAILABILITY_ID: return _box.get(this.key, defaultValue: 'announced');
            case RadarrDatabaseValue.REMOVE_MOVIE_DELETE_FILES: return _box.get(this.key, defaultValue: false);
            case RadarrDatabaseValue.REMOVE_MOVIE_IMPORT_LIST: return _box.get(this.key, defaultValue: false);
            case RadarrDatabaseValue.CONTENT_PAGE_SIZE: return _box.get(this.key, defaultValue: 25);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case RadarrDatabaseValue.NAVIGATION_INDEX: if(value.runtimeType == int) box.put(this.key, value); return;
            case RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS: if(value.runtimeType == int) box.put(this.key, value); return;
            case RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE: if(value.runtimeType == int) box.put(this.key, value); return;
            case RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS: if(value.runtimeType == int) box.put(this.key, value); return;
            case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES: if(value.runtimeType == RadarrMoviesSorting) box.put(this.key, value); return;
            case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING: if(value.runtimeType == bool) box.put(this.key, value); return;
            case RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES: if(value.runtimeType == RadarrMoviesFilter) box.put(this.key, value); return;
            case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES: if(value.runtimeType == RadarrReleasesSorting) box.put(this.key, value); return;
            case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING: if(value.runtimeType == bool) box.put(this.key, value); return;
            case RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES: if(value.runtimeType == RadarrReleasesFilter) box.put(this.key, value); return;
            case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MONITORED_STATE: if(value.runtimeType == bool) box.put(this.key, value); return;
            case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_ROOT_FOLDER_ID: if(value.runtimeType == int) box.put(this.key, value); return;
            case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_QUALITY_PROFILE_ID: if(value.runtimeType == int) box.put(this.key, value); return;
            case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MINIMUM_AVAILABILITY_ID: if(value.runtimeType == String) box.put(this.key, value); return;
            case RadarrDatabaseValue.REMOVE_MOVIE_DELETE_FILES: if(value.runtimeType == bool) box.put(this.key, value); return;
            case RadarrDatabaseValue.REMOVE_MOVIE_IMPORT_LIST: if(value.runtimeType == bool) box.put(this.key, value); return;
            case RadarrDatabaseValue.CONTENT_PAGE_SIZE: if(value.runtimeType == int) box.put(this.key, value); return;
        }
        LunaLogger().warning('RadarrDatabaseValueExtension', 'put', 'Attempted to enter data for invalid RadarrDatabaseValue: ${this?.toString() ?? 'null'}');
    }

    ValueListenableBuilder listen({ @required Widget Function(BuildContext, dynamic, Widget) builder }) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
        builder: builder,
    );
}
