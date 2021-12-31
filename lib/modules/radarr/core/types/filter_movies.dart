import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

part 'filter_movies.g.dart';

@HiveType(typeId: 19, adapterName: 'RadarrMoviesFilterAdapter')
enum RadarrMoviesFilter {
  @HiveField(0)
  ALL,
  @HiveField(1)
  MONITORED,
  @HiveField(2)
  UNMONITORED,
  @HiveField(3)
  MISSING,
  @HiveField(4)
  WANTED,
  @HiveField(5)
  CUTOFF_UNMET,
}

extension RadarrMoviesFilterExtension on RadarrMoviesFilter {
  String get key {
    switch (this) {
      case RadarrMoviesFilter.ALL:
        return 'all';
      case RadarrMoviesFilter.MONITORED:
        return 'monitored';
      case RadarrMoviesFilter.UNMONITORED:
        return 'unmonitored';
      case RadarrMoviesFilter.MISSING:
        return 'missing';
      case RadarrMoviesFilter.WANTED:
        return 'wanted';
      case RadarrMoviesFilter.CUTOFF_UNMET:
        return 'cutoffunmet';
    }
  }

  String get readable {
    switch (this) {
      case RadarrMoviesFilter.ALL:
        return 'radarr.All'.tr();
      case RadarrMoviesFilter.MONITORED:
        return 'radarr.Monitored'.tr();
      case RadarrMoviesFilter.UNMONITORED:
        return 'radarr.Unmonitored'.tr();
      case RadarrMoviesFilter.MISSING:
        return 'radarr.Missing'.tr();
      case RadarrMoviesFilter.WANTED:
        return 'radarr.Wanted'.tr();
      case RadarrMoviesFilter.CUTOFF_UNMET:
        return 'radarr.CutoffUnmet'.tr();
    }
  }

  RadarrMoviesFilter? fromKey(String key) {
    switch (key) {
      case 'all':
        return RadarrMoviesFilter.ALL;
      case 'monitored':
        return RadarrMoviesFilter.MONITORED;
      case 'unmonitored':
        return RadarrMoviesFilter.UNMONITORED;
      case 'missing':
        return RadarrMoviesFilter.MISSING;
      case 'wanted':
        return RadarrMoviesFilter.WANTED;
      case 'cutoffunmet':
        return RadarrMoviesFilter.CUTOFF_UNMET;
      default:
        return null;
    }
  }

  List<RadarrMovie> filter(List<RadarrMovie> series) =>
      _Filterer().byType(series, this);
}

class _Filterer {
  List<RadarrMovie> byType(
    List<RadarrMovie> movies,
    RadarrMoviesFilter type,
  ) {
    switch (type) {
      case RadarrMoviesFilter.ALL:
        return movies;
      case RadarrMoviesFilter.MONITORED:
        return _monitored(movies);
      case RadarrMoviesFilter.UNMONITORED:
        return _unmonitored(movies);
      case RadarrMoviesFilter.MISSING:
        return _missing(movies);
      case RadarrMoviesFilter.WANTED:
        return _wanted(movies);
      case RadarrMoviesFilter.CUTOFF_UNMET:
        return _cutoffUnmet(movies);
    }
  }

  List<RadarrMovie> _monitored(List<RadarrMovie> movies) =>
      movies.where((movie) => movie.monitored!).toList();
  List<RadarrMovie> _unmonitored(List<RadarrMovie> movies) =>
      movies.where((movie) => !movie.monitored!).toList();
  List<RadarrMovie> _missing(List<RadarrMovie> movies) =>
      movies.where((movie) => !movie.hasFile! && movie.monitored!).toList();
  List<RadarrMovie> _wanted(List<RadarrMovie> movies) =>
      movies.where((movie) => !movie.hasFile! && movie.monitored!).toList();
  List<RadarrMovie> _cutoffUnmet(List<RadarrMovie> movies) => movies
      .where((movie) =>
          (movie.hasFile! && movie.movieFile!.qualityCutoffNotMet!) &&
          movie.monitored!)
      .toList();
}
