import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

part 'filter_releases.g.dart';

@HiveType(typeId: 30, adapterName: 'ReadarrReleasesFilterAdapter')
enum ReadarrReleasesFilter {
  @HiveField(0)
  ALL,
  @HiveField(1)
  APPROVED,
  @HiveField(2)
  REJECTED,
}

extension ReadarrReleasesFilterExtension on ReadarrReleasesFilter {
  ReadarrReleasesFilter? fromKey(String? key) {
    switch (key) {
      case 'all':
        return ReadarrReleasesFilter.ALL;
      case 'approved':
        return ReadarrReleasesFilter.APPROVED;
      case 'rejected':
        return ReadarrReleasesFilter.REJECTED;
      default:
        return null;
    }
  }

  String get key {
    switch (this) {
      case ReadarrReleasesFilter.ALL:
        return 'all';
      case ReadarrReleasesFilter.APPROVED:
        return 'approved';
      case ReadarrReleasesFilter.REJECTED:
        return 'rejected';
    }
  }

  String get readable {
    switch (this) {
      case ReadarrReleasesFilter.ALL:
        return 'readarr.All'.tr();
      case ReadarrReleasesFilter.APPROVED:
        return 'readarr.Approved'.tr();
      case ReadarrReleasesFilter.REJECTED:
        return 'readarr.Rejected'.tr();
    }
  }

  List<ReadarrRelease> filter(List<ReadarrRelease> releases) =>
      _Filterer().byType(releases, this);
}

class _Filterer {
  List<ReadarrRelease> byType(
    List<ReadarrRelease> releases,
    ReadarrReleasesFilter type,
  ) {
    switch (type) {
      case ReadarrReleasesFilter.ALL:
        return releases;
      case ReadarrReleasesFilter.APPROVED:
        return _approved(releases);
      case ReadarrReleasesFilter.REJECTED:
        return _rejected(releases);
    }
  }

  List<ReadarrRelease> _approved(List<ReadarrRelease> releases) =>
      releases.where((element) => element.approved!).toList();
  List<ReadarrRelease> _rejected(List<ReadarrRelease> releases) =>
      releases.where((element) => !element.approved!).toList();
}
