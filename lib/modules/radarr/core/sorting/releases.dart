import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

enum RadarrReleasesSorting {
    age,
    alphabetical,
    seeders,
    size,
    type,
    weight,
}

extension RadarrReleasesSortingExtension on RadarrReleasesSorting {
    static _Sorter _sorter = _Sorter();

    String get value {
        switch(this) {
            case RadarrReleasesSorting.age: return 'age';
            case RadarrReleasesSorting.alphabetical: return 'abc';
            case RadarrReleasesSorting.seeders: return 'seeders';
            case RadarrReleasesSorting.weight: return 'weight';
            case RadarrReleasesSorting.type: return 'type';
            case RadarrReleasesSorting.size: return 'size';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case RadarrReleasesSorting.age: return 'Age';
            case RadarrReleasesSorting.alphabetical: return 'Alphabetical';
            case RadarrReleasesSorting.seeders: return 'Seeders';
            case RadarrReleasesSorting.weight: return 'Weight';
            case RadarrReleasesSorting.type: return 'Type';
            case RadarrReleasesSorting.size: return 'Size';
        }
        throw Exception('readable not found');
    }

    List<RadarrReleaseData> sort(
        List data,
        bool ascending
    ) => _sorter.byType(data, this, ascending);
}

class _Sorter extends Sorter<RadarrReleasesSorting> {
    @override
    List byType(
        List data,
        RadarrReleasesSorting type,
        bool ascending,
    ) {
        switch(type) {
            case RadarrReleasesSorting.age: return _age(data, ascending);
            case RadarrReleasesSorting.alphabetical: return _alphabetical(data, ascending);
            case RadarrReleasesSorting.seeders: return _seeders(data, ascending);
            case RadarrReleasesSorting.weight: return _weight(data, ascending);
            case RadarrReleasesSorting.type: return _type(data, ascending);
            case RadarrReleasesSorting.size: return _size(data, ascending);
        }
        throw Exception('sorting type not found');
    }

    List<RadarrReleaseData> _alphabetical(List data, bool ascending) {
        List<RadarrReleaseData> _data = new List<RadarrReleaseData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.title.compareTo(b.title))
            : _data.sort((a,b) => b.title.compareTo(a.title));
        return _data;
    }

    List<RadarrReleaseData> _weight(List data, bool ascending) {
        List<RadarrReleaseData> _data = new List<RadarrReleaseData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.releaseWeight.compareTo(b.releaseWeight))
            : _data.sort((a,b) => b.releaseWeight.compareTo(a.releaseWeight));
        return _data;
    }

    List<RadarrReleaseData> _type(List data, bool ascending) {
        List<RadarrReleaseData> _data = new List<RadarrReleaseData>.from(data, growable: false);
        List<RadarrReleaseData> _usenet = _data.where((value) => !value.isTorrent).toList();
        List<RadarrReleaseData> _torrent = _data.where((value) => value.isTorrent).toList();
        return ascending
            ? [..._usenet, ..._torrent]
            : [..._torrent, ..._usenet];
    }

    List<RadarrReleaseData> _age(List data, bool ascending) {
        List<RadarrReleaseData> _data = new List<RadarrReleaseData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.ageHours.compareTo(b.ageHours))
            : _data.sort((a,b) => b.ageHours.compareTo(a.ageHours));
        return _data;
    }

    List<RadarrReleaseData> _seeders(List data, bool ascending) {
        List<RadarrReleaseData> _data = new List<RadarrReleaseData>.from(data, growable: false);
        List<RadarrReleaseData> _usenet = _data.where((value) => !value.isTorrent).toList();
        List<RadarrReleaseData> _torrent = _data.where((value) => value.isTorrent).toList();
        ascending
            ? _torrent.sort((a,b) => b.seeders.compareTo(a.seeders))
            : _torrent.sort((a,b) => a.seeders.compareTo(b.seeders));
        return [..._torrent, ..._usenet];
    }

    List<RadarrReleaseData> _size(List data, bool ascending) {
        List<RadarrReleaseData> _data = new List<RadarrReleaseData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.size.compareTo(b.size))
            : _data.sort((a,b) => b.size.compareTo(a.size));
        return _data;
    }
}
