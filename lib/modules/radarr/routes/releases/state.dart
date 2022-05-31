import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrReleasesState extends ChangeNotifier {
  Future<List<RadarrRelease>>? _releases;
  final int _movieId;

  RadarrReleasesState(BuildContext context, this._movieId) {
    if (context.read<RadarrState>().enabled)
      _releases =
          context.read<RadarrState>().api!.release.get(movieId: _movieId);
  }

  Future<List<RadarrRelease>>? get releases => _releases;
  void refreshReleases(BuildContext context) {
    if (context.read<RadarrState>().enabled)
      _releases =
          context.read<RadarrState>().api!.release.get(movieId: _movieId);
    notifyListeners();
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  set searchQuery(String searchQuery) {
    _searchQuery = searchQuery;
    notifyListeners();
  }

  RadarrReleasesFilter? _filterType =
      RadarrDatabase.DEFAULT_FILTERING_RELEASES.read();
  RadarrReleasesFilter get filterType => _filterType!;
  set filterType(RadarrReleasesFilter filterType) {
    _filterType = filterType;
    notifyListeners();
  }

  RadarrReleasesSorting? _sortType =
      RadarrDatabase.DEFAULT_SORTING_RELEASES.read();
  RadarrReleasesSorting get sortType => _sortType!;
  set sortType(RadarrReleasesSorting sortType) {
    _sortType = sortType;
    notifyListeners();
  }

  bool? _sortAscending =
      RadarrDatabase.DEFAULT_SORTING_RELEASES_ASCENDING.read();
  bool get sortAscending => _sortAscending!;
  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }
}
