import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'filter_series.g.dart';

@HiveType(typeId: 27, adapterName: 'SonarrSeriesFilterAdapter')
enum SonarrSeriesFilter {
  @HiveField(0)
  ALL,
  @HiveField(1)
  MONITORED,
  @HiveField(2)
  UNMONITORED,
  @HiveField(3)
  CONTINUING,
  @HiveField(4)
  ENDED,
  @HiveField(5)
  MISSING,
}

extension SonarrSeriesFilterExtension on SonarrSeriesFilter {
  String get key {
    switch (this) {
      case SonarrSeriesFilter.ALL:
        return 'all';
      case SonarrSeriesFilter.MONITORED:
        return 'monitored';
      case SonarrSeriesFilter.UNMONITORED:
        return 'unmonitored';
      case SonarrSeriesFilter.CONTINUING:
        return 'continuing';
      case SonarrSeriesFilter.ENDED:
        return 'ended';
      case SonarrSeriesFilter.MISSING:
        return 'missing';
    }
  }

  SonarrSeriesFilter? fromKey(String? key) {
    switch (key) {
      case 'all':
        return SonarrSeriesFilter.ALL;
      case 'monitored':
        return SonarrSeriesFilter.MONITORED;
      case 'unmonitored':
        return SonarrSeriesFilter.UNMONITORED;
      case 'continuing':
        return SonarrSeriesFilter.CONTINUING;
      case 'ended':
        return SonarrSeriesFilter.ENDED;
      case 'missing':
        return SonarrSeriesFilter.MISSING;
      default:
        return null;
    }
  }

  String get readable {
    switch (this) {
      case SonarrSeriesFilter.ALL:
        return 'sonarr.All'.tr();
      case SonarrSeriesFilter.MONITORED:
        return 'sonarr.Monitored'.tr();
      case SonarrSeriesFilter.UNMONITORED:
        return 'sonarr.Unmonitored'.tr();
      case SonarrSeriesFilter.CONTINUING:
        return 'sonarr.Continuing'.tr();
      case SonarrSeriesFilter.ENDED:
        return 'sonarr.Ended'.tr();
      case SonarrSeriesFilter.MISSING:
        return 'sonarr.Missing'.tr();
    }
  }

  List<SonarrSeries> filter(List<SonarrSeries> series) =>
      _Sorter().byType(series, this);
}

class _Sorter {
  List<SonarrSeries> byType(
    List<SonarrSeries> series,
    SonarrSeriesFilter type,
  ) {
    switch (type) {
      case SonarrSeriesFilter.ALL:
        return series;
      case SonarrSeriesFilter.MONITORED:
        return _monitored(series);
      case SonarrSeriesFilter.UNMONITORED:
        return _unmonitored(series);
      case SonarrSeriesFilter.CONTINUING:
        return _continuing(series);
      case SonarrSeriesFilter.ENDED:
        return _ended(series);
      case SonarrSeriesFilter.MISSING:
        return _missing(series);
    }
  }

  List<SonarrSeries> _monitored(List<SonarrSeries> series) =>
      series.where((s) => s.monitored!).toList();

  List<SonarrSeries> _unmonitored(List<SonarrSeries> series) =>
      series.where((s) => !s.monitored!).toList();

  List<SonarrSeries> _continuing(List<SonarrSeries> series) =>
      series.where((s) => !s.ended!).toList();

  List<SonarrSeries> _ended(List<SonarrSeries> series) =>
      series.where((s) => s.ended!).toList();

  List<SonarrSeries> _missing(List<SonarrSeries> series) {
    return series
        .where((s) =>
            (s.statistics?.episodeCount ?? 0) !=
            (s.statistics?.episodeFileCount ?? 0))
        .toList();
  }
}
