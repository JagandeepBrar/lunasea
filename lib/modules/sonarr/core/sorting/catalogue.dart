import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

enum SonarrCatalogueSorting {
    alphabetical,
    episodes,
    network,
    nextAiring,
    quality,
    size,
    type,
}

extension SonarrCatalogueSortingExtension on SonarrCatalogueSorting {
    static _Sorter _sorter = _Sorter();

    String get value {
        switch(this) {
            case SonarrCatalogueSorting.alphabetical: return 'abc';
            case SonarrCatalogueSorting.episodes: return 'episodes';
            case SonarrCatalogueSorting.size: return 'size';
            case SonarrCatalogueSorting.type: return 'type';
            case SonarrCatalogueSorting.network: return 'network';
            case SonarrCatalogueSorting.quality: return 'quality';
            case SonarrCatalogueSorting.nextAiring: return 'next_airing';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case SonarrCatalogueSorting.alphabetical: return 'Alphabetical';
            case SonarrCatalogueSorting.episodes: return 'Episodes';
            case SonarrCatalogueSorting.network: return 'Network';
            case SonarrCatalogueSorting.size: return 'Size';
            case SonarrCatalogueSorting.type: return 'Type';
            case SonarrCatalogueSorting.quality: return 'Quality Profile';
            case SonarrCatalogueSorting.nextAiring: return 'Next Airing';
        }
        throw Exception('readable not found');
    }

    List<SonarrCatalogueData> sort(
        List data,
        bool ascending
    ) => _sorter.byType(data, this, ascending);
}

class _Sorter extends Sorter<SonarrCatalogueSorting> {
    @override
    List byType(
        List data,
        SonarrCatalogueSorting type,
        bool ascending,
    ) {
        switch(type) {
            case SonarrCatalogueSorting.alphabetical: return _alphabetical(data, ascending);
            case SonarrCatalogueSorting.size: return _size(data, ascending);
            case SonarrCatalogueSorting.type: return _type(data, ascending);
            case SonarrCatalogueSorting.network: return _network(data, ascending);
            case SonarrCatalogueSorting.quality: return _quality(data, ascending);
            case SonarrCatalogueSorting.episodes: return _episodes(data, ascending);
            case SonarrCatalogueSorting.nextAiring: return _nextAiring(data, ascending);
        }
        throw Exception('sorting type not found');
    }

    List<SonarrCatalogueData> _alphabetical(List data, bool ascending) {
        List<SonarrCatalogueData> _data = new List<SonarrCatalogueData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.sortTitle.compareTo(b.sortTitle))
            : _data.sort((a,b) => b.sortTitle.compareTo(a.sortTitle));
        return _data;
    }

    List<SonarrCatalogueData> _size(List data, bool ascending) {
        List<SonarrCatalogueData> _data = new List<SonarrCatalogueData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.sizeOnDisk.compareTo(b.sizeOnDisk))
            : _data.sort((a,b) => b.sizeOnDisk.compareTo(a.sizeOnDisk));
        return _data;
    }

    List<SonarrCatalogueData> _type(List data, bool ascending) {
        List<SonarrCatalogueData> _data = _alphabetical(data, true);
        List<SonarrCatalogueData> _daily = _data.where((value) => value.type == 'daily').toList();
        List<SonarrCatalogueData> _anime = _data.where((value) => value.type == 'anime').toList();
        List<SonarrCatalogueData> _standard = _data.where((value) => value.type == 'standard').toList();
        return ascending
            ? [..._anime, ..._daily, ..._standard]
            : [..._standard, ..._daily, ..._anime];
    }

    List<SonarrCatalogueData> _network(List data, bool ascending) {
        List<SonarrCatalogueData> _data = _alphabetical(data, true);
        ascending
            ? _data.sort((a,b) => a.network.toLowerCase().compareTo(b.network.toLowerCase()))
            : _data.sort((a,b) => b.network.toLowerCase().compareTo(a.network.toLowerCase()));
        return _data;
    }

    List<SonarrCatalogueData> _quality(List data, bool ascending) {
        List<SonarrCatalogueData> _data = _alphabetical(data, true);
        ascending
            ? _data.sort((a,b) => a.qualityProfile.compareTo(b.qualityProfile))
            : _data.sort((a,b) => b.qualityProfile.compareTo(a.qualityProfile));
        return _data;
    }

    List<SonarrCatalogueData> _episodes(List data, bool ascending) {
        List<SonarrCatalogueData> _data = _alphabetical(data, true);
        _data.sort((a,b) {
            int episodeCountA = a.episodeCount ?? 0;
            int availableEpisodeCountA = a.episodeFileCount ?? 0;
            int episodeCountB = b.episodeCount ?? 0;
            int availableEpisodeCountB = b.episodeFileCount ?? 0;
            int percentageA = episodeCountA == 0
                ? 0
                : ((availableEpisodeCountA/episodeCountA)*100).round();
            int percentageB = episodeCountA == 0
                ? 0
                : ((availableEpisodeCountB/episodeCountB)*100).round();
            return ascending
                ? percentageA.compareTo(percentageB)
                : percentageB.compareTo(percentageA);
        });
        return _data;
    }

    List<SonarrCatalogueData> _nextAiring(List data, bool ascending) {
        List<SonarrCatalogueData> _data = _alphabetical(data, true);
        List<SonarrCatalogueData> _hasNoDate = _data.where((item) => item.nextAiringObject == null).toList();
        List<SonarrCatalogueData> _hasDate = _data.where((item) => item.nextAiringObject != null).toList();
        _hasDate.sort((a,b) {
            return ascending
                ? a.nextAiringObject.compareTo(b.nextAiringObject)
                : b.nextAiringObject.compareTo(a.nextAiringObject);
        });
        return [..._hasDate, ..._hasNoDate];
    }
}
