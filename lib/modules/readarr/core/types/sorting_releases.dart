import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

part 'sorting_releases.g.dart';

@HiveType(typeId: 32, adapterName: 'ReadarrReleasesSortingAdapter')
enum ReadarrReleasesSorting {
  @HiveField(0)
  AGE,
  @HiveField(1)
  ALPHABETICAL,
  @HiveField(2)
  SEEDERS,
  @HiveField(3)
  SIZE,
  @HiveField(4)
  TYPE,
  @HiveField(5)
  WEIGHT,
  @HiveField(6)
  WORD_SCORE,
}

extension ReadarrReleasesSortingExtension on ReadarrReleasesSorting {
  String get key {
    switch (this) {
      case ReadarrReleasesSorting.AGE:
        return 'age';
      case ReadarrReleasesSorting.ALPHABETICAL:
        return 'abc';
      case ReadarrReleasesSorting.SEEDERS:
        return 'seeders';
      case ReadarrReleasesSorting.WEIGHT:
        return 'weight';
      case ReadarrReleasesSorting.TYPE:
        return 'type';
      case ReadarrReleasesSorting.SIZE:
        return 'size';
      case ReadarrReleasesSorting.WORD_SCORE:
        return 'word_score';
    }
  }

  String get readable {
    switch (this) {
      case ReadarrReleasesSorting.AGE:
        return 'Age';
      case ReadarrReleasesSorting.ALPHABETICAL:
        return 'Alphabetical';
      case ReadarrReleasesSorting.SEEDERS:
        return 'Seeders';
      case ReadarrReleasesSorting.WEIGHT:
        return 'Weight';
      case ReadarrReleasesSorting.TYPE:
        return 'Type';
      case ReadarrReleasesSorting.SIZE:
        return 'Size';
      case ReadarrReleasesSorting.WORD_SCORE:
        return 'readarr.WordScore'.tr();
    }
  }

  ReadarrReleasesSorting? fromKey(String? key) {
    switch (key) {
      case 'age':
        return ReadarrReleasesSorting.AGE;
      case 'abc':
        return ReadarrReleasesSorting.ALPHABETICAL;
      case 'seeders':
        return ReadarrReleasesSorting.SEEDERS;
      case 'size':
        return ReadarrReleasesSorting.SIZE;
      case 'type':
        return ReadarrReleasesSorting.TYPE;
      case 'weight':
        return ReadarrReleasesSorting.WEIGHT;
      case 'word_score':
        return ReadarrReleasesSorting.WORD_SCORE;
      default:
        return null;
    }
  }

  List<ReadarrRelease> sort(List<ReadarrRelease> releases, bool ascending) =>
      _Sorter().byType(releases, this, ascending);
}

class _Sorter {
  List<ReadarrRelease> byType(
    List<ReadarrRelease> releases,
    ReadarrReleasesSorting type,
    bool ascending,
  ) {
    switch (type) {
      case ReadarrReleasesSorting.AGE:
        return _age(releases, ascending);
      case ReadarrReleasesSorting.ALPHABETICAL:
        return _alphabetical(releases, ascending);
      case ReadarrReleasesSorting.SEEDERS:
        return _seeders(releases, ascending);
      case ReadarrReleasesSorting.WEIGHT:
        return _weight(releases, ascending);
      case ReadarrReleasesSorting.TYPE:
        return _type(releases, ascending);
      case ReadarrReleasesSorting.SIZE:
        return _size(releases, ascending);
      case ReadarrReleasesSorting.WORD_SCORE:
        return _wordScore(releases, ascending);
    }
  }

  List<ReadarrRelease> _alphabetical(
      List<ReadarrRelease> releases, bool ascending) {
    ascending
        ? releases.sort(
            (a, b) => a.title!.toLowerCase().compareTo(b.title!.toLowerCase()))
        : releases.sort(
            (a, b) => b.title!.toLowerCase().compareTo(a.title!.toLowerCase()));
    return releases;
  }

  List<ReadarrRelease> _age(List<ReadarrRelease> releases, bool ascending) {
    ascending
        ? releases.sort((a, b) => a.ageHours!.compareTo(b.ageHours!))
        : releases.sort((a, b) => b.ageHours!.compareTo(a.ageHours!));
    return releases;
  }

  List<ReadarrRelease> _seeders(List<ReadarrRelease> releases, bool ascending) {
    List<ReadarrRelease> _torrent = _weight(
        releases
            .where((release) => release.protocol == ReadarrProtocol.TORRENT)
            .toList(),
        true);
    List<ReadarrRelease> _usenet = _weight(
        releases
            .where((release) => release.protocol == ReadarrProtocol.USENET)
            .toList(),
        true);
    ascending
        ? _torrent
            .sort((a, b) => (a.seeders ?? -1).compareTo((b.seeders ?? -1)))
        : _torrent
            .sort((a, b) => (b.seeders ?? -1).compareTo((a.seeders ?? -1)));
    return [..._torrent, ..._usenet];
  }

  List<ReadarrRelease> _weight(List<ReadarrRelease> releases, bool ascending) {
    ascending
        ? releases.sort((a, b) =>
            (a.releaseWeight ?? -1).compareTo((b.releaseWeight ?? -1)))
        : releases.sort((a, b) =>
            (b.releaseWeight ?? -1).compareTo((a.releaseWeight ?? -1)));
    return releases;
  }

  List<ReadarrRelease> _type(List<ReadarrRelease> releases, bool ascending) {
    List<ReadarrRelease> _torrent = _weight(
        releases
            .where((release) => release.protocol == ReadarrProtocol.TORRENT)
            .toList(),
        true);
    List<ReadarrRelease> _usenet = _weight(
        releases
            .where((release) => release.protocol == ReadarrProtocol.USENET)
            .toList(),
        true);
    return ascending ? [..._torrent, ..._usenet] : [..._usenet, ..._torrent];
  }

  List<ReadarrRelease> _size(List<ReadarrRelease> releases, bool ascending) {
    ascending
        ? releases.sort((a, b) => (a.size ?? -1).compareTo((b.size ?? -1)))
        : releases.sort((a, b) => (b.size ?? -1).compareTo((a.size ?? -1)));
    return releases;
  }

  List<ReadarrRelease> _wordScore(List<ReadarrRelease> releases, bool ascending) {
    ascending
        ? releases.sort((a, b) =>
            (b.preferredWordScore ?? 0).compareTo((a.preferredWordScore ?? 0)))
        : releases.sort((a, b) =>
            (a.preferredWordScore ?? 0).compareTo((b.preferredWordScore ?? 0)));
    return releases;
  }
}
