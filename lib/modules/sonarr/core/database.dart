import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

enum SonarrDatabaseValue {
  NAVIGATION_INDEX,
  NAVIGATION_INDEX_SERIES_DETAILS,
  NAVIGATION_INDEX_SEASON_DETAILS,
  ADD_SERIES_SEARCH_FOR_MISSING,
  ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET,
  ADD_SERIES_DEFAULT_MONITORED,
  ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS,
  ADD_SERIES_DEFAULT_SERIES_TYPE,
  ADD_SERIES_DEFAULT_MONITOR_TYPE,
  ADD_SERIES_DEFAULT_LANGUAGE_PROFILE,
  ADD_SERIES_DEFAULT_QUALITY_PROFILE,
  ADD_SERIES_DEFAULT_ROOT_FOLDER,
  ADD_SERIES_DEFAULT_TAGS,
  DEFAULT_FILTERING_SERIES,
  DEFAULT_FILTERING_RELEASES,
  DEFAULT_SORTING_SERIES,
  DEFAULT_SORTING_RELEASES,
  DEFAULT_SORTING_SERIES_ASCENDING,
  DEFAULT_SORTING_RELEASES_ASCENDING,
  REMOVE_SERIES_DELETE_FILES,
  REMOVE_SERIES_EXCLUSION_LIST,
  UPCOMING_FUTURE_DAYS,
  QUEUE_PAGE_SIZE,
  QUEUE_REFRESH_RATE,
  QUEUE_REMOVE_DOWNLOAD_CLIENT,
  QUEUE_ADD_BLOCKLIST,
  CONTENT_PAGE_SIZE,
}

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
    Hive.registerAdapter(SonarrSeriesFilterAdapter());
    Hive.registerAdapter(SonarrReleasesSortingAdapter());
    Hive.registerAdapter(SonarrReleasesFilterAdapter());
  }

  @override
  Map<String, dynamic> export() {
    Map<String, dynamic> data = {};
    for (SonarrDatabaseValue value in SonarrDatabaseValue.values) {
      switch (value) {
        // Non-primitive values
        case SonarrDatabaseValue.DEFAULT_SORTING_SERIES:
          data[value.key] = (SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data
                  as SonarrSeriesSorting)
              .key;
          break;
        case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES:
          data[value.key] = (SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.data
                  as SonarrReleasesSorting)
              .key;
          break;
        case SonarrDatabaseValue.DEFAULT_FILTERING_SERIES:
          data[value.key] = (SonarrDatabaseValue.DEFAULT_FILTERING_SERIES.data
                  as SonarrSeriesFilter)
              .key;
          break;
        case SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
          data[value.key] = (SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES.data
                  as SonarrReleasesFilter)
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
      SonarrDatabaseValue value = valueFromKey(key);
      if (value != null)
        switch (value) {
          // Non-primitive values
          case SonarrDatabaseValue.DEFAULT_SORTING_SERIES:
            value.put(SonarrSeriesSorting.ALPHABETICAL.fromKey(config[key]));
            break;
          case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES:
            value.put(SonarrReleasesSorting.ALPHABETICAL.fromKey(config[key]));
            break;
          case SonarrDatabaseValue.DEFAULT_FILTERING_SERIES:
            value.put(SonarrSeriesFilter.ALL.fromKey(config[key]));
            break;
          case SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
            value.put(SonarrReleasesFilter.ALL.fromKey(config[key]));
            break;
          // Primitive values
          default:
            value.put(config[key]);
            break;
        }
    }
  }

  @override
  SonarrDatabaseValue valueFromKey(String key) {
    for (SonarrDatabaseValue value in SonarrDatabaseValue.values) {
      if (value.key == key) return value;
    }
    return null;
  }
}

extension SonarrDatabaseValueExtension on SonarrDatabaseValue {
  String get key {
    return 'SONARR_${this.name}';
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

  bool _isTypeValid(dynamic value) {
    switch (this) {
      case SonarrDatabaseValue.NAVIGATION_INDEX:
        return value is int;
      case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS:
        return value is int;
      case SonarrDatabaseValue.NAVIGATION_INDEX_SEASON_DETAILS:
        return value is int;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED:
        return value is bool;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS:
        return value is bool;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE:
        return value is String;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_TYPE:
        return value is String;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE:
        return value is int;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE:
        return value is int;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER:
        return value is int;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_TAGS:
        return value is List;
      case SonarrDatabaseValue.DEFAULT_SORTING_SERIES:
        return value is SonarrSeriesSorting;
      case SonarrDatabaseValue.DEFAULT_FILTERING_SERIES:
        return value is SonarrSeriesFilter;
      case SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
        return value is SonarrReleasesFilter;
      case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES:
        return value is SonarrReleasesSorting;
      case SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING:
        return value is bool;
      case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING:
        return value is bool;
      case SonarrDatabaseValue.UPCOMING_FUTURE_DAYS:
        return value is int;
      case SonarrDatabaseValue.QUEUE_PAGE_SIZE:
        return value is int;
      case SonarrDatabaseValue.QUEUE_REFRESH_RATE:
        return value is int;
      case SonarrDatabaseValue.CONTENT_PAGE_SIZE:
        return value is int;
      case SonarrDatabaseValue.REMOVE_SERIES_DELETE_FILES:
        return value is bool;
      case SonarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST:
        return value is bool;
      case SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET:
        return value is bool;
      case SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_MISSING:
        return value is bool;
      case SonarrDatabaseValue.QUEUE_REMOVE_DOWNLOAD_CLIENT:
        return value is bool;
      case SonarrDatabaseValue.QUEUE_ADD_BLOCKLIST:
        return value is bool;
    }
    throw Exception('Invalid SonarrDatabaseValue');
  }

  dynamic get _defaultValue {
    switch (this) {
      case SonarrDatabaseValue.NAVIGATION_INDEX:
        return 0;
      case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS:
        return 0;
      case SonarrDatabaseValue.NAVIGATION_INDEX_SEASON_DETAILS:
        return 0;
      case SonarrDatabaseValue.UPCOMING_FUTURE_DAYS:
        return 7;
      case SonarrDatabaseValue.QUEUE_PAGE_SIZE:
        return 50;
      case SonarrDatabaseValue.QUEUE_REFRESH_RATE:
        return 15;
      case SonarrDatabaseValue.CONTENT_PAGE_SIZE:
        return 25;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED:
        return true;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS:
        return true;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE:
        return SonarrSeriesType.STANDARD.value;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_TYPE:
        return SonarrSeriesMonitorType.ALL.value;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE:
        return null;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE:
        return null;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER:
        return null;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_TAGS:
        return [];
      case SonarrDatabaseValue.DEFAULT_SORTING_SERIES:
        return SonarrSeriesSorting.ALPHABETICAL;
      case SonarrDatabaseValue.DEFAULT_FILTERING_SERIES:
        return SonarrSeriesFilter.ALL;
      case SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
        return SonarrReleasesFilter.ALL;
      case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES:
        return SonarrReleasesSorting.WEIGHT;
      case SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING:
        return true;
      case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING:
        return true;
      case SonarrDatabaseValue.REMOVE_SERIES_DELETE_FILES:
        return false;
      case SonarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST:
        return false;
      case SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET:
        return false;
      case SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_MISSING:
        return false;
      case SonarrDatabaseValue.QUEUE_REMOVE_DOWNLOAD_CLIENT:
        return false;
      case SonarrDatabaseValue.QUEUE_ADD_BLOCKLIST:
        return false;
    }
    throw Exception('Invalid SonarrDatabaseValue');
  }
}
