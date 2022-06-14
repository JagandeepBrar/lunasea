import 'package:lunasea/types/list_view_option.dart';
import 'package:lunasea/database/table.dart';
import 'package:lunasea/modules/radarr/core/types/filter_movies.dart';
import 'package:lunasea/modules/radarr/core/types/filter_releases.dart';
import 'package:lunasea/modules/radarr/core/types/sorting_movies.dart';
import 'package:lunasea/modules/radarr/core/types/sorting_releases.dart';
import 'package:lunasea/vendor.dart';

enum RadarrDatabase<T> with LunaTableMixin<T> {
  NAVIGATION_INDEX<int>(0),
  NAVIGATION_INDEX_MOVIE_DETAILS<int>(0),
  NAVIGATION_INDEX_ADD_MOVIE<int>(0),
  NAVIGATION_INDEX_SYSTEM_STATUS<int>(0),
  DEFAULT_VIEW_MOVIES<LunaListViewOption>(LunaListViewOption.BLOCK_VIEW),
  DEFAULT_SORTING_MOVIES<RadarrMoviesSorting>(RadarrMoviesSorting.ALPHABETICAL),
  DEFAULT_SORTING_MOVIES_ASCENDING<bool>(true),
  DEFAULT_FILTERING_MOVIES<RadarrMoviesFilter>(RadarrMoviesFilter.ALL),
  DEFAULT_SORTING_RELEASES<RadarrReleasesSorting>(RadarrReleasesSorting.WEIGHT),
  DEFAULT_SORTING_RELEASES_ASCENDING<bool>(true),
  DEFAULT_FILTERING_RELEASES<RadarrReleasesFilter>(RadarrReleasesFilter.ALL),
  ADD_MOVIE_DEFAULT_MONITORED_STATE<bool>(true),
  ADD_MOVIE_DEFAULT_ROOT_FOLDER_ID<int?>(null),
  ADD_MOVIE_DEFAULT_QUALITY_PROFILE_ID<int?>(null),
  ADD_MOVIE_DEFAULT_MINIMUM_AVAILABILITY_ID<String>('announced'),
  ADD_MOVIE_DEFAULT_TAGS<List>([]),
  ADD_MOVIE_SEARCH_FOR_MISSING<bool>(false),
  ADD_DISCOVER_USE_SUGGESTIONS<bool>(true),
  MANUAL_IMPORT_DEFAULT_MODE<String>('copy'),
  QUEUE_PAGE_SIZE<int>(50),
  QUEUE_REFRESH_RATE<int>(60),
  QUEUE_BLACKLIST<bool>(false),
  QUEUE_REMOVE_FROM_CLIENT<bool>(false),
  REMOVE_MOVIE_IMPORT_LIST<bool>(false),
  REMOVE_MOVIE_DELETE_FILES<bool>(false),
  CONTENT_PAGE_SIZE<int>(10);

  @override
  void register() {
    Hive.registerAdapter(RadarrMoviesSortingAdapter());
    Hive.registerAdapter(RadarrMoviesFilterAdapter());
    Hive.registerAdapter(RadarrReleasesSortingAdapter());
    Hive.registerAdapter(RadarrReleasesFilterAdapter());
  }

  @override
  LunaTable get table => LunaTable.radarr;

  @override
  final T fallback;

  const RadarrDatabase(this.fallback);

  @override
  dynamic export() {
    RadarrDatabase db = this;
    switch (db) {
      case RadarrDatabase.DEFAULT_SORTING_MOVIES:
        return RadarrDatabase.DEFAULT_SORTING_MOVIES.read().key;
      case RadarrDatabase.DEFAULT_SORTING_RELEASES:
        return RadarrDatabase.DEFAULT_SORTING_RELEASES.read().key;
      case RadarrDatabase.DEFAULT_FILTERING_MOVIES:
        return RadarrDatabase.DEFAULT_FILTERING_MOVIES.read().key;
      case RadarrDatabase.DEFAULT_FILTERING_RELEASES:
        return RadarrDatabase.DEFAULT_FILTERING_RELEASES.read().key;
      case RadarrDatabase.DEFAULT_VIEW_MOVIES:
        return RadarrDatabase.DEFAULT_VIEW_MOVIES.read().key;
      default:
        return super.export();
    }
  }

  @override
  void import(dynamic value) {
    RadarrDatabase db = this;
    dynamic result;

    switch (db) {
      case RadarrDatabase.DEFAULT_SORTING_MOVIES:
        result = RadarrMoviesSorting.ALPHABETICAL.fromKey(value.toString());
        break;
      case RadarrDatabase.DEFAULT_SORTING_RELEASES:
        result = RadarrReleasesSorting.ALPHABETICAL.fromKey(value.toString());
        break;
      case RadarrDatabase.DEFAULT_FILTERING_MOVIES:
        result = RadarrMoviesFilter.ALL.fromKey(value.toString());
        break;
      case RadarrDatabase.DEFAULT_FILTERING_RELEASES:
        result = RadarrReleasesFilter.ALL.fromKey(value.toString());
        break;
      case RadarrDatabase.DEFAULT_VIEW_MOVIES:
        result = LunaListViewOption.fromKey(value.toString());
        break;
      default:
        result = value;
        break;
    }

    return super.import(result);
  }
}
