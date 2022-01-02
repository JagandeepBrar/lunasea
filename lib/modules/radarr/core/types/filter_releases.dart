import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

part 'filter_releases.g.dart';

@HiveType(typeId: 20, adapterName: 'RadarrReleasesFilterAdapter')
enum RadarrReleasesFilter {
  @HiveField(0)
  ALL,
  @HiveField(1)
  APPROVED,
  @HiveField(2)
  REJECTED,
}

extension RadarrReleasesFilterExtension on RadarrReleasesFilter {
  String get key {
    switch (this) {
      case RadarrReleasesFilter.ALL:
        return 'all';
      case RadarrReleasesFilter.APPROVED:
        return 'approved';
      case RadarrReleasesFilter.REJECTED:
        return 'rejected';
    }
  }

  String get readable {
    switch (this) {
      case RadarrReleasesFilter.ALL:
        return 'radarr.All'.tr();
      case RadarrReleasesFilter.APPROVED:
        return 'radarr.Approved'.tr();
      case RadarrReleasesFilter.REJECTED:
        return 'radarr.Rejected'.tr();
    }
  }

  RadarrReleasesFilter? fromKey(String key) {
    switch (key) {
      case 'all':
        return RadarrReleasesFilter.ALL;
      case 'approved':
        return RadarrReleasesFilter.APPROVED;
      case 'rejected':
        return RadarrReleasesFilter.REJECTED;
      default:
        return null;
    }
  }

  List<RadarrRelease> filter(List<RadarrRelease> releases) =>
      _Filterer().byType(releases, this);
}

class _Filterer {
  List<RadarrRelease> byType(
    List<RadarrRelease> releases,
    RadarrReleasesFilter type,
  ) {
    switch (type) {
      case RadarrReleasesFilter.ALL:
        return releases;
      case RadarrReleasesFilter.APPROVED:
        return _approved(releases);
      case RadarrReleasesFilter.REJECTED:
        return _rejected(releases);
    }
  }

  List<RadarrRelease> _approved(List<RadarrRelease> releases) =>
      releases.where((element) => element.approved!).toList();
  List<RadarrRelease> _rejected(List<RadarrRelease> releases) =>
      releases.where((element) => !element.approved!).toList();
}
