import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrLocalState extends ChangeNotifier {
    String _homeSearchQuery = '';
    String get homeSearchQuery => _homeSearchQuery;
    set homeSearchQuery(String homeSearchQuery) {
        assert(homeSearchQuery != null);
        _homeSearchQuery = homeSearchQuery;
        notifyListeners();
    }

    //////////////////
    /// ADD SERIES ///
    //////////////////

    String _addSearchQuery = '';
    String get addSearchQuery => _addSearchQuery;
    set addSearchQuery(String addSearchQuery) {
        assert(addSearchQuery != null);
        _addSearchQuery = addSearchQuery;
        notifyListeners();
    }

    Future<List<SonarrSeriesLookup>> _seriesLookup;
    Future<List<SonarrSeriesLookup>> get seriesLookup => _seriesLookup;
    void fetchSeriesLookup(BuildContext context) {
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
        _seriesLookup = _state.api.seriesLookup.getSeriesLookup(term: _addSearchQuery);
        notifyListeners();
    }

    Future<List<SonarrRootFolder>> _rootFolders;
    Future<List<SonarrRootFolder>> get rootFolders => _rootFolders;
    void fetchRootFolders(BuildContext context) {
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
        _rootFolders = _state.api.rootFolder.getRootFolders();
        notifyListeners();
    }

    ////////////////
    /// RELEASES ///
    ////////////////

    String _releasesSearchQuery = '';
    String get releasesSearchQuery => _releasesSearchQuery;
    set releasesSearchQuery(String releasesSearchQuery) {
        assert(releasesSearchQuery != null);
        _releasesSearchQuery = releasesSearchQuery;
        notifyListeners();
    }

    SonarrReleasesHiding _releasesHidingType = SonarrReleasesHiding.ALL;
    SonarrReleasesHiding get releasesHidingType => _releasesHidingType;
    set releasesHidingType(SonarrReleasesHiding releasesHidingType) {
        assert(releasesHidingType != null);
        _releasesHidingType = releasesHidingType;
        notifyListeners();
    }

    SonarrReleasesSorting _releasesSortType = SonarrReleasesSorting.WEIGHT;
    SonarrReleasesSorting get releasesSortType => _releasesSortType;
    set releasesSortType(SonarrReleasesSorting releasesSortType) {
        assert(releasesSortType != null);
        _releasesSortType = releasesSortType;
        notifyListeners();
    }

    bool _releasesSortAscending = true;
    bool get releasesSortAscending => _releasesSortAscending;
    set releasesSortAscending(bool releasesSortAscending) {
        assert(releasesSortAscending != null);
        _releasesSortAscending = releasesSortAscending;
        notifyListeners();
    }

    ////////////////
    /// EPISODES ///
    ////////////////
    
    Map<int, Future<List<SonarrEpisode>>> _episodes = {};
    Map<int, Future<List<SonarrEpisode>>> get episodes => _episodes;
    void fetchEpisodes(BuildContext context, int seriesId) {
        assert(seriesId != null);
        if(context.read<SonarrState>().api != null)
            _episodes[seriesId] = context.read<SonarrState>().api.episode.getSeriesEpisodes(seriesId: seriesId);
        notifyListeners();
    }

    List<int> _selectedEpisodes = [];
    List<int> get selectedEpisodes => _selectedEpisodes;
    set selectedEpisodes(List<int> selectedEpisodes) {
        assert(selectedEpisodes != null);
        _selectedEpisodes = selectedEpisodes;
        notifyListeners();
    }
    void toggleSelectedEpisode(int id) {
        _selectedEpisodes.contains(id)
            ? _selectedEpisodes.remove(id)
            : _selectedEpisodes.add(id);
        notifyListeners();
    }
}
