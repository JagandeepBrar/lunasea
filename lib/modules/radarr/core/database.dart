import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/modules/radarr/core/deprecated/availability.dart';
import 'package:lunasea/modules/radarr/core/deprecated/qualityprofile.dart';
import 'package:lunasea/modules/radarr/core/deprecated/rootfolder.dart';

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
  ADD_MOVIE_DEFAULT_TAGS,
  ADD_MOVIE_SEARCH_FOR_MISSING,
  ADD_DISCOVER_USE_SUGGESTIONS,
  MANUAL_IMPORT_DEFAULT_MODE,
  QUEUE_PAGE_SIZE,
  QUEUE_REFRESH_RATE,
  QUEUE_BLACKLIST,
  QUEUE_REMOVE_FROM_CLIENT,
  REMOVE_MOVIE_IMPORT_LIST,
  REMOVE_MOVIE_DELETE_FILES,
  CONTENT_PAGE_SIZE,
}

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
    for (RadarrDatabaseValue value in RadarrDatabaseValue.values) {
      switch (value) {
        // Non-primative values
        case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES:
          data[value.key] = (RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.data
                  as RadarrMoviesSorting)
              .key;
          break;
        case RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES:
          data[value.key] = (RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES.data
                  as RadarrMoviesFilter)
              .key;
          break;
        case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES:
          data[value.key] = (RadarrDatabaseValue.DEFAULT_SORTING_RELEASES.data
                  as RadarrReleasesSorting)
              .key;
          break;
        case RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
          data[value.key] = (RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES.data
                  as RadarrReleasesFilter)
              .key;
          break;
        // Primitive values
        default:
          data[value.key] = value.data;
          break;
      }
    }
    return data;
  }

  @override
  void import(Map<String, dynamic> config) {
    for (String key in config.keys) {
      RadarrDatabaseValue value = valueFromKey(key);
      if (value != null)
        switch (value) {
          // Non-primative values
          case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES:
            value.put(RadarrMoviesSorting.ALPHABETICAL.fromKey(config[key]));
            break;
          case RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES:
            value.put(RadarrMoviesFilter.ALL.fromKey(config[key]));
            break;
          case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES:
            value.put(RadarrReleasesSorting.ALPHABETICAL.fromKey(config[key]));
            break;
          case RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
            value.put(RadarrReleasesFilter.ALL.fromKey(config[key]));
            break;
          // Primitive values
          default:
            value.put(config[key]);
            break;
        }
    }
  }

  @override
  RadarrDatabaseValue valueFromKey(String key) {
    for (RadarrDatabaseValue value in RadarrDatabaseValue.values) {
      if (value.key == key) return value;
    }
    return null;
  }
}

extension RadarrDatabaseValueExtension on RadarrDatabaseValue {
  String get key {
    return 'RADARR_${this.name}';
  }

  dynamic get data {
    return Database.lunaSeaBox.get(this.key, defaultValue: this._defaultValue);
  }

  void put(dynamic value) {
    if (this._isTypeValid(value)) {
      Database.lunaSeaBox.put(this.key, value);
    } else {
      LunaLogger().warning(
        this.runtimeType.toString(),
        'put',
        'Invalid Database Insert (${this.key}, ${value.runtimeType})',
      );
    }
  }

  ValueListenableBuilder listen({
    Key key,
    @required Widget Function(BuildContext, dynamic, Widget) builder,
  }) {
    return ValueListenableBuilder(
      key: key,
      valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
      builder: builder,
    );
  }

  dynamic get _defaultValue {
    switch (this) {
      case RadarrDatabaseValue.NAVIGATION_INDEX:
        return 0;
      case RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS:
        return 0;
      case RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE:
        return 0;
      case RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS:
        return 0;
      case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES:
        return RadarrMoviesSorting.ALPHABETICAL;
      case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING:
        return true;
      case RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES:
        return RadarrMoviesFilter.ALL;
      case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES:
        return RadarrReleasesSorting.WEIGHT;
      case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING:
        return true;
      case RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
        return RadarrReleasesFilter.ALL;
      case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MONITORED_STATE:
        return true;
      case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_ROOT_FOLDER_ID:
        return null;
      case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_QUALITY_PROFILE_ID:
        return null;
      case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MINIMUM_AVAILABILITY_ID:
        return RadarrAvailability.ANNOUNCED.value;
      case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_TAGS:
        return [];
      case RadarrDatabaseValue.ADD_DISCOVER_USE_SUGGESTIONS:
        return true;
      case RadarrDatabaseValue.MANUAL_IMPORT_DEFAULT_MODE:
        return RadarrImportMode.COPY.value;
      case RadarrDatabaseValue.QUEUE_PAGE_SIZE:
        return 50;
      case RadarrDatabaseValue.QUEUE_REFRESH_RATE:
        return 60;
      case RadarrDatabaseValue.QUEUE_BLACKLIST:
        return false;
      case RadarrDatabaseValue.QUEUE_REMOVE_FROM_CLIENT:
        return false;
      case RadarrDatabaseValue.REMOVE_MOVIE_IMPORT_LIST:
        return false;
      case RadarrDatabaseValue.REMOVE_MOVIE_DELETE_FILES:
        return false;
      case RadarrDatabaseValue.CONTENT_PAGE_SIZE:
        return 25;
      case RadarrDatabaseValue.ADD_MOVIE_SEARCH_FOR_MISSING:
        return false;
    }
    throw Exception('Invalid RadarrDatabaseValue');
  }

  bool _isTypeValid(dynamic value) {
    switch (this) {
      case RadarrDatabaseValue.NAVIGATION_INDEX:
        return value is int;
      case RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS:
        return value is int;
      case RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE:
        return value is int;
      case RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS:
        return value is int;
      case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES:
        return value is RadarrMoviesSorting;
      case RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING:
        return value is bool;
      case RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES:
        return value is RadarrMoviesFilter;
      case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES:
        return value is RadarrReleasesSorting;
      case RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING:
        return value is bool;
      case RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
        return value is RadarrReleasesFilter;
      case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MONITORED_STATE:
        return value is bool;
      case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_ROOT_FOLDER_ID:
        return value is int;
      case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_QUALITY_PROFILE_ID:
        return value is int;
      case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_MINIMUM_AVAILABILITY_ID:
        return value is String;
      case RadarrDatabaseValue.ADD_MOVIE_DEFAULT_TAGS:
        return value is List;
      case RadarrDatabaseValue.ADD_DISCOVER_USE_SUGGESTIONS:
        return value is bool;
      case RadarrDatabaseValue.MANUAL_IMPORT_DEFAULT_MODE:
        return value is String;
      case RadarrDatabaseValue.QUEUE_PAGE_SIZE:
        return value is int;
      case RadarrDatabaseValue.QUEUE_REFRESH_RATE:
        return value is int;
      case RadarrDatabaseValue.QUEUE_BLACKLIST:
        return value is bool;
      case RadarrDatabaseValue.QUEUE_REMOVE_FROM_CLIENT:
        return value is bool;
      case RadarrDatabaseValue.REMOVE_MOVIE_DELETE_FILES:
        return value is bool;
      case RadarrDatabaseValue.REMOVE_MOVIE_IMPORT_LIST:
        return value is bool;
      case RadarrDatabaseValue.CONTENT_PAGE_SIZE:
        return value is int;
      case RadarrDatabaseValue.ADD_MOVIE_SEARCH_FOR_MISSING:
        return value is bool;
    }
    throw Exception('Invalid RadarrDatabaseValue');
  }
}
