import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'sorting_series.g.dart';

@HiveType(typeId: 16, adapterName: 'SonarrSeriesSortingAdapter')
enum SonarrSeriesSorting {
  @HiveField(0)
  ALPHABETICAL,
  @HiveField(1)
  DATE_ADDED,
  @HiveField(2)
  EPISODES,
  @HiveField(3)
  NETWORK,
  @HiveField(4)
  NEXT_AIRING,
  @HiveField(8)
  PREVIOUS_AIRING,
  @HiveField(5)
  QUALITY,
  @HiveField(6)
  SIZE,
  @HiveField(7)
  TYPE,
}

extension SonarrSeriesSortingExtension on SonarrSeriesSorting {
  String get key {
    switch (this) {
      case SonarrSeriesSorting.ALPHABETICAL:
        return 'abc';
      case SonarrSeriesSorting.DATE_ADDED:
        return 'date_added';
      case SonarrSeriesSorting.EPISODES:
        return 'episodes';
      case SonarrSeriesSorting.SIZE:
        return 'size';
      case SonarrSeriesSorting.TYPE:
        return 'type';
      case SonarrSeriesSorting.NETWORK:
        return 'network';
      case SonarrSeriesSorting.QUALITY:
        return 'quality';
      case SonarrSeriesSorting.NEXT_AIRING:
        return 'next_airing';
      case SonarrSeriesSorting.PREVIOUS_AIRING:
        return 'previous_airing';
    }
  }

  String get readable {
    switch (this) {
      case SonarrSeriesSorting.ALPHABETICAL:
        return 'Alphabetical';
      case SonarrSeriesSorting.DATE_ADDED:
        return 'Date Added';
      case SonarrSeriesSorting.EPISODES:
        return 'Episodes';
      case SonarrSeriesSorting.NETWORK:
        return 'Network';
      case SonarrSeriesSorting.SIZE:
        return 'Size';
      case SonarrSeriesSorting.TYPE:
        return 'Type';
      case SonarrSeriesSorting.QUALITY:
        return 'Quality Profile';
      case SonarrSeriesSorting.NEXT_AIRING:
        return 'Next Airing';
      case SonarrSeriesSorting.PREVIOUS_AIRING:
        return 'Previous Airing';
    }
  }

  String value(SonarrSeries series, SonarrQualityProfile? profile) {
    switch (this) {
      case SonarrSeriesSorting.ALPHABETICAL:
        return series.lunaEpisodeCount;
      case SonarrSeriesSorting.DATE_ADDED:
        return series.lunaDateAddedShort;
      case SonarrSeriesSorting.EPISODES:
        return series.lunaEpisodeCount;
      case SonarrSeriesSorting.NETWORK:
        return series.lunaNetwork;
      case SonarrSeriesSorting.NEXT_AIRING:
        return series.lunaNextAiring(true);
      case SonarrSeriesSorting.PREVIOUS_AIRING:
        return series.lunaPreviousAiring(true);
      case SonarrSeriesSorting.QUALITY:
        return profile?.name ?? LunaUI.TEXT_EMDASH;
      case SonarrSeriesSorting.SIZE:
        return series.lunaSizeOnDisk;
      case SonarrSeriesSorting.TYPE:
        return series.lunaSeriesType;
    }
  }

  SonarrSeriesSorting? fromKey(String? key) {
    switch (key) {
      case 'abc':
        return SonarrSeriesSorting.ALPHABETICAL;
      case 'date_added':
        return SonarrSeriesSorting.DATE_ADDED;
      case 'episodes':
        return SonarrSeriesSorting.EPISODES;
      case 'size':
        return SonarrSeriesSorting.SIZE;
      case 'type':
        return SonarrSeriesSorting.TYPE;
      case 'network':
        return SonarrSeriesSorting.NETWORK;
      case 'quality':
        return SonarrSeriesSorting.QUALITY;
      case 'next_airing':
        return SonarrSeriesSorting.NEXT_AIRING;
      case 'previous_airing':
        return SonarrSeriesSorting.PREVIOUS_AIRING;
      default:
        return null;
    }
  }

  List<SonarrSeries> sort(List<SonarrSeries> data, bool ascending) =>
      _Sorter().byType(data, this, ascending);
}

class _Sorter {
  List<SonarrSeries> byType(
    List<SonarrSeries> data,
    SonarrSeriesSorting type,
    bool ascending,
  ) {
    switch (type) {
      case SonarrSeriesSorting.DATE_ADDED:
        return _dateAdded(data, ascending);
      case SonarrSeriesSorting.EPISODES:
        return _episodes(data, ascending);
      case SonarrSeriesSorting.NETWORK:
        return _network(data, ascending);
      case SonarrSeriesSorting.NEXT_AIRING:
        return _nextAiring(data, ascending);
      case SonarrSeriesSorting.PREVIOUS_AIRING:
        return _previousAiring(data, ascending);
      case SonarrSeriesSorting.SIZE:
        return _size(data, ascending);
      case SonarrSeriesSorting.TYPE:
        return _type(data, ascending);
      case SonarrSeriesSorting.ALPHABETICAL:
        return _alphabetical(data, ascending);
      case SonarrSeriesSorting.QUALITY:
        return _quality(data, ascending);
    }
  }

  List<SonarrSeries> _alphabetical(List<SonarrSeries> series, bool ascending) {
    ascending
        ? series.sort((a, b) =>
            a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase()))
        : series.sort((a, b) =>
            b.sortTitle!.toLowerCase().compareTo(a.sortTitle!.toLowerCase()));
    return series;
  }

  List<SonarrSeries> _dateAdded(List<SonarrSeries> series, bool ascending) {
    series.sort((a, b) {
      if (ascending) {
        if (a.added == null) return 1;
        if (b.added == null) return -1;
        int _comparison = a.added!.compareTo(b.added!);
        return _comparison == 0
            ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
            : _comparison;
      } else {
        if (b.added == null) return -1;
        if (a.added == null) return 1;
        int _comparison = b.added!.compareTo(a.added!);
        return _comparison == 0
            ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
            : _comparison;
      }
    });
    return series;
  }

  List<SonarrSeries> _episodes(List<SonarrSeries> series, bool ascending) {
    series.sort((a, b) {
      int _comparison = ascending
          ? a.lunaPercentageComplete.compareTo(b.lunaPercentageComplete)
          : b.lunaPercentageComplete.compareTo(a.lunaPercentageComplete);
      return _comparison == 0
          ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
          : _comparison;
    });
    return series;
  }

  List<SonarrSeries> _network(List<SonarrSeries> series, bool ascending) {
    series.sort((a, b) {
      int _comparison = ascending
          ? (a.network ?? LunaUI.TEXT_EMDASH)
              .compareTo((b.network ?? LunaUI.TEXT_EMDASH))
          : (b.network ?? LunaUI.TEXT_EMDASH)
              .compareTo((a.network ?? LunaUI.TEXT_EMDASH));
      return _comparison == 0
          ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
          : _comparison;
    });
    return series;
  }

  List<SonarrSeries> _nextAiring(List<SonarrSeries> series, bool ascending) {
    series.sort((a, b) {
      if (a.nextAiring == null && b.nextAiring == null) {
        if (a.status == 'ended' && b.status != 'ended') return 1;
        if (b.status == 'ended' && a.status != 'ended') return -1;
        return a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase());
      }
      if (ascending) {
        if (a.nextAiring == null) return 1;
        if (b.nextAiring == null) return -1;
        int _comparison = a.nextAiring!.compareTo(b.nextAiring!);
        return _comparison == 0
            ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
            : _comparison;
      } else {
        if (b.nextAiring == null) return -1;
        if (a.nextAiring == null) return 1;
        int _comparison = b.nextAiring!.compareTo(a.nextAiring!);
        return _comparison == 0
            ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
            : _comparison;
      }
    });
    return series;
  }

  List<SonarrSeries> _previousAiring(
      List<SonarrSeries> series, bool ascending) {
    series.sort((a, b) {
      if (a.previousAiring == null && b.previousAiring == null) {
        if (a.status == 'ended' && b.status != 'ended') return 1;
        if (b.status == 'ended' && a.status != 'ended') return -1;
        return a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase());
      }
      if (ascending) {
        if (a.previousAiring == null) return 1;
        if (b.previousAiring == null) return -1;
        int _comparison = a.previousAiring!.compareTo(b.previousAiring!);
        return _comparison == 0
            ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
            : _comparison;
      } else {
        if (b.previousAiring == null) return -1;
        if (a.previousAiring == null) return 1;
        int _comparison = b.previousAiring!.compareTo(a.previousAiring!);
        return _comparison == 0
            ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
            : _comparison;
      }
    });
    return series;
  }

  List<SonarrSeries> _quality(List<SonarrSeries> series, bool ascending) {
    series.sort((a, b) {
      int _comparison = ascending
          ? (a.qualityProfileId ?? 0).compareTo(b.qualityProfileId ?? 0)
          : (b.qualityProfileId ?? 0).compareTo(a.qualityProfileId ?? 0);
      return _comparison == 0
          ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
          : _comparison;
    });
    return series;
  }

  List<SonarrSeries> _size(List<SonarrSeries> series, bool ascending) {
    series.sort((a, b) {
      int _comparison = ascending
          ? (a.statistics?.sizeOnDisk ?? 0)
              .compareTo(b.statistics?.sizeOnDisk ?? 0)
          : (b.statistics?.sizeOnDisk ?? 0)
              .compareTo(a.statistics?.sizeOnDisk ?? 0);
      return _comparison == 0
          ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
          : _comparison;
    });
    return series;
  }

  List<SonarrSeries> _type(List<SonarrSeries> series, bool ascending) {
    List<SonarrSeries> _anime = series
        .where((element) => element.seriesType == SonarrSeriesType.ANIME)
        .toList();
    _anime.sort((a, b) =>
        a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase()));
    List<SonarrSeries> _daily = series
        .where((element) => element.seriesType == SonarrSeriesType.DAILY)
        .toList();
    _daily.sort((a, b) =>
        a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase()));
    List<SonarrSeries> _stand = series
        .where((element) => element.seriesType == SonarrSeriesType.STANDARD)
        .toList();
    _stand.sort((a, b) =>
        a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase()));
    return ascending
        ? [..._anime, ..._daily, ..._stand]
        : [..._stand, ..._daily, ..._anime];
  }
}
