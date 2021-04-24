import 'package:lunasea/modules/sonarr.dart';

enum SonarrReleasesFilter {
  ALL,
  APPROVED,
  REJECTED,
}

extension SonarrReleasesFilterExtension on SonarrReleasesFilter {
  String get value {
    switch (this) {
      case SonarrReleasesFilter.ALL:
        return 'all';
      case SonarrReleasesFilter.APPROVED:
        return 'approved';
      case SonarrReleasesFilter.REJECTED:
        return 'rejected';
    }
    throw Exception('value not found');
  }

  String get readable {
    switch (this) {
      case SonarrReleasesFilter.ALL:
        return 'All';
      case SonarrReleasesFilter.APPROVED:
        return 'Approved';
      case SonarrReleasesFilter.REJECTED:
        return 'Rejected';
    }
    throw Exception('readable not found');
  }

  List<SonarrRelease> filter(List<SonarrRelease> releases) =>
      _Sorter().byType(releases, this);
}

class _Sorter {
  List<SonarrRelease> byType(
    List<SonarrRelease> releases,
    SonarrReleasesFilter type,
  ) {
    switch (type) {
      case SonarrReleasesFilter.ALL:
        return releases;
      case SonarrReleasesFilter.APPROVED:
        return _approved(releases);
      case SonarrReleasesFilter.REJECTED:
        return _rejected(releases);
    }
    throw Exception('sorting type not found');
  }

  List<SonarrRelease> _approved(List<SonarrRelease> releases) =>
      releases.where((element) => element.approved).toList();
  List<SonarrRelease> _rejected(List<SonarrRelease> releases) =>
      releases.where((element) => !element.approved).toList();
}
