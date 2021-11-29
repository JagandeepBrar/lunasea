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
        case SonarrDatabaseValue.NAVIGATION_INDEX:
        case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS:
        case SonarrDatabaseValue.NAVIGATION_INDEX_SEASON_DETAILS:
        case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED:
        case SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS:
        case SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE:
        case SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE:
        case SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE:
        case SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER:
        case SonarrDatabaseValue.ADD_SERIES_DEFAULT_TAGS:
        case SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING:
        case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING:
        case SonarrDatabaseValue.UPCOMING_FUTURE_DAYS:
        case SonarrDatabaseValue.QUEUE_REFRESH_RATE:
        case SonarrDatabaseValue.CONTENT_PAGE_SIZE:
        case SonarrDatabaseValue.REMOVE_SERIES_DELETE_FILES:
        case SonarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST:
        case SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_MISSING:
        case SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET:
        case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_TYPE:
        case SonarrDatabaseValue.QUEUE_ADD_BLOCKLIST:
        case SonarrDatabaseValue.QUEUE_REMOVE_DOWNLOAD_CLIENT:
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
          case SonarrDatabaseValue.NAVIGATION_INDEX:
          case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS:
          case SonarrDatabaseValue.NAVIGATION_INDEX_SEASON_DETAILS:
          case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED:
          case SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS:
          case SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE:
          case SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE:
          case SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE:
          case SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER:
          case SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING:
          case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING:
          case SonarrDatabaseValue.ADD_SERIES_DEFAULT_TAGS:
          case SonarrDatabaseValue.UPCOMING_FUTURE_DAYS:
          case SonarrDatabaseValue.QUEUE_REFRESH_RATE:
          case SonarrDatabaseValue.CONTENT_PAGE_SIZE:
          case SonarrDatabaseValue.REMOVE_SERIES_DELETE_FILES:
          case SonarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST:
          case SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_MISSING:
          case SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET:
          case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_TYPE:
          case SonarrDatabaseValue.QUEUE_ADD_BLOCKLIST:
          case SonarrDatabaseValue.QUEUE_REMOVE_DOWNLOAD_CLIENT:
            value.put(config[key]);
            break;
        }
    }
  }

  @override
  SonarrDatabaseValue valueFromKey(String value) {
    switch (value) {
      case 'SONARR_NAVIGATION_INDEX':
        return SonarrDatabaseValue.NAVIGATION_INDEX;
      case 'SONARR_NAVIGATION_INDEX_SERIES_DETAILS':
        return SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS;
      case 'SONARR_NAVIGATION_INDEX_SEASON_DETAILS':
        return SonarrDatabaseValue.NAVIGATION_INDEX_SEASON_DETAILS;
      case 'SONARR_UPCOMING_FUTURE_DAYS':
        return SonarrDatabaseValue.UPCOMING_FUTURE_DAYS;
      case 'SONARR_QUEUE_REFRESH_RATE':
        return SonarrDatabaseValue.QUEUE_REFRESH_RATE;
      case 'SONARR_CONTENT_PAGE_SIZE':
        return SonarrDatabaseValue.CONTENT_PAGE_SIZE;
      case 'SONARR_ADD_SERIES_DEFAULT_MONITORED':
        return SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED;
      case 'SONARR_ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS':
        return SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS;
      case 'SONARR_ADD_SERIES_DEFAULT_SERIES_TYPE':
        return SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE;
      case 'SONARR_ADD_SERIES_DEFAULT_MONITOR_TYPE':
        return SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_TYPE;
      case 'SONARR_ADD_SERIES_DEFAULT_LANGUAGE_PROFILE':
        return SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE;
      case 'SONARR_ADD_SERIES_DEFAULT_QUALITY_PROFILE':
        return SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE;
      case 'SONARR_ADD_SERIES_DEFAULT_ROOT_FOLDER':
        return SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER;
      case 'SONARR_ADD_SERIES_DEFAULT_TAGS':
        return SonarrDatabaseValue.ADD_SERIES_DEFAULT_TAGS;
      case 'SONARR_DEFAULT_SORTING_SERIES':
        return SonarrDatabaseValue.DEFAULT_SORTING_SERIES;
      case 'SONARR_DEFAULT_SORTING_RELEASES':
        return SonarrDatabaseValue.DEFAULT_SORTING_RELEASES;
      case 'SONARR_DEFAULT_SORTING_SERIES_ASCENDING':
        return SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING;
      case 'SONARR_DEFAULT_SORTING_RELEASES_ASCENDING':
        return SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING;
      case 'SONARR_DEFAULT_FILTERING_SERIES':
        return SonarrDatabaseValue.DEFAULT_FILTERING_SERIES;
      case 'SONARR_DEFAULT_FILTERING_RELEASES':
        return SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES;
      case 'SONARR_REMOVE_SERIES_DELETE_FILES':
        return SonarrDatabaseValue.REMOVE_SERIES_DELETE_FILES;
      case 'SONARR_REMOVE_SERIES_EXCLUSION_LIST':
        return SonarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST;
      case 'SONARR_ADD_SERIES_SEARCH_FOR_MISSING':
        return SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_MISSING;
      case 'SONARR_ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET':
        return SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET;
      case 'SONARR_QUEUE_REMOVE_DOWNLOAD_CLIENT':
        return SonarrDatabaseValue.QUEUE_REMOVE_DOWNLOAD_CLIENT;
      case 'SONARR_QUEUE_ADD_BLOCKLIST':
        return SonarrDatabaseValue.QUEUE_ADD_BLOCKLIST;
      default:
        return null;
    }
  }
}

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
  QUEUE_REFRESH_RATE,
  QUEUE_REMOVE_DOWNLOAD_CLIENT,
  QUEUE_ADD_BLOCKLIST,
  CONTENT_PAGE_SIZE,
}

extension SonarrDatabaseValueExtension on SonarrDatabaseValue {
  String get key {
    switch (this) {
      case SonarrDatabaseValue.NAVIGATION_INDEX:
        return 'SONARR_NAVIGATION_INDEX';
      case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS:
        return 'SONARR_NAVIGATION_INDEX_SERIES_DETAILS';
      case SonarrDatabaseValue.NAVIGATION_INDEX_SEASON_DETAILS:
        return 'SONARR_NAVIGATION_INDEX_SEASON_DETAILS';
      case SonarrDatabaseValue.UPCOMING_FUTURE_DAYS:
        return 'SONARR_UPCOMING_FUTURE_DAYS';
      case SonarrDatabaseValue.QUEUE_REFRESH_RATE:
        return 'SONARR_QUEUE_REFRESH_RATE';
      case SonarrDatabaseValue.CONTENT_PAGE_SIZE:
        return 'SONARR_CONTENT_PAGE_SIZE';
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED:
        return 'SONARR_ADD_SERIES_DEFAULT_MONITORED';
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS:
        return 'SONARR_ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS';
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE:
        return 'SONARR_ADD_SERIES_DEFAULT_SERIES_TYPE';
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_TYPE:
        return 'SONARR_ADD_SERIES_DEFAULT_MONITOR_TYPE';
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE:
        return 'SONARR_ADD_SERIES_DEFAULT_LANGUAGE_PROFILE';
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE:
        return 'SONARR_ADD_SERIES_DEFAULT_QUALITY_PROFILE';
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER:
        return 'SONARR_ADD_SERIES_DEFAULT_ROOT_FOLDER';
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_TAGS:
        return 'SONARR_ADD_SERIES_DEFAULT_TAGS';
      case SonarrDatabaseValue.DEFAULT_SORTING_SERIES:
        return 'SONARR_DEFAULT_SORTING_SERIES';
      case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES:
        return 'SONARR_DEFAULT_SORTING_RELEASES';
      case SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING:
        return 'SONARR_DEFAULT_SORTING_SERIES_ASCENDING';
      case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING:
        return 'SONARR_DEFAULT_SORTING_RELEASES_ASCENDING';
      case SonarrDatabaseValue.DEFAULT_FILTERING_SERIES:
        return 'SONARR_DEFAULT_FILTERING_SERIES';
      case SonarrDatabaseValue.REMOVE_SERIES_DELETE_FILES:
        return 'SONARR_REMOVE_SERIES_DELETE_FILES';
      case SonarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST:
        return 'SONARR_REMOVE_SERIES_EXCLUSION_LIST';
      case SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET:
        return 'SONARR_ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET';
      case SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_MISSING:
        return 'SONARR_ADD_SERIES_SEARCH_FOR_MISSING';
      case SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
        return 'SONARR_DEFAULT_FILTERING_RELEASES';
      case SonarrDatabaseValue.QUEUE_REMOVE_DOWNLOAD_CLIENT:
        return 'SONARR_QUEUE_REMOVE_DOWNLOAD_CLIENT';
      case SonarrDatabaseValue.QUEUE_ADD_BLOCKLIST:
        return 'SONARR_QUEUE_ADD_BLOCKLIST';
    }
    throw Exception('key not found');
  }

  dynamic get data {
    final _box = Database.lunaSeaBox;
    switch (this) {
      case SonarrDatabaseValue.NAVIGATION_INDEX:
        return _box.get(this.key, defaultValue: 0);
      case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS:
        return _box.get(this.key, defaultValue: 0);
      case SonarrDatabaseValue.NAVIGATION_INDEX_SEASON_DETAILS:
        return _box.get(this.key, defaultValue: 0);
      case SonarrDatabaseValue.UPCOMING_FUTURE_DAYS:
        return _box.get(this.key, defaultValue: 7);
      case SonarrDatabaseValue.QUEUE_REFRESH_RATE:
        return _box.get(this.key, defaultValue: 15);
      case SonarrDatabaseValue.CONTENT_PAGE_SIZE:
        return _box.get(this.key, defaultValue: 25);
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED:
        return _box.get(this.key, defaultValue: true);
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS:
        return _box.get(this.key, defaultValue: true);
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE:
        return _box.get(this.key, defaultValue: 'standard');
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_TYPE:
        return _box.get(
          this.key,
          defaultValue: SonarrSeriesMonitorType.ALL.value,
        );
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE:
        return _box.get(this.key, defaultValue: null);
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE:
        return _box.get(this.key, defaultValue: null);
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER:
        return _box.get(this.key, defaultValue: null);
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_TAGS:
        return _box.get(this.key, defaultValue: []);
      case SonarrDatabaseValue.DEFAULT_SORTING_SERIES:
        return _box.get(
          this.key,
          defaultValue: SonarrSeriesSorting.ALPHABETICAL,
        );
      case SonarrDatabaseValue.DEFAULT_FILTERING_SERIES:
        return _box.get(this.key, defaultValue: SonarrSeriesFilter.ALL);
      case SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
        return _box.get(this.key, defaultValue: SonarrReleasesFilter.ALL);
      case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES:
        return _box.get(this.key, defaultValue: SonarrReleasesSorting.WEIGHT);
      case SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING:
        return _box.get(this.key, defaultValue: true);
      case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING:
        return _box.get(this.key, defaultValue: true);
      case SonarrDatabaseValue.REMOVE_SERIES_DELETE_FILES:
        return _box.get(this.key, defaultValue: false);
      case SonarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST:
        return _box.get(this.key, defaultValue: false);
      case SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET:
        return _box.get(this.key, defaultValue: false);
      case SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_MISSING:
        return _box.get(this.key, defaultValue: false);
      case SonarrDatabaseValue.QUEUE_REMOVE_DOWNLOAD_CLIENT:
        return _box.get(this.key, defaultValue: false);
      case SonarrDatabaseValue.QUEUE_ADD_BLOCKLIST:
        return _box.get(this.key, defaultValue: false);
    }
    throw Exception('data not found');
  }

  void put(dynamic value) {
    final box = Database.lunaSeaBox;
    switch (this) {
      case SonarrDatabaseValue.NAVIGATION_INDEX:
        if (value is int) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS:
        if (value is int) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.NAVIGATION_INDEX_SEASON_DETAILS:
        if (value is int) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED:
        if (value is bool) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS:
        if (value is bool) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_SERIES_TYPE:
        if (value is String) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_TYPE:
        if (value is String) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE:
        if (value is int) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE:
        if (value is int) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER:
        if (value is int) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.ADD_SERIES_DEFAULT_TAGS:
        if (value is List) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.DEFAULT_SORTING_SERIES:
        if (value is SonarrSeriesSorting) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.DEFAULT_FILTERING_SERIES:
        if (value is SonarrSeriesFilter) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
        if (value is SonarrReleasesFilter) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES:
        if (value is SonarrReleasesSorting) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING:
        if (value is bool) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING:
        if (value is bool) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.UPCOMING_FUTURE_DAYS:
        if (value is int) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.QUEUE_REFRESH_RATE:
        if (value is int) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.CONTENT_PAGE_SIZE:
        if (value is int) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.REMOVE_SERIES_DELETE_FILES:
        if (value is bool) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST:
        if (value is bool) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET:
        if (value is bool) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.ADD_SERIES_SEARCH_FOR_MISSING:
        if (value is bool) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.QUEUE_REMOVE_DOWNLOAD_CLIENT:
        if (value is bool) box.put(this.key, value);
        return;
      case SonarrDatabaseValue.QUEUE_ADD_BLOCKLIST:
        if (value is bool) box.put(this.key, value);
        return;
    }
    LunaLogger().warning(
      'SonarrDatabaseValueExtension',
      'put',
      'Attempted to enter data for invalid SonarrDatabaseValue: ${this?.toString() ?? 'null'}',
    );
  }

  ValueListenableBuilder listen({
    @required Widget Function(BuildContext, dynamic, Widget) builder,
  }) =>
      ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
        builder: builder,
      );
}
