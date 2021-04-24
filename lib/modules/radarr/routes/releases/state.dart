import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrReleasesState extends ChangeNotifier {
  Future<List<RadarrRelease>> _releases;
  final int _movieId;

  RadarrReleasesState(BuildContext context, this._movieId) {
    if (context.read<RadarrState>().enabled)
      _releases =
          context.read<RadarrState>().api.release.get(movieId: _movieId);
  }

  Future<List<RadarrRelease>> get releases => _releases;
  void refreshReleases(BuildContext context) {
    if (context.read<RadarrState>().enabled)
      _releases =
          context.read<RadarrState>().api.release.get(movieId: _movieId);
    notifyListeners();
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  set searchQuery(String searchQuery) {
    assert(searchQuery != null);
    _searchQuery = searchQuery;
    notifyListeners();
  }

  RadarrReleasesFilter _filterType =
      RadarrDatabaseValue.DEFAULT_FILTERING_RELEASES.data;
  RadarrReleasesFilter get filterType => _filterType;
  set filterType(RadarrReleasesFilter filterType) {
    assert(filterType != null);
    _filterType = filterType;
    notifyListeners();
  }

  RadarrReleasesSorting _sortType =
      RadarrDatabaseValue.DEFAULT_SORTING_RELEASES.data;
  RadarrReleasesSorting get sortType => _sortType;
  set sortType(RadarrReleasesSorting sortType) {
    assert(sortType != null);
    _sortType = sortType;
    notifyListeners();
  }

  bool _sortAscending =
      RadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data;
  bool get sortAscending => _sortAscending;
  set sortAscending(bool sortAscending) {
    assert(sortAscending != null);
    _sortAscending = sortAscending;
    notifyListeners();
  }
}
