import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

enum RadarrCatalogueSorting {
    alphabetical,
    quality,
    runtime,
    size,
    studio,
    year,
}

extension RadarrCatalogueSortingExtension on RadarrCatalogueSorting {
    static _Sorter _sorter = _Sorter();

    String get value {
        switch(this) {
            case RadarrCatalogueSorting.alphabetical: return 'abc';
            case RadarrCatalogueSorting.size: return 'size';
            case RadarrCatalogueSorting.quality: return 'quality';
            case RadarrCatalogueSorting.studio: return 'studio';
            case RadarrCatalogueSorting.runtime: return 'runtime';
            case RadarrCatalogueSorting.year: return 'year';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case RadarrCatalogueSorting.alphabetical: return 'Alphabetical';
            case RadarrCatalogueSorting.size: return 'Size';
            case RadarrCatalogueSorting.quality: return 'Quality Profile';
            case RadarrCatalogueSorting.studio: return 'Studio';
            case RadarrCatalogueSorting.runtime: return 'Runtime';
            case RadarrCatalogueSorting.year: return 'Year';
        }
        throw Exception('readable not found');
    }

    List<RadarrCatalogueData> sort(
        List data,
        bool ascending
    ) => _sorter.byType(data, this, ascending);
}

class _Sorter extends Sorter<RadarrCatalogueSorting> {
    @override
    List byType(
        List data,
        RadarrCatalogueSorting type,
        bool ascending,
    ) {
        switch(type) {
            case RadarrCatalogueSorting.alphabetical: return _alphabetical(data, ascending);
            case RadarrCatalogueSorting.size: return _size(data, ascending);
            case RadarrCatalogueSorting.quality: return _quality(data, ascending);
            case RadarrCatalogueSorting.studio: return _studio(data, ascending);
            case RadarrCatalogueSorting.runtime: return _runtime(data, ascending);
            case RadarrCatalogueSorting.year: return _year(data, ascending);
        }
        throw Exception('sorting type not found');
    }

    List<RadarrCatalogueData> _alphabetical(List data, bool ascending) {
        List<RadarrCatalogueData> _data = new List<RadarrCatalogueData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.sortTitle.compareTo(b.sortTitle))
            : _data.sort((a,b) => b.sortTitle.compareTo(a.sortTitle));
        return _data;
    }

    List<RadarrCatalogueData> _size(List data, bool ascending) {
        List<RadarrCatalogueData> _data = new List<RadarrCatalogueData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.sizeOnDisk.compareTo(b.sizeOnDisk))
            : _data.sort((a,b) => b.sizeOnDisk.compareTo(a.sizeOnDisk));
        return _data;
    }

    List<RadarrCatalogueData> _quality(List data, bool ascending) {
        List<RadarrCatalogueData> _data = _alphabetical(data, true);
        ascending
            ? _data.sort((a,b) => a.qualityProfile.compareTo(b.qualityProfile))
            : _data.sort((a,b) => b.qualityProfile.compareTo(a.qualityProfile));
        return _data;
    }

    List<RadarrCatalogueData> _studio(List data, bool ascending) {
        List<RadarrCatalogueData> _data = _alphabetical(data, true);
        ascending
            ? _data.sort((a,b) => a.studio.compareTo(b.studio))
            : _data.sort((a,b) => b.studio.compareTo(a.studio));
        return _data;
    }

    List<RadarrCatalogueData> _runtime(List data, bool ascending) {
        List<RadarrCatalogueData> _data = _alphabetical(data, true);
        ascending
            ? _data.sort((a,b) => a.runtime.compareTo(b.runtime))
            : _data.sort((a,b) => b.runtime.compareTo(a.runtime));
        return _data;
    }

    List<RadarrCatalogueData> _year(List data, bool ascending) {
        List<RadarrCatalogueData> _data = _alphabetical(data, true);
        ascending
            ? _data.sort((a,b) => a.year.compareTo(b.year))
            : _data.sort((a,b) => b.year.compareTo(a.year));
        return _data;
    }
}
