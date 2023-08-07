import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarReleasesState extends ChangeNotifier {
  final int? seriesId;
  final int? seasonNumber;
  final int? episodeId;

  MylarReleasesState({
    required BuildContext context,
    this.seriesId,
    this.seasonNumber,
    this.episodeId,
  }) {
    refreshReleases(context);
  }

  Future<List<MylarRelease>>? _releases;
  Future<List<MylarRelease>>? get releases => _releases;
  void refreshReleases(BuildContext context) {
    if (context.read<MylarState>().enabled) {
      if (episodeId != null) {
        _releases =
            context.read<MylarState>().api!.release.get(episodeId: episodeId!);
      } else if (seriesId != null && seasonNumber != null) {
        _releases = context
            .read<MylarState>()
            .api!
            .release
            .getSeasonPack(seriesId: seriesId!, seasonNumber: seasonNumber!)
            .then((releases) => releases.where((r) => r.fullSeason!).toList());
      } else {
        throw Exception(
            'Must supply either episodeId or seriesId and seasonNumber');
      }
    }
    notifyListeners();
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  set searchQuery(String searchQuery) {
    _searchQuery = searchQuery;
    notifyListeners();
  }

  MylarReleasesFilter? _filterType =
      MylarDatabase.DEFAULT_FILTERING_RELEASES.read();
  MylarReleasesFilter get filterType => _filterType!;
  set filterType(MylarReleasesFilter filterType) {
    _filterType = filterType;
    notifyListeners();
  }

  MylarReleasesSorting? _sortType =
      MylarDatabase.DEFAULT_SORTING_RELEASES.read();
  MylarReleasesSorting get sortType => _sortType!;
  set sortType(MylarReleasesSorting sortType) {
    _sortType = sortType;
    notifyListeners();
  }

  bool? _sortAscending =
      MylarDatabase.DEFAULT_SORTING_RELEASES_ASCENDING.read();
  bool get sortAscending => _sortAscending!;
  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }
}
