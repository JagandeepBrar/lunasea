import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

part 'filter_author.g.dart';

@HiveType(typeId: 31, adapterName: 'ReadarrAuthorFilterAdapter')
enum ReadarrAuthorFilter {
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

extension ReadarrAuthorFilterExtension on ReadarrAuthorFilter {
  String get key {
    switch (this) {
      case ReadarrAuthorFilter.ALL:
        return 'all';
      case ReadarrAuthorFilter.MONITORED:
        return 'monitored';
      case ReadarrAuthorFilter.UNMONITORED:
        return 'unmonitored';
      case ReadarrAuthorFilter.CONTINUING:
        return 'continuing';
      case ReadarrAuthorFilter.ENDED:
        return 'ended';
      case ReadarrAuthorFilter.MISSING:
        return 'missing';
    }
  }

  ReadarrAuthorFilter? fromKey(String? key) {
    switch (key) {
      case 'all':
        return ReadarrAuthorFilter.ALL;
      case 'monitored':
        return ReadarrAuthorFilter.MONITORED;
      case 'unmonitored':
        return ReadarrAuthorFilter.UNMONITORED;
      case 'continuing':
        return ReadarrAuthorFilter.CONTINUING;
      case 'ended':
        return ReadarrAuthorFilter.ENDED;
      case 'missing':
        return ReadarrAuthorFilter.MISSING;
      default:
        return null;
    }
  }

  String get readable {
    switch (this) {
      case ReadarrAuthorFilter.ALL:
        return 'readarr.All'.tr();
      case ReadarrAuthorFilter.MONITORED:
        return 'readarr.Monitored'.tr();
      case ReadarrAuthorFilter.UNMONITORED:
        return 'readarr.Unmonitored'.tr();
      case ReadarrAuthorFilter.CONTINUING:
        return 'readarr.Continuing'.tr();
      case ReadarrAuthorFilter.ENDED:
        return 'readarr.Ended'.tr();
      case ReadarrAuthorFilter.MISSING:
        return 'readarr.Missing'.tr();
    }
  }

  List<ReadarrAuthor> filter(List<ReadarrAuthor> series) =>
      _Sorter().byType(series, this);
}

class _Sorter {
  List<ReadarrAuthor> byType(
    List<ReadarrAuthor> series,
    ReadarrAuthorFilter type,
  ) {
    switch (type) {
      case ReadarrAuthorFilter.ALL:
        return series;
      case ReadarrAuthorFilter.MONITORED:
        return _monitored(series);
      case ReadarrAuthorFilter.UNMONITORED:
        return _unmonitored(series);
      case ReadarrAuthorFilter.CONTINUING:
        return _continuing(series);
      case ReadarrAuthorFilter.ENDED:
        return _ended(series);
      case ReadarrAuthorFilter.MISSING:
        return _missing(series);
    }
  }

  List<ReadarrAuthor> _monitored(List<ReadarrAuthor> series) =>
      series.where((s) => s.monitored!).toList();

  List<ReadarrAuthor> _unmonitored(List<ReadarrAuthor> series) =>
      series.where((s) => !s.monitored!).toList();

  List<ReadarrAuthor> _continuing(List<ReadarrAuthor> series) =>
      series.where((s) => !s.ended!).toList();

  List<ReadarrAuthor> _ended(List<ReadarrAuthor> series) =>
      series.where((s) => s.ended!).toList();

  List<ReadarrAuthor> _missing(List<ReadarrAuthor> series) {
    return series
        .where((s) =>
            (s.statistics?.episodeCount ?? 0) !=
            (s.statistics?.episodeFileCount ?? 0))
        .toList();
  }
}
