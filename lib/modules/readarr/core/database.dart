import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

enum ReadarrDatabaseValue {
  NAVIGATION_INDEX,
  NAVIGATION_INDEX_SERIES_DETAILS,
  NAVIGATION_INDEX_SEASON_DETAILS,
  ADD_SERIES_SEARCH_FOR_MISSING,
  ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET,
  ADD_SERIES_DEFAULT_MONITORED,
  ADD_SERIES_DEFAULT_MONITOR_TYPE,
  ADD_SERIES_DEFAULT_LANGUAGE_PROFILE,
  ADD_SERIES_DEFAULT_QUALITY_PROFILE,
  ADD_SERIES_DEFAULT_ROOT_FOLDER,
  ADD_SERIES_DEFAULT_TAGS,
  DEFAULT_VIEW_SERIES,
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
  REMOVE_BOOK_DELETE_FILES,
  REMOVE_BOOK_EXCLUSION_LIST,
}

class ReadarrDatabase extends LunaModuleDatabase {
  @override
  void registerAdapters() {
    // Active adapters
    Hive.registerAdapter(ReadarrAuthorSortingAdapter());
    Hive.registerAdapter(ReadarrAuthorFilterAdapter());
    Hive.registerAdapter(ReadarrReleasesSortingAdapter());
    Hive.registerAdapter(ReadarrReleasesFilterAdapter());
  }

  @override
  Map<String, dynamic> export() {
    Map<String, dynamic> data = {};
    for (ReadarrDatabaseValue value in ReadarrDatabaseValue.values) {
      switch (value) {
        // Non-primitive values
        case ReadarrDatabaseValue.DEFAULT_SORTING_SERIES:
          data[value.key] = (ReadarrDatabaseValue.DEFAULT_SORTING_SERIES.data
                  as ReadarrAuthorSorting)
              .key;
          break;
        case ReadarrDatabaseValue.DEFAULT_SORTING_RELEASES:
          data[value.key] = (ReadarrDatabaseValue.DEFAULT_SORTING_RELEASES.data
                  as ReadarrReleasesSorting)
              .key;
          break;
        case ReadarrDatabaseValue.DEFAULT_FILTERING_SERIES:
          data[value.key] = (ReadarrDatabaseValue.DEFAULT_FILTERING_SERIES.data
                  as ReadarrAuthorFilter)
              .key;
          break;
        case ReadarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
          data[value.key] = (ReadarrDatabaseValue
                  .DEFAULT_FILTERING_RELEASES.data as ReadarrReleasesFilter)
              .key;
          break;
        case ReadarrDatabaseValue.DEFAULT_VIEW_SERIES:
          data[value.key] = (ReadarrDatabaseValue.DEFAULT_VIEW_SERIES.data
                  as LunaListViewOption?)!
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
      ReadarrDatabaseValue? value = valueFromKey(key);
      if (value != null)
        switch (value) {
          // Non-primitive values
          case ReadarrDatabaseValue.DEFAULT_SORTING_SERIES:
            value.put(ReadarrAuthorSorting.ALPHABETICAL.fromKey(config[key]));
            break;
          case ReadarrDatabaseValue.DEFAULT_SORTING_RELEASES:
            value.put(ReadarrReleasesSorting.ALPHABETICAL.fromKey(config[key]));
            break;
          case ReadarrDatabaseValue.DEFAULT_FILTERING_SERIES:
            value.put(ReadarrAuthorFilter.ALL.fromKey(config[key]));
            break;
          case ReadarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
            value.put(ReadarrReleasesFilter.ALL.fromKey(config[key]));
            break;
          case ReadarrDatabaseValue.DEFAULT_VIEW_SERIES:
            value.put(LunaListViewOption.GRID_VIEW.fromKey(config[key]));
            break;
          // Primitive values
          default:
            value.put(config[key]);
            break;
        }
    }
  }

  @override
  ReadarrDatabaseValue? valueFromKey(String key) {
    for (ReadarrDatabaseValue value in ReadarrDatabaseValue.values) {
      if (value.key == key) return value;
    }
    return null;
  }
}

extension ReadarrDatabaseValueExtension on ReadarrDatabaseValue {
  String get key {
    return 'READARR_${this.name}';
  }

  dynamic get data {
    return Database.lunasea.box.get(this.key, defaultValue: this._defaultValue);
  }

  void put(dynamic value) {
    if (this._isTypeValid(value)) {
      Database.lunasea.box.put(this.key, value);
    } else {
      LunaLogger().warning(
        this.runtimeType.toString(),
        'put',
        'Invalid Database Insert (${this.key}, ${value.runtimeType})',
      );
    }
  }

  ValueListenableBuilder listen({
    Key? key,
    required Widget Function(BuildContext, dynamic, Widget?) builder,
  }) {
    return ValueListenableBuilder(
      key: key,
      valueListenable: Database.lunasea.box.listenable(keys: [this.key]),
      builder: builder,
    );
  }

  bool _isTypeValid(dynamic value) {
    switch (this) {
      case ReadarrDatabaseValue.NAVIGATION_INDEX:
        return value is int;
      case ReadarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS:
        return value is int;
      case ReadarrDatabaseValue.NAVIGATION_INDEX_SEASON_DETAILS:
        return value is int;
      case ReadarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED:
        return value is bool;
      case ReadarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_TYPE:
        return value is String;
      case ReadarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE:
        return value is int;
      case ReadarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE:
        return value is int;
      case ReadarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER:
        return value is int;
      case ReadarrDatabaseValue.ADD_SERIES_DEFAULT_TAGS:
        return value is List;
      case ReadarrDatabaseValue.DEFAULT_SORTING_SERIES:
        return value is ReadarrAuthorSorting;
      case ReadarrDatabaseValue.DEFAULT_FILTERING_SERIES:
        return value is ReadarrAuthorFilter;
      case ReadarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
        return value is ReadarrReleasesFilter;
      case ReadarrDatabaseValue.DEFAULT_SORTING_RELEASES:
        return value is ReadarrReleasesSorting;
      case ReadarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING:
        return value is bool;
      case ReadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING:
        return value is bool;
      case ReadarrDatabaseValue.UPCOMING_FUTURE_DAYS:
        return value is int;
      case ReadarrDatabaseValue.QUEUE_PAGE_SIZE:
        return value is int;
      case ReadarrDatabaseValue.QUEUE_REFRESH_RATE:
        return value is int;
      case ReadarrDatabaseValue.CONTENT_PAGE_SIZE:
        return value is int;
      case ReadarrDatabaseValue.REMOVE_SERIES_DELETE_FILES:
        return value is bool;
      case ReadarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST:
        return value is bool;
      case ReadarrDatabaseValue.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET:
        return value is bool;
      case ReadarrDatabaseValue.ADD_SERIES_SEARCH_FOR_MISSING:
        return value is bool;
      case ReadarrDatabaseValue.QUEUE_REMOVE_DOWNLOAD_CLIENT:
        return value is bool;
      case ReadarrDatabaseValue.QUEUE_ADD_BLOCKLIST:
        return value is bool;
      case ReadarrDatabaseValue.DEFAULT_VIEW_SERIES:
        return value is LunaListViewOption;
      case ReadarrDatabaseValue.REMOVE_BOOK_DELETE_FILES:
        return value is bool;
      case ReadarrDatabaseValue.REMOVE_BOOK_EXCLUSION_LIST:
        return value is bool;
    }
  }

  dynamic get _defaultValue {
    switch (this) {
      case ReadarrDatabaseValue.NAVIGATION_INDEX:
        return 0;
      case ReadarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS:
        return 0;
      case ReadarrDatabaseValue.NAVIGATION_INDEX_SEASON_DETAILS:
        return 0;
      case ReadarrDatabaseValue.UPCOMING_FUTURE_DAYS:
        return 7;
      case ReadarrDatabaseValue.QUEUE_PAGE_SIZE:
        return 50;
      case ReadarrDatabaseValue.QUEUE_REFRESH_RATE:
        return 15;
      case ReadarrDatabaseValue.CONTENT_PAGE_SIZE:
        return 25;
      case ReadarrDatabaseValue.ADD_SERIES_DEFAULT_MONITORED:
        return true;
      case ReadarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_TYPE:
        return ReadarrAuthorMonitorType.ALL.value;
      case ReadarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE:
        return null;
      case ReadarrDatabaseValue.ADD_SERIES_DEFAULT_QUALITY_PROFILE:
        return null;
      case ReadarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER:
        return null;
      case ReadarrDatabaseValue.ADD_SERIES_DEFAULT_TAGS:
        return [];
      case ReadarrDatabaseValue.DEFAULT_SORTING_SERIES:
        return ReadarrAuthorSorting.ALPHABETICAL;
      case ReadarrDatabaseValue.DEFAULT_FILTERING_SERIES:
        return ReadarrAuthorFilter.ALL;
      case ReadarrDatabaseValue.DEFAULT_FILTERING_RELEASES:
        return ReadarrReleasesFilter.ALL;
      case ReadarrDatabaseValue.DEFAULT_SORTING_RELEASES:
        return ReadarrReleasesSorting.WEIGHT;
      case ReadarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING:
        return true;
      case ReadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING:
        return true;
      case ReadarrDatabaseValue.REMOVE_SERIES_DELETE_FILES:
        return false;
      case ReadarrDatabaseValue.REMOVE_SERIES_EXCLUSION_LIST:
        return false;
      case ReadarrDatabaseValue.ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET:
        return false;
      case ReadarrDatabaseValue.ADD_SERIES_SEARCH_FOR_MISSING:
        return false;
      case ReadarrDatabaseValue.QUEUE_REMOVE_DOWNLOAD_CLIENT:
        return false;
      case ReadarrDatabaseValue.QUEUE_ADD_BLOCKLIST:
        return false;
      case ReadarrDatabaseValue.DEFAULT_VIEW_SERIES:
        return LunaListViewOption.BLOCK_VIEW;
      case ReadarrDatabaseValue.REMOVE_BOOK_DELETE_FILES:
        return false;
      case ReadarrDatabaseValue.REMOVE_BOOK_EXCLUSION_LIST:
        return false;
    }
  }
}
