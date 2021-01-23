import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrDatabase extends LunaModuleDatabase {
    @override
    void registerAdapters() {
        // Deprecated, not in use but necessary to avoid Hive read errors
        Hive.registerAdapter(DeprecatedRadarrQualityProfileAdapter());
        Hive.registerAdapter(DeprecatedRadarrRootFolderAdapter());
        Hive.registerAdapter(DeprecatedRadarrAvailabilityAdapter());
        // Active adapters
        Hive.registerAdapter(RadarrMoviesSortingAdapter());
    }

    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        for(RadarrDatabaseValue value in RadarrDatabaseValue.values) {
            switch(value) {
                // Non-primative values
                case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES: data[value.key] = (RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.data as RadarrMoviesSorting).key; break;
                // Primitive values
                case RadarrDatabaseValue.NAVIGATION_INDEX: 
                case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING: data[value.key] = value.data; break;
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
                // Primitive values
                case RadarrDatabaseValue.NAVIGATION_INDEX:
                case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING: value.put(config[key]); break;
            }
        }
    }

    @override
    RadarrDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'RADARR_NAVIGATION_INDEX': return RadarrDatabaseValue.NAVIGATION_INDEX;
            case 'RADARR_DEFAULT_SORTING_MOVIES': return RadarrDatabaseValue.DEFAULT_SORTING_MOVIES;
            case 'RADARR_DEFAULT_SORTING_MOVIES_ASCENDING': return RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING;
            default: return null;
        }
    }
}

enum RadarrDatabaseValue {
    NAVIGATION_INDEX,
    DEFAULT_SORTING_MOVIES,
    DEFAULT_SORTING_MOVIES_ASCENDING,
}

extension RadarrDatabaseValueExtension on RadarrDatabaseValue {
    String get key {
        switch(this) {
            case RadarrDatabaseValue.NAVIGATION_INDEX: return 'RADARR_NAVIGATION_INDEX';
            case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES: return 'RADARR_DEFAULT_SORTING_MOVIES';
            case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING: return 'RADARR_DEFAULT_SORTING_MOVIES_ASCENDING';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case RadarrDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
            case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES: return _box.get(this.key, defaultValue: RadarrMoviesSorting.ALPHABETICAL);
            case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING: return _box.get(this.key, defaultValue: true);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case RadarrDatabaseValue.NAVIGATION_INDEX: if(value.runtimeType == int) box.put(this.key, value); return;
            case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES: if(value.runtimeType == RadarrMoviesSorting) box.put(this.key, value); return;
            case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING: if(value.runtimeType == bool) box.put(this.key, value); return;
        }
        LunaLogger().warning('RadarrDatabaseValueExtension', 'put', 'Attempted to enter data for invalid RadarrDatabaseValue: ${this?.toString() ?? 'null'}');
    }

    ValueListenableBuilder listen(Widget Function(BuildContext, Box<dynamic>, Widget) builder) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
        builder: builder,
    );
}
