import 'package:lunasea/modules/radarr.dart';

enum RadarrMoviesFilter {
    ALL,
    MONITORED,
    UNMONITORED,
    MISSING,
    WANTED,
    CUTOFF_UNMET,
}

extension RadarrMoviesFilterExtension on RadarrMoviesFilter {
    String get value {
        switch(this) {
            case RadarrMoviesFilter.ALL: return 'all';
            case RadarrMoviesFilter.MONITORED: return 'monitored';
            case RadarrMoviesFilter.UNMONITORED: return 'unmonitored';
            case RadarrMoviesFilter.MISSING: return 'missing';
            case RadarrMoviesFilter.WANTED: return 'wanted';
            case RadarrMoviesFilter.CUTOFF_UNMET: return 'cutoffunmet';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case RadarrMoviesFilter.ALL: return 'All';
            case RadarrMoviesFilter.MONITORED: return 'Monitored';
            case RadarrMoviesFilter.UNMONITORED: return 'Unmonitored';
            case RadarrMoviesFilter.MISSING: return 'Missing';
            case RadarrMoviesFilter.WANTED: return 'Wanted';
            case RadarrMoviesFilter.CUTOFF_UNMET: return 'Cutoff Unmet';
        }
        throw Exception('readable not found');
    }

    List<RadarrMovie> filter(List<RadarrMovie> series) => _Sorter().byType(series, this);
}

class _Sorter {
    List<RadarrMovie> byType(
        List<RadarrMovie> movies,
        RadarrMoviesFilter type,
    ) {
        switch(type) {
            case RadarrMoviesFilter.ALL: return movies;
            case RadarrMoviesFilter.MONITORED: return _monitored(movies);
            case RadarrMoviesFilter.UNMONITORED: return _unmonitored(movies);
            case RadarrMoviesFilter.MISSING: return _missing(movies);
            case RadarrMoviesFilter.WANTED: return _wanted(movies);
            case RadarrMoviesFilter.CUTOFF_UNMET: return _cutoffUnmet(movies);
        }
        throw Exception('sorting type not found');
    }

    List<RadarrMovie> _monitored(List<RadarrMovie> movies) => movies.where((movie) => movie.monitored).toList();

    List<RadarrMovie> _unmonitored(List<RadarrMovie> movies) => movies.where((movie) => !movie.monitored).toList();

    List<RadarrMovie> _missing(List<RadarrMovie> movies) => movies.where((movie) => !movie.hasFile).toList();

    List<RadarrMovie> _wanted(List<RadarrMovie> movies) => movies.where((movie) => !movie.hasFile || movie.movieFile.qualityCutoffNotMet).toList();

    List<RadarrMovie> _cutoffUnmet(List<RadarrMovie> movies) => movies.where((movie) => movie.hasFile && movie.movieFile.qualityCutoffNotMet).toList();
}
