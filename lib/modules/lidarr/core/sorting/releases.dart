import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

enum LidarrReleasesSorting {
    age,
    alphabetical,
    seeders,
    size,
    type,
    weight,
}

extension LidarrReleasesSortingExtension on LidarrReleasesSorting {
    static _Sorter _sorter = _Sorter();

    String get value {
        switch(this) {
            case LidarrReleasesSorting.age: return 'age';
            case LidarrReleasesSorting.alphabetical: return 'abc';
            case LidarrReleasesSorting.seeders: return 'seeders';
            case LidarrReleasesSorting.weight: return 'weight';
            case LidarrReleasesSorting.type: return 'type';
            case LidarrReleasesSorting.size: return 'size';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case LidarrReleasesSorting.age: return 'Age';
            case LidarrReleasesSorting.alphabetical: return 'Alphabetical';
            case LidarrReleasesSorting.seeders: return 'Seeders';
            case LidarrReleasesSorting.weight: return 'Weight';
            case LidarrReleasesSorting.type: return 'Type';
            case LidarrReleasesSorting.size: return 'Size';
        }
        throw Exception('readable not found');
    }

    List<LidarrReleaseData> sort(
        List data,
        bool ascending
    ) => _sorter.byType(data, this, ascending);
}

class _Sorter extends Sorter<LidarrReleasesSorting> {
    @override
    List byType(
        List data,
        LidarrReleasesSorting type,
        bool ascending,
    ) {
        switch(type) {
            case LidarrReleasesSorting.age: return _age(data, ascending);
            case LidarrReleasesSorting.alphabetical: return _alphabetical(data, ascending);
            case LidarrReleasesSorting.seeders: return _seeders(data, ascending);
            case LidarrReleasesSorting.weight: return _weight(data, ascending);
            case LidarrReleasesSorting.type: return _type(data, ascending);
            case LidarrReleasesSorting.size: return _size(data, ascending);
        }
        throw Exception('sorting type not found');
    }

    List<LidarrReleaseData> _alphabetical(List data, bool ascending) {
        List<LidarrReleaseData> _data = new List<LidarrReleaseData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.title.compareTo(b.title))
            : _data.sort((a,b) => b.title.compareTo(a.title));
        return _data;
    }

    List<LidarrReleaseData> _weight(List data, bool ascending) {
        List<LidarrReleaseData> _data = new List<LidarrReleaseData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.releaseWeight.compareTo(b.releaseWeight))
            : _data.sort((a,b) => b.releaseWeight.compareTo(a.releaseWeight));
        return _data;
    }

    List<LidarrReleaseData> _type(List data, bool ascending) {
        List<LidarrReleaseData> _data = new List<LidarrReleaseData>.from(data, growable: false);
        List<LidarrReleaseData> _usenet = _data.where((value) => !value.isTorrent).toList();
        List<LidarrReleaseData> _torrent = _data.where((value) => value.isTorrent).toList();
        return ascending
            ? [..._usenet, ..._torrent]
            : [..._torrent, ..._usenet];
    }

    List<LidarrReleaseData> _age(List data, bool ascending) {
        List<LidarrReleaseData> _data = new List<LidarrReleaseData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.ageHours.compareTo(b.ageHours))
            : _data.sort((a,b) => b.ageHours.compareTo(a.ageHours));
        return _data;
    }

    List<LidarrReleaseData> _seeders(List data, bool ascending) {
        List<LidarrReleaseData> _data = new List<LidarrReleaseData>.from(data, growable: false);
        List<LidarrReleaseData> _usenet = _data.where((value) => !value.isTorrent).toList();
        List<LidarrReleaseData> _torrent = _data.where((value) => value.isTorrent).toList();
        ascending
            ? _torrent.sort((a,b) => b.seeders.compareTo(a.seeders))
            : _torrent.sort((a,b) => a.seeders.compareTo(b.seeders));
        return [..._torrent, ..._usenet];
    }

    List<LidarrReleaseData> _size(List data, bool ascending) {
        List<LidarrReleaseData> _data = new List<LidarrReleaseData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.size.compareTo(b.size))
            : _data.sort((a,b) => b.size.compareTo(a.size));
        return _data;
    }
}
