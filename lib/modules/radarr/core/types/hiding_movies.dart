import 'package:lunasea/modules/radarr.dart';

enum RadarrMoviesHiding {
    ALL,
    MONITORED,
    UNMONITORED,
}

extension RadarrMoviesHidingExtension on RadarrMoviesHiding {
    String get value {
        switch(this) {
            case RadarrMoviesHiding.ALL: return 'all';
            case RadarrMoviesHiding.MONITORED: return 'monitored';
            case RadarrMoviesHiding.UNMONITORED: return 'unmonitored';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case RadarrMoviesHiding.ALL: return 'All';
            case RadarrMoviesHiding.MONITORED: return 'Monitored';
            case RadarrMoviesHiding.UNMONITORED: return 'Unmonitored';
        }
        throw Exception('readable not found');
    }

    List<RadarrMovie> filter(List<RadarrMovie> series) => _Sorter().byType(series, this);
}

class _Sorter {
    List<RadarrMovie> byType(
        List<RadarrMovie> series,
        RadarrMoviesHiding type,
    ) {
        switch(type) {
            case RadarrMoviesHiding.ALL: return series;
            case RadarrMoviesHiding.MONITORED: return _monitored(series);
            case RadarrMoviesHiding.UNMONITORED: return _unmonitored(series);
        }
        throw Exception('sorting type not found');
    }

    List<RadarrMovie> _monitored(List<RadarrMovie> series) => series.where((element) => element.monitored).toList();

    List<RadarrMovie> _unmonitored(List<RadarrMovie> series) => series.where((element) => !element.monitored).toList();
}
