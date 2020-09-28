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

    List<SonarrSeries> sort(List<SonarrSeries> data, bool ascending) => _sorter.byType(data, this, ascending);
}

class _Sorter {
    List<SonarrSeries> byType(
        List data,
        SonarrSeriesSorting type,
        bool ascending,
    ) {
        switch(type) {
            case SonarrSeriesSorting.dateAdded: return _dateAdded(data, ascending);
            case SonarrSeriesSorting.episodes: return _episodes(data, ascending);
            case SonarrSeriesSorting.network: return _network(data, ascending);
            case SonarrSeriesSorting.nextAiring: return _nextAiring(data, ascending);
            case SonarrSeriesSorting.size: return _size(data, ascending);
            case SonarrSeriesSorting.type: return _type(data, ascending);
            case SonarrSeriesSorting.alphabetical: return _alphabetical(data, ascending);
            case SonarrSeriesSorting.quality: return _quality(data, ascending);
        }
        throw Exception('sorting type not found');
    }

    List<SonarrSeries> _alphabetical(List<SonarrSeries> series, bool ascending) {
        ascending
            ? series.sort((a,b) => a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase()))
            : series.sort((a,b) => b.sortTitle.toLowerCase().compareTo(a.sortTitle.toLowerCase()));
        return series;
    }

    List<SonarrSeries> _dateAdded(List<SonarrSeries> series, bool ascending) {
        series.sort((a,b) {
            if(ascending) {
                if(a.added == null) return 1;
                if(b.added == null) return -1;
                int _comparison = a.added.compareTo(b.added);
                return _comparison == 0
                    ? a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase())
                    : _comparison;
            } else {
                if(b.added == null) return -1;
                if(a.added == null) return 1;
                int _comparison = b.added.compareTo(a.added);
                return _comparison == 0
                    ? a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase())
                    : _comparison;
            }
        });
        return series;
    }

    List<SonarrSeries> _episodes(List<SonarrSeries> series, bool ascending) {
        series.sort((a,b) {
            int _comparison = ascending
                ? (a.lunaPercentageComplete ?? 0).compareTo(b.lunaPercentageComplete ?? 0)
                : (b.lunaPercentageComplete ?? 0).compareTo(a.lunaPercentageComplete ?? 0);
            return _comparison == 0
                ? a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase())
                : _comparison;
        });
        return series;
    }

    List<SonarrSeries> _network(List<SonarrSeries> series, bool ascending) {
        series.sort((a,b) {
            int _comparison = ascending
                ? (a.network ?? 'Unknown').compareTo((b.network ?? 'Unknown'))
                : (b.network ?? 'Unknown').compareTo((a.network ?? 'Unknown'));
            return _comparison == 0
                ? a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase())
                : _comparison;
        });
        return series;
    }

    List<SonarrSeries> _nextAiring(List<SonarrSeries> series, bool ascending) {
        series.sort((a,b) {
            if(ascending) {
                if(a.nextAiring == null) return 1;
                if(b.nextAiring == null) return -1;
                int _comparison = a.nextAiring.compareTo(b.nextAiring);
                return _comparison == 0
                    ? a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase())
                    : _comparison;
            } else {
                if(b.nextAiring == null) return -1;
                if(a.nextAiring == null) return 1;
                int _comparison = b.nextAiring.compareTo(a.nextAiring);
                return _comparison == 0
                    ? a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase())
                    : _comparison;
            }
        });
        return series;
    }

    List<SonarrSeries> _quality(List<SonarrSeries> series, bool ascending) {
        series.sort((a,b) {
            int _comparison = ascending
                ? (a.qualityProfileId ?? 0).compareTo(b.qualityProfileId ?? 0)
                : (b.qualityProfileId ?? 0).compareTo(a.qualityProfileId ?? 0);
            return _comparison == 0
                ? a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase())
                : _comparison;
        });
        return series;
    }

    List<SonarrSeries> _size(List<SonarrSeries> series, bool ascending) {
        series.sort((a,b) {
            int _comparison = ascending
                ? (a.sizeOnDisk ?? 0).compareTo(b.sizeOnDisk ?? 0)
                : (b.sizeOnDisk ?? 0).compareTo(a.sizeOnDisk ?? 0);
            return _comparison == 0
                ? a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase())
                : _comparison;
        });
        return series;
    }

    List<SonarrSeries> _type(List<SonarrSeries> series, bool ascending) {
        List<SonarrSeries> _anime = series.where((element) => element.seriesType == SonarrSeriesType.ANIME).toList();
        _anime.sort((a,b) => a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase()));
        List<SonarrSeries> _daily = series.where((element) => element.seriesType == SonarrSeriesType.DAILY).toList();
        _daily.sort((a,b) => a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase()));
        List<SonarrSeries> _stand = series.where((element) => element.seriesType == SonarrSeriesType.STANDARD).toList();
        _stand.sort((a,b) => a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase()));
        return ascending ? [..._anime, ..._daily, ..._stand] : [..._stand, ..._daily, ..._anime];
    }
}
