import 'package:lunasea/database/table.dart';
import 'package:lunasea/modules/sonarr/core/types/filter_releases.dart';
import 'package:lunasea/modules/sonarr/core/types/filter_series.dart';
import 'package:lunasea/modules/sonarr/core/types/monitor_status.dart';
import 'package:lunasea/modules/sonarr/core/types/sorting_releases.dart';
import 'package:lunasea/modules/sonarr/core/types/sorting_series.dart';
import 'package:lunasea/types/list_view_option.dart';
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
  LunaTable get table => LunaTable.sonarr;

  @override
  final T fallback;

  const SonarrDatabase(this.fallback);

  @override
  void register() {
    Hive.registerAdapter(SonarrMonitorStatusAdapter());
    Hive.registerAdapter(SonarrSeriesSortingAdapter());
    Hive.registerAdapter(SonarrSeriesFilterAdapter());
    Hive.registerAdapter(SonarrReleasesSortingAdapter());
    Hive.registerAdapter(SonarrReleasesFilterAdapter());
  }

  @override
  dynamic export() {
    SonarrDatabase db = this;
    switch (db) {
      case SonarrDatabase.DEFAULT_SORTING_SERIES:
        return SonarrDatabase.DEFAULT_SORTING_SERIES.read().key;
      case SonarrDatabase.DEFAULT_SORTING_RELEASES:
        return SonarrDatabase.DEFAULT_SORTING_RELEASES.read().key;
      case SonarrDatabase.DEFAULT_FILTERING_SERIES:
        return SonarrDatabase.DEFAULT_FILTERING_SERIES.read().key;
      case SonarrDatabase.DEFAULT_FILTERING_RELEASES:
        return SonarrDatabase.DEFAULT_FILTERING_RELEASES.read().key;
      case SonarrDatabase.DEFAULT_VIEW_SERIES:
        return SonarrDatabase.DEFAULT_VIEW_SERIES.read().key;
      default:
        return super.export();
    }
  }

  @override
  void import(dynamic value) {
    SonarrDatabase db = this;
    dynamic result;

    switch (db) {
      case SonarrDatabase.DEFAULT_SORTING_SERIES:
        result = SonarrSeriesSorting.ALPHABETICAL.fromKey(value.toString());
        break;
      case SonarrDatabase.DEFAULT_SORTING_RELEASES:
        result = SonarrReleasesSorting.ALPHABETICAL.fromKey(value.toString());
        break;
      case SonarrDatabase.DEFAULT_FILTERING_SERIES:
        result = SonarrSeriesFilter.ALL.fromKey(value.toString());
        break;
      case SonarrDatabase.DEFAULT_FILTERING_RELEASES:
        result = SonarrReleasesFilter.ALL.fromKey(value.toString());
        break;
      case SonarrDatabase.DEFAULT_VIEW_SERIES:
        result = LunaListViewOption.fromKey(value.toString());
        break;
      default:
        result = value;
        break;
    }

    return super.import(result);
  }
}
