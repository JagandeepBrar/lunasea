import 'package:lunasea/modules/sonarr.dart';

enum SonarrSeriesFilter {
    ALL,
    MONITORED,
    UNMONITORED,
}

extension SonarrSeriesFilterExtension on SonarrSeriesFilter {
    String get value {
        switch(this) {
            case SonarrSeriesFilter.ALL: return 'all';
            case SonarrSeriesFilter.MONITORED: return 'monitored';
            case SonarrSeriesFilter.UNMONITORED: return 'unmonitored';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case SonarrSeriesFilter.ALL: return 'All';
            case SonarrSeriesFilter.MONITORED: return 'Monitored';
            case SonarrSeriesFilter.UNMONITORED: return 'Unmonitored';
        }
        throw Exception('readable not found');
    }

    List<SonarrSeries> filter(List<SonarrSeries> series) => _Sorter().byType(series, this);
}

class _Sorter {
    List<SonarrSeries> byType(
        List<SonarrSeries> series,
        SonarrSeriesFilter type,
    ) {
        switch(type) {
            case SonarrSeriesFilter.ALL: return series;
            case SonarrSeriesFilter.MONITORED: return _monitored(series);
            case SonarrSeriesFilter.UNMONITORED: return _unmonitored(series);
        }
        throw Exception('sorting type not found');
    }

    List<SonarrSeries> _monitored(List<SonarrSeries> series) => series.where((element) => element.monitored).toList();

    List<SonarrSeries> _unmonitored(List<SonarrSeries> series) => series.where((element) => !element.monitored).toList();
}
