import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

part 'sorting_releases.g.dart';

@HiveType(typeId: 21, adapterName: 'RadarrReleasesSortingAdapter')
enum RadarrReleasesSorting {
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
}

extension RadarrReleasesSortingExtension on RadarrReleasesSorting {
  String get key {
    switch (this) {
      case RadarrReleasesSorting.AGE:
        return 'age';
      case RadarrReleasesSorting.ALPHABETICAL:
        return 'abc';
      case RadarrReleasesSorting.SEEDERS:
        return 'seeders';
      case RadarrReleasesSorting.WEIGHT:
        return 'weight';
      case RadarrReleasesSorting.TYPE:
        return 'type';
      case RadarrReleasesSorting.SIZE:
        return 'size';
    }
  }

  String get readable {
    switch (this) {
      case RadarrReleasesSorting.AGE:
        return 'radarr.Age'.tr();
      case RadarrReleasesSorting.ALPHABETICAL:
        return 'radarr.Alphabetical'.tr();
      case RadarrReleasesSorting.SEEDERS:
        return 'radarr.Seeders'.tr();
      case RadarrReleasesSorting.WEIGHT:
        return 'radarr.Weight'.tr();
      case RadarrReleasesSorting.TYPE:
        return 'radarr.Type'.tr();
      case RadarrReleasesSorting.SIZE:
        return 'radarr.Size'.tr();
    }
  }

  RadarrReleasesSorting? fromKey(String? key) {
    switch (key) {
      case 'age':
        return RadarrReleasesSorting.AGE;
      case 'abc':
        return RadarrReleasesSorting.ALPHABETICAL;
      case 'seeders':
        return RadarrReleasesSorting.SEEDERS;
      case 'size':
        return RadarrReleasesSorting.SIZE;
      case 'type':
        return RadarrReleasesSorting.TYPE;
      case 'weight':
        return RadarrReleasesSorting.WEIGHT;
      default:
        return null;
    }
  }

  List<RadarrRelease> sort(List<RadarrRelease> releases, bool ascending) =>
      _Sorter().byType(releases, this, ascending);
}

class _Sorter {
  List<RadarrRelease> byType(
    List<RadarrRelease> releases,
    RadarrReleasesSorting type,
    bool ascending,
  ) {
    switch (type) {
      case RadarrReleasesSorting.AGE:
        return _age(releases, ascending);
      case RadarrReleasesSorting.ALPHABETICAL:
        return _alphabetical(releases, ascending);
      case RadarrReleasesSorting.SEEDERS:
        return _seeders(releases, ascending);
      case RadarrReleasesSorting.WEIGHT:
        return _weight(releases, ascending);
      case RadarrReleasesSorting.TYPE:
        return _type(releases, ascending);
      case RadarrReleasesSorting.SIZE:
        return _size(releases, ascending);
    }
  }

  List<RadarrRelease> _alphabetical(
      List<RadarrRelease> releases, bool ascending) {
    ascending
        ? releases.sort(
            (a, b) => a.title!.toLowerCase().compareTo(b.title!.toLowerCase()))
        : releases.sort(
            (a, b) => b.title!.toLowerCase().compareTo(a.title!.toLowerCase()));
    return releases;
  }

  List<RadarrRelease> _age(List<RadarrRelease> releases, bool ascending) {
    ascending
        ? releases.sort((a, b) => a.ageHours!.compareTo(b.ageHours!))
        : releases.sort((a, b) => b.ageHours!.compareTo(a.ageHours!));
    return releases;
  }

  List<RadarrRelease> _seeders(List<RadarrRelease> releases, bool ascending) {
    List<RadarrRelease> _torrent = _weight(
        releases
            .where((release) => release.protocol == RadarrProtocol.TORRENT)
            .toList(),
        true);
    List<RadarrRelease> _usenet = _weight(
        releases
            .where((release) => release.protocol == RadarrProtocol.USENET)
            .toList(),
        true);
    ascending
        ? _torrent
            .sort((a, b) => (a.seeders ?? -1).compareTo((b.seeders ?? -1)))
        : _torrent
            .sort((a, b) => (b.seeders ?? -1).compareTo((a.seeders ?? -1)));
    return [..._torrent, ..._usenet];
  }

  List<RadarrRelease> _weight(List<RadarrRelease> releases, bool ascending) {
    ascending
        ? releases.sort((a, b) =>
            (a.releaseWeight ?? -1).compareTo((b.releaseWeight ?? -1)))
        : releases.sort((a, b) =>
            (b.releaseWeight ?? -1).compareTo((a.releaseWeight ?? -1)));
    return releases;
  }

  List<RadarrRelease> _type(List<RadarrRelease> releases, bool ascending) {
    List<RadarrRelease> _torrent = _weight(
        releases
            .where((release) => release.protocol == RadarrProtocol.TORRENT)
            .toList(),
        true);
    List<RadarrRelease> _usenet = _weight(
        releases
            .where((release) => release.protocol == RadarrProtocol.USENET)
            .toList(),
        true);
    return ascending ? [..._torrent, ..._usenet] : [..._usenet, ..._torrent];
  }

  List<RadarrRelease> _size(List<RadarrRelease> releases, bool ascending) {
    ascending
        ? releases.sort((a, b) => (a.size ?? -1).compareTo((b.size ?? -1)))
        : releases.sort((a, b) => (b.size ?? -1).compareTo((a.size ?? -1)));
    return releases;
  }
}
