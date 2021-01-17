import 'package:lunasea/modules/radarr.dart';

enum RadarrMoviesFilter {
    ALL,
    MONITORED,
    UNMONITORED,
}

extension RadarrMoviesFilterExtension on RadarrMoviesFilter {
    String get value {
        switch(this) {
            case RadarrMoviesFilter.ALL: return 'all';
            case RadarrMoviesFilter.MONITORED: return 'monitored';
            case RadarrMoviesFilter.UNMONITORED: return 'unmonitored';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case RadarrMoviesFilter.ALL: return 'All';
            case RadarrMoviesFilter.MONITORED: return 'Monitored';
            case RadarrMoviesFilter.UNMONITORED: return 'Unmonitored';
        }
        throw Exception('readable not found');
    }

    List<RadarrMovie> filter(List<RadarrMovie> series) => _Sorter().byType(series, this);
}

class _Sorter {
    List<RadarrMovie> byType(
        List<RadarrMovie> series,
        RadarrMoviesFilter type,
    ) {
        switch(type) {
            case RadarrMoviesFilter.ALL: return series;
            case RadarrMoviesFilter.MONITORED: return _monitored(series);
            case RadarrMoviesFilter.UNMONITORED: return _unmonitored(series);
        }
        throw Exception('sorting type not found');
    }

    List<RadarrMovie> _monitored(List<RadarrMovie> series) => series.where((element) => element.monitored).toList();

    List<RadarrMovie> _unmonitored(List<RadarrMovie> series) => series.where((element) => !element.monitored).toList();
}
