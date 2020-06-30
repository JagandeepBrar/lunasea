import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

enum SonarrReleasesSorting {
    age,
    alphabetical,
    seeders,
    size,
    type,
    weight,
}

extension SonarrReleasesSortingExtension on SonarrReleasesSorting {
    static _Sorter _sorter = _Sorter();

    String get value {
        switch(this) {
            case SonarrReleasesSorting.age: return 'age';
            case SonarrReleasesSorting.alphabetical: return 'abc';
            case SonarrReleasesSorting.seeders: return 'seeders';
            case SonarrReleasesSorting.weight: return 'weight';
            case SonarrReleasesSorting.type: return 'type';
            case SonarrReleasesSorting.size: return 'size';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case SonarrReleasesSorting.age: return 'Age';
            case SonarrReleasesSorting.alphabetical: return 'Alphabetical';
            case SonarrReleasesSorting.seeders: return 'Seeders';
            case SonarrReleasesSorting.weight: return 'Weight';
            case SonarrReleasesSorting.type: return 'Type';
            case SonarrReleasesSorting.size: return 'Size';
        }
        throw Exception('readable not found');
    }

    List<SonarrReleaseData> sort(
        List data,
        bool ascending
    ) => _sorter.byType(data, this, ascending);
}

class _Sorter extends Sorter<SonarrReleasesSorting> {
    @override
    List byType(
        List data,
        SonarrReleasesSorting type,
        bool ascending,
    ) {
        switch(type) {
            case SonarrReleasesSorting.age: return _age(data, ascending);
            case SonarrReleasesSorting.alphabetical: return _alphabetical(data, ascending);
            case SonarrReleasesSorting.seeders: return _seeders(data, ascending);
            case SonarrReleasesSorting.weight: return _weight(data, ascending);
            case SonarrReleasesSorting.type: return _type(data, ascending);
            case SonarrReleasesSorting.size: return _size(data, ascending);
        }
        throw Exception('sorting type not found');
    }

    List<SonarrReleaseData> _alphabetical(List data, bool ascending) {
        List<SonarrReleaseData> _data = new List<SonarrReleaseData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.title.compareTo(b.title))
            : _data.sort((a,b) => b.title.compareTo(a.title));
        return _data;
    }

    List<SonarrReleaseData> _weight(List data, bool ascending) {
        List<SonarrReleaseData> _data = new List<SonarrReleaseData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.releaseWeight.compareTo(b.releaseWeight))
            : _data.sort((a,b) => b.releaseWeight.compareTo(a.releaseWeight));
        return _data;
    }

    List<SonarrReleaseData> _type(List data, bool ascending) {
        List<SonarrReleaseData> _data = new List<SonarrReleaseData>.from(data, growable: false);
        List<SonarrReleaseData> _usenet = _data.where((value) => !value.isTorrent).toList();
        List<SonarrReleaseData> _torrent = _data.where((value) => value.isTorrent).toList();
        return ascending
            ? [..._usenet, ..._torrent]
            : [..._torrent, ..._usenet];
    }

    List<SonarrReleaseData> _age(List data, bool ascending) {
        List<SonarrReleaseData> _data = new List<SonarrReleaseData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.ageHours.compareTo(b.ageHours))
            : _data.sort((a,b) => b.ageHours.compareTo(a.ageHours));
        return _data;
    }

    List<SonarrReleaseData> _seeders(List data, bool ascending) {
        List<SonarrReleaseData> _data = new List<SonarrReleaseData>.from(data, growable: false);
        List<SonarrReleaseData> _usenet = _data.where((value) => !value.isTorrent).toList();
        List<SonarrReleaseData> _torrent = _data.where((value) => value.isTorrent).toList();
        ascending
            ? _torrent.sort((a,b) => b.seeders.compareTo(a.seeders))
            : _torrent.sort((a,b) => a.seeders.compareTo(b.seeders));
        return [..._torrent, ..._usenet];
    }

    List<SonarrReleaseData> _size(List data, bool ascending) {
        List<SonarrReleaseData> _data = new List<SonarrReleaseData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.size.compareTo(b.size))
            : _data.sort((a,b) => b.size.compareTo(a.size));
        return _data;
    }
}
