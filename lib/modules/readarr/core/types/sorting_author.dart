import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

part 'sorting_author.g.dart';

@HiveType(typeId: 33, adapterName: 'ReadarrAuthorSortingAdapter')
enum ReadarrAuthorSorting {
  @HiveField(0)
  ALPHABETICAL,
  @HiveField(1)
  DATE_ADDED,
  @HiveField(2)
  EPISODES,
  @HiveField(3)
  QUALITY,
  @HiveField(4)
  SIZE,
}

extension ReadarrAuthorSortingExtension on ReadarrAuthorSorting {
  String get key {
    switch (this) {
      case ReadarrAuthorSorting.ALPHABETICAL:
        return 'abc';
      case ReadarrAuthorSorting.DATE_ADDED:
        return 'date_added';
      case ReadarrAuthorSorting.EPISODES:
        return 'episodes';
      case ReadarrAuthorSorting.SIZE:
        return 'size';
      case ReadarrAuthorSorting.QUALITY:
        return 'quality';
    }
  }

  String get readable {
    switch (this) {
      case ReadarrAuthorSorting.ALPHABETICAL:
        return 'Alphabetical';
      case ReadarrAuthorSorting.DATE_ADDED:
        return 'Date Added';
      case ReadarrAuthorSorting.EPISODES:
        return 'Episodes';
      case ReadarrAuthorSorting.SIZE:
        return 'Size';
      case ReadarrAuthorSorting.QUALITY:
        return 'Quality Profile';
    }
  }

  String value(ReadarrAuthor series, ReadarrQualityProfile? profile) {
    switch (this) {
      case ReadarrAuthorSorting.ALPHABETICAL:
        return series.lunaEpisodeCount;
      case ReadarrAuthorSorting.DATE_ADDED:
        return series.lunaDateAddedShort;
      case ReadarrAuthorSorting.EPISODES:
        return series.lunaEpisodeCount;
      case ReadarrAuthorSorting.QUALITY:
        return profile?.name ?? LunaUI.TEXT_EMDASH;
      case ReadarrAuthorSorting.SIZE:
        return series.lunaSizeOnDisk;
    }
  }

  ReadarrAuthorSorting? fromKey(String? key) {
    switch (key) {
      case 'abc':
        return ReadarrAuthorSorting.ALPHABETICAL;
      case 'date_added':
        return ReadarrAuthorSorting.DATE_ADDED;
      case 'episodes':
        return ReadarrAuthorSorting.EPISODES;
      case 'size':
        return ReadarrAuthorSorting.SIZE;
      case 'quality':
        return ReadarrAuthorSorting.QUALITY;
      default:
        return null;
    }
  }

  List<ReadarrAuthor> sort(List<ReadarrAuthor> data, bool ascending) =>
      _Sorter().byType(data, this, ascending);
}

class _Sorter {
  List<ReadarrAuthor> byType(
    List<ReadarrAuthor> data,
    ReadarrAuthorSorting type,
    bool ascending,
  ) {
    switch (type) {
      case ReadarrAuthorSorting.DATE_ADDED:
        return _dateAdded(data, ascending);
      case ReadarrAuthorSorting.EPISODES:
        return _episodes(data, ascending);
      case ReadarrAuthorSorting.SIZE:
        return _size(data, ascending);
      case ReadarrAuthorSorting.ALPHABETICAL:
        return _alphabetical(data, ascending);
      case ReadarrAuthorSorting.QUALITY:
        return _quality(data, ascending);
    }
  }

  List<ReadarrAuthor> _alphabetical(
      List<ReadarrAuthor> series, bool ascending) {
    ascending
        ? series.sort((a, b) =>
            a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase()))
        : series.sort((a, b) =>
            b.sortTitle!.toLowerCase().compareTo(a.sortTitle!.toLowerCase()));
    return series;
  }

  List<ReadarrAuthor> _dateAdded(List<ReadarrAuthor> series, bool ascending) {
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

  List<ReadarrAuthor> _episodes(List<ReadarrAuthor> series, bool ascending) {
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

  List<ReadarrAuthor> _quality(List<ReadarrAuthor> series, bool ascending) {
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

  List<ReadarrAuthor> _size(List<ReadarrAuthor> series, bool ascending) {
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
}
