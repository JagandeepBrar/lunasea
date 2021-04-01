import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAddSeriesState extends ChangeNotifier {
    SonarrAddSeriesState(BuildContext context, String query) {
        _searchQuery = query ?? '';
    }

    String _searchQuery;
    String get searchQuery => _searchQuery;
    set searchQuery(String searchQuery) {
        assert(searchQuery != null);
        _searchQuery = searchQuery;
        notifyListeners();
    }

    Future<List<SonarrSeriesLookup>> _lookup;
    Future<List<SonarrSeriesLookup>> get lookup => _lookup;
    void fetchLookup(BuildContext context) {
        if((context?.read<SonarrState>()?.enabled ?? false)) {
            _lookup = context.read<SonarrState>().api.seriesLookup.getSeriesLookup(term: _searchQuery);
        }
        notifyListeners();
    }
}
