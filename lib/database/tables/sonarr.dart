import 'package:lunasea/core/models/types/list_view_option.dart';
import 'package:lunasea/database/table.dart';
import 'package:lunasea/modules/sonarr/core/deprecated.dart';
import 'package:lunasea/modules/sonarr/core/types/filter_releases.dart';
import 'package:lunasea/modules/sonarr/core/types/filter_series.dart';
import 'package:lunasea/modules/sonarr/core/types/monitor_status.dart';
import 'package:lunasea/modules/sonarr/core/types/sorting_releases.dart';
import 'package:lunasea/modules/sonarr/core/types/sorting_series.dart';
import 'package:lunasea/vendor.dart';

enum SonarrDatabase<T> with LunaTableMixin<T> {
  NAVIGATION_INDEX<int>(0),
  NAVIGATION_INDEX_SERIES_DETAILS<int>(0),
  NAVIGATION_INDEX_SEASON_DETAILS<int>(0),
  ADD_SERIES_SEARCH_FOR_MISSING<bool>(false),
  ADD_SERIES_SEARCH_FOR_CUTOFF_UNMET<bool>(false),
  ADD_SERIES_DEFAULT_MONITORED<bool>(true),
  ADD_SERIES_DEFAULT_USE_SEASON_FOLDERS<bool>(true),
  ADD_SERIES_DEFAULT_SERIES_TYPE<String>('standard'),
  ADD_SERIES_DEFAULT_MONITOR_TYPE<String>('all'),
  ADD_SERIES_DEFAULT_LANGUAGE_PROFILE<int?>(null),
  ADD_SERIES_DEFAULT_QUALITY_PROFILE<int?>(null),
  ADD_SERIES_DEFAULT_ROOT_FOLDER<int?>(null),
  ADD_SERIES_DEFAULT_TAGS<List>([]),
  DEFAULT_VIEW_SERIES<LunaListViewOption>(LunaListViewOption.BLOCK_VIEW),
  DEFAULT_FILTERING_SERIES<SonarrSeriesFilter>(SonarrSeriesFilter.ALL),
  DEFAULT_FILTERING_RELEASES<SonarrReleasesFilter>(SonarrReleasesFilter.ALL),
  DEFAULT_SORTING_SERIES<SonarrSeriesSorting>(SonarrSeriesSorting.ALPHABETICAL),
  DEFAULT_SORTING_RELEASES<SonarrReleasesSorting>(SonarrReleasesSorting.WEIGHT),
  DEFAULT_SORTING_SERIES_ASCENDING<bool>(true),
  DEFAULT_SORTING_RELEASES_ASCENDING<bool>(true),
  REMOVE_SERIES_DELETE_FILES<bool>(false),
  REMOVE_SERIES_EXCLUSION_LIST<bool>(false),
  UPCOMING_FUTURE_DAYS<int>(7),
  QUEUE_PAGE_SIZE<int>(50),
  QUEUE_REFRESH_RATE<int>(15),
  QUEUE_REMOVE_DOWNLOAD_CLIENT<bool>(false),
  QUEUE_ADD_BLOCKLIST<bool>(false),
  CONTENT_PAGE_SIZE<int>(10);

  @override
  String get table => TABLE_SONARR_KEY;

  @override
  final T defaultValue;

  const SonarrDatabase(this.defaultValue);

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
  dynamic export() {
    if (this == SonarrDatabase.DEFAULT_SORTING_SERIES) {
      return SonarrDatabase.DEFAULT_SORTING_SERIES.read().key;
    }
    if (this == SonarrDatabase.DEFAULT_SORTING_RELEASES) {
      return SonarrDatabase.DEFAULT_SORTING_RELEASES.read().key;
    }
    if (this == SonarrDatabase.DEFAULT_FILTERING_SERIES) {
      return SonarrDatabase.DEFAULT_FILTERING_SERIES.read().key;
    }
    if (this == SonarrDatabase.DEFAULT_FILTERING_RELEASES) {
      return SonarrDatabase.DEFAULT_FILTERING_RELEASES.read().key;
    }
    if (this == SonarrDatabase.DEFAULT_VIEW_SERIES) {
      return SonarrDatabase.DEFAULT_VIEW_SERIES.read().key;
    }
    return super.export();
  }

  @override
  void import(dynamic value) {
    if (this == SonarrDatabase.DEFAULT_SORTING_SERIES) {
      final item = SonarrSeriesSorting.ALPHABETICAL.fromKey(value.toString());
      if (item != null) update(item as T);
      return;
    }
    if (this == SonarrDatabase.DEFAULT_SORTING_RELEASES) {
      final item = SonarrReleasesSorting.ALPHABETICAL.fromKey(value.toString());
      if (item != null) update(item as T);
      return;
    }
    if (this == SonarrDatabase.DEFAULT_FILTERING_SERIES) {
      final item = SonarrSeriesFilter.ALL.fromKey(value.toString());
      if (item != null) update(item as T);
      return;
    }
    if (this == SonarrDatabase.DEFAULT_FILTERING_RELEASES) {
      final item = SonarrReleasesFilter.ALL.fromKey(value.toString());
      if (item != null) update(item as T);
      return;
    }
    if (this == SonarrDatabase.DEFAULT_VIEW_SERIES) {
      final item = LunaListViewOption.fromKey(value.toString());
      if (item != null) update(item as T);
      return;
    }
    return super.import(value);
  }
}
