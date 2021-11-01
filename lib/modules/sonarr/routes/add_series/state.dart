import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAddSeriesState extends ChangeNotifier {
  SonarrAddSeriesState(BuildContext context, String query) {
    _searchQuery = query ?? '';
    fetchExclusions(context);
  }

  String _searchQuery;
  String get searchQuery => _searchQuery;
  set searchQuery(String searchQuery) {
    assert(searchQuery != null);
    _searchQuery = searchQuery;
    notifyListeners();
  }

  Future<List<SonarrSeries>> _lookup;
  Future<List<SonarrSeries>> get lookup => _lookup;
  void fetchLookup(BuildContext context) {
    if (context.read<SonarrState>().enabled ?? false) {
      _lookup =
          context.read<SonarrState>().api.seriesLookup.get(term: _searchQuery);
    }
    notifyListeners();
  }

  Future<List<SonarrExclusion>> _exclusions;
  Future<List<SonarrExclusion>> get exclusions => _exclusions;
  void fetchExclusions(BuildContext context) {
    if ((context.read<SonarrState>().enabled ?? false)) {
      _exclusions =
          context.read<SonarrState>().api.importList.getExclusionList();
    }
    notifyListeners();
  }
}
