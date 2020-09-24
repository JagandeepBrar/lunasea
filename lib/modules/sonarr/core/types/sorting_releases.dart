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

    List<dynamic> sort(
        List data,
        bool ascending
    ) => _sorter.byType(data, this, ascending);
}

class _Sorter {
    List byType(
        List data,
        SonarrReleasesSorting type,
        bool ascending,
    ) {
        // TODO
        // switch(type) {
        //     case SonarrReleasesSorting.age: return _age(data, ascending);
        //     case SonarrReleasesSorting.alphabetical: return _alphabetical(data, ascending);
        //     case SonarrReleasesSorting.seeders: return _seeders(data, ascending);
        //     case SonarrReleasesSorting.weight: return _weight(data, ascending);
        //     case SonarrReleasesSorting.type: return _type(data, ascending);
        //     case SonarrReleasesSorting.size: return _size(data, ascending);
        // }
        throw Exception('sorting type not found');
    }
}
