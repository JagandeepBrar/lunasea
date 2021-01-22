import 'package:lunasea/modules/radarr.dart';

enum RadarrMoviesFilter {
    ALL,
    MONITORED,
    UNMONITORED,
    MISSING,
}

extension RadarrMoviesFilterExtension on RadarrMoviesFilter {
    String get value {
        switch(this) {
            case RadarrMoviesFilter.ALL: return 'all';
            case RadarrMoviesFilter.MONITORED: return 'monitored';
            case RadarrMoviesFilter.UNMONITORED: return 'unmonitored';
            case RadarrMoviesFilter.MISSING: return 'missing';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case RadarrMoviesFilter.ALL: return 'All';
            case RadarrMoviesFilter.MONITORED: return 'Monitored';
            case RadarrMoviesFilter.UNMONITORED: return 'Unmonitored';
            case RadarrMoviesFilter.MISSING: return 'Missing';
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
        }
        throw Exception('sorting type not found');
    }

    List<RadarrMovie> _monitored(List<RadarrMovie> movies) => movies.where((element) => element.monitored).toList();

    List<RadarrMovie> _unmonitored(List<RadarrMovie> movies) => movies.where((element) => !element.monitored).toList();

    List<RadarrMovie> _missing(List<RadarrMovie> movies) => movies.where((element) => !element.hasFile).toList();
}
