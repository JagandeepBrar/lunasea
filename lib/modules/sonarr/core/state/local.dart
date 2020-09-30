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
    void fetchseriesLookup(BuildContext context) {
        SonarrState _state = Provider.of<SonarrState>(context, listen: false);
        _seriesLookup = _state.api.seriesLookup.getSeriesLookup(term: _addSearchQuery);
        notifyListeners();
    }
}
