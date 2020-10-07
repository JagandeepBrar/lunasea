import 'package:lunasea/modules/sonarr.dart';

enum SonarrReleasesSorting {
    AGE,
    ALPHABETICAL,
    SEEDERS,
    SIZE,
    TYPE,
    WEIGHT,
}

extension SonarrReleasesSortingExtension on SonarrReleasesSorting {
    static _Sorter _sorter = _Sorter();

    String get value {
        switch(this) {
            case SonarrReleasesSorting.AGE: return 'age';
            case SonarrReleasesSorting.ALPHABETICAL: return 'abc';
            case SonarrReleasesSorting.SEEDERS: return 'seeders';
            case SonarrReleasesSorting.WEIGHT: return 'weight';
            case SonarrReleasesSorting.TYPE: return 'type';
            case SonarrReleasesSorting.SIZE: return 'size';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case SonarrReleasesSorting.AGE: return 'Age';
            case SonarrReleasesSorting.ALPHABETICAL: return 'Alphabetical';
            case SonarrReleasesSorting.SEEDERS: return 'Seeders';
            case SonarrReleasesSorting.WEIGHT: return 'Weight';
            case SonarrReleasesSorting.TYPE: return 'Type';
            case SonarrReleasesSorting.SIZE: return 'Size';
        }
        throw Exception('readable not found');
    }

    List<SonarrRelease> sort(
        List<SonarrRelease> releases,
        bool ascending
    ) => _sorter.byType(releases, this, ascending);
}

class _Sorter {
    List<SonarrRelease> byType(
        List<SonarrRelease> releases,
        SonarrReleasesSorting type,
        bool ascending,
    ) {
        switch(type) {
            case SonarrReleasesSorting.AGE: return _age(releases, ascending);
            case SonarrReleasesSorting.ALPHABETICAL: return _alphabetical(releases, ascending);
            case SonarrReleasesSorting.SEEDERS: return _seeders(releases, ascending);
            case SonarrReleasesSorting.WEIGHT: return _weight(releases, ascending);
            case SonarrReleasesSorting.TYPE: return _type(releases, ascending);
            case SonarrReleasesSorting.SIZE: return _size(releases, ascending);
        }
        throw Exception('sorting type not found');
    }

    List<SonarrRelease> _alphabetical(List<SonarrRelease> releases, bool ascending) {
        ascending
            ? releases.sort((a,b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()))
            : releases.sort((a,b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
        return releases;
    }

    List<SonarrRelease> _age(List<SonarrRelease> releases, bool ascending) {
        ascending
            ? releases.sort((a,b) => a.ageHours.compareTo(b.ageHours))
            : releases.sort((a,b) => b.ageHours.compareTo(a.ageHours));
        return releases;
    }

    List<SonarrRelease> _seeders(List<SonarrRelease> releases, bool ascending) {
        List<SonarrRelease> _torrent = _weight(releases.where((release) => release.protocol == 'torrent').toList(), true);
        List<SonarrRelease> _usenet = _weight(releases.where((release) => release.protocol == 'usenet').toList(), true);
        ascending
            ? _torrent.sort((a,b) => (a.seeders ?? -1).compareTo((b.seeders ?? -1)))
            : _torrent.sort((a,b) => (b.seeders ?? -1).compareTo((a.seeders ?? -1)));
        return [..._torrent, ..._usenet];
    }

    List<SonarrRelease> _weight(List<SonarrRelease> releases, bool ascending) {
        ascending
            ? releases.sort((a,b) => (a.releaseWeight ?? -1).compareTo((b.releaseWeight ?? -1)))
            : releases.sort((a,b) => (b.releaseWeight ?? -1).compareTo((a.releaseWeight ?? -1)));
        return releases;
    }

    List<SonarrRelease> _type(List<SonarrRelease> releases, bool ascending) {
        List<SonarrRelease> _torrent = _weight(releases.where((release) => release.protocol == 'torrent').toList(), true);
        List<SonarrRelease> _usenet = _weight(releases.where((release) => release.protocol == 'usenet').toList(), true);
        return ascending
            ? [..._torrent, ..._usenet]
            : [..._usenet, ..._torrent];
    }

    List<SonarrRelease> _size(List<SonarrRelease> releases, bool ascending) {
        ascending
            ? releases.sort((a,b) => (a.size ?? -1).compareTo((b.size ?? -1)))
            : releases.sort((a,b) => (b.size ?? -1).compareTo((a.size ?? -1)));
        return releases;
    }
}
