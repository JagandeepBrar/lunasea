import 'package:lunasea/modules/sonarr.dart';

enum SonarrReleasesHiding {
    ALL,
    APPROVED,
    REJECTED,
}

extension SonarrReleasesHidingExtension on SonarrReleasesHiding {
    String get value {
        switch(this) {
            case SonarrReleasesHiding.ALL: return 'all';
            case SonarrReleasesHiding.APPROVED: return 'approved';
            case SonarrReleasesHiding.REJECTED: return 'rejected';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case SonarrReleasesHiding.ALL: return 'All';
            case SonarrReleasesHiding.APPROVED: return 'Approved';
            case SonarrReleasesHiding.REJECTED: return 'Rejected';
        }
        throw Exception('readable not found');
    }

    List<SonarrRelease> filter(List<SonarrRelease> releases) => _Sorter().byType(releases, this);
}

class _Sorter {
    List<SonarrRelease> byType(
        List<SonarrRelease> releases,
        SonarrReleasesHiding type,
    ) {
        switch(type) {
            case SonarrReleasesHiding.ALL: return releases;
            case SonarrReleasesHiding.APPROVED: return _approved(releases);
            case SonarrReleasesHiding.REJECTED: return _rejected(releases);
        }
        throw Exception('sorting type not found');
    }

    List<SonarrRelease> _approved(List<SonarrRelease> releases) => releases.where((element) => element.approved).toList();
    List<SonarrRelease> _rejected(List<SonarrRelease> releases) => releases.where((element) => !element.approved).toList();
}
