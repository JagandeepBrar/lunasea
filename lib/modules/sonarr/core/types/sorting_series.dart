import 'package:lunasea/modules/sonarr.dart';

enum SonarrSeriesSorting {
    alphabetical,
    dateAdded,
    episodes,
    network,
    nextAiring,
    quality,
    size,
    type,
}

extension SonarrSeriesSortingExtension on SonarrSeriesSorting {
    static _Sorter _sorter = _Sorter();

    String get value {
        switch(this) {
            case SonarrSeriesSorting.alphabetical: return 'abc';
            case SonarrSeriesSorting.episodes: return 'episodes';
            case SonarrSeriesSorting.dateAdded: return 'date_added';
            case SonarrSeriesSorting.size: return 'size';
            case SonarrSeriesSorting.type: return 'type';
            case SonarrSeriesSorting.network: return 'network';
            case SonarrSeriesSorting.quality: return 'quality';
            case SonarrSeriesSorting.nextAiring: return 'next_airing';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case SonarrSeriesSorting.alphabetical: return 'Alphabetical';
            case SonarrSeriesSorting.dateAdded: return 'Date Added';
            case SonarrSeriesSorting.episodes: return 'Episodes';
            case SonarrSeriesSorting.network: return 'Network';
            case SonarrSeriesSorting.size: return 'Size';
            case SonarrSeriesSorting.type: return 'Type';
            case SonarrSeriesSorting.quality: return 'Quality Profile';
            case SonarrSeriesSorting.nextAiring: return 'Next Airing';
        }
        throw Exception('readable not found');
    }

    void sort(List<SonarrSeries> data, bool ascending) => _sorter.byType(data, this, ascending);
}

class _Sorter {
    void byType(
        List data,
        SonarrSeriesSorting type,
        bool ascending,
    ) {
        switch(type) {
            case SonarrSeriesSorting.dateAdded: return _dateAdded(data, ascending);
            case SonarrSeriesSorting.episodes: return _episodes(data, ascending);
            case SonarrSeriesSorting.network: return _network(data, ascending);
            case SonarrSeriesSorting.size: return _size(data, ascending);
            case SonarrSeriesSorting.alphabetical:
            default: return _alphabetical(data, ascending);
            // case SonarrSeriesSorting.type: return _type(data, ascending);
            // case SonarrSeriesSorting.quality: return _quality(data, ascending);
            // case SonarrSeriesSorting.nextAiring: return _nextAiring(data, ascending);
        }
        //throw Exception('sorting type not found');
    }

    void _alphabetical(List<SonarrSeries> series, bool ascending) {
        ascending
            ? series.sort((a,b) => a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase()))
            : series.sort((a,b) => b.sortTitle.toLowerCase().compareTo(a.sortTitle.toLowerCase()));
    }

    void _dateAdded(List<SonarrSeries> series, bool ascending) {
        series.sort((a,b) {
            return ascending
                ? a?.added?.compareTo(b?.added) ?? 1
                : b?.added?.compareTo(a?.added) ?? -1;
        });
    }

    void _episodes(List<SonarrSeries> series, bool ascending) {
        series.sort((a,b) {
            if(ascending) {
                return a.lunaPercentageComplete.compareTo(b.lunaPercentageComplete) == 0
                    ? a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase())
                    : a.lunaPercentageComplete.compareTo(b.lunaPercentageComplete);
            } else {
                return b.lunaPercentageComplete.compareTo(a.lunaPercentageComplete) == 0
                    ? a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase())
                    : b.lunaPercentageComplete.compareTo(a.lunaPercentageComplete);
            }
        });
    }

    void _network(List<SonarrSeries> series, bool ascending) {
        ascending
            ? series.sort((a,b) => (a.network ?? 'Unknown').toLowerCase().compareTo((b.network ?? 'Unknown').toLowerCase()))
            : series.sort((a,b) => (b.network ?? 'Unknown').toLowerCase().compareTo((a.network ?? 'Unknown').toLowerCase()));
    }

    void _size(List<SonarrSeries> series, bool ascending) {
        ascending
            ? series.sort((a,b) => (a.sizeOnDisk ?? 0).compareTo(b.sizeOnDisk ?? 0))
            : series.sort((a,b) => (b.sizeOnDisk ?? 0).compareTo(a.sizeOnDisk ?? 0));
    }
}
