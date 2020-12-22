import 'package:lunasea/modules/sonarr.dart';

enum SonarrSeriesHiding {
    ALL,
    MONITORED,
    UNMONITORED,
}

extension SonarrSeriesHidingExtension on SonarrSeriesHiding {
    String get value {
        switch(this) {
            case SonarrSeriesHiding.ALL: return 'all';
            case SonarrSeriesHiding.MONITORED: return 'monitored';
            case SonarrSeriesHiding.UNMONITORED: return 'unmonitored';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case SonarrSeriesHiding.ALL: return 'All';
            case SonarrSeriesHiding.MONITORED: return 'Monitored';
            case SonarrSeriesHiding.UNMONITORED: return 'Unmonitored';
        }
        throw Exception('readable not found');
    }

    List<SonarrSeries> filter(List<SonarrSeries> series) => _Sorter().byType(series, this);
}

class _Sorter {
    List<SonarrSeries> byType(
        List<SonarrSeries> series,
        SonarrSeriesHiding type,
    ) {
        switch(type) {
            case SonarrSeriesHiding.ALL: return series;
            case SonarrSeriesHiding.MONITORED: return _monitored(series);
            case SonarrSeriesHiding.UNMONITORED: return _unmonitored(series);
        }
        throw Exception('sorting type not found');
    }

    List<SonarrSeries> _monitored(List<SonarrSeries> series) => series.where((element) => element.monitored).toList();

    List<SonarrSeries> _unmonitored(List<SonarrSeries> series) => series.where((element) => !element.monitored).toList();
}
