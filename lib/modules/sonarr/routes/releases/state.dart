import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesState extends ChangeNotifier {
  final int? seriesId;
  final int? seasonNumber;
  final int? episodeId;

  SonarrReleasesState({
    required BuildContext context,
    this.seriesId,
    this.seasonNumber,
    this.episodeId,
  }) {
    refreshReleases(context);
  }

  Future<List<SonarrRelease>>? _releases;
  Future<List<SonarrRelease>>? get releases => _releases;
  void refreshReleases(BuildContext context) {
    if (context.read<SonarrState>().enabled) {
      if (episodeId != null) {
        _releases =
            context.read<SonarrState>().api!.release.get(episodeId: episodeId!);
      } else if (seriesId != null && seasonNumber != null) {
        _releases = context
            .read<SonarrState>()
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

  SonarrReleasesFilter? _filterType =
      SonarrDatabase.DEFAULT_FILTERING_RELEASES.read();
  SonarrReleasesFilter get filterType => _filterType!;
  set filterType(SonarrReleasesFilter filterType) {
    _filterType = filterType;
    notifyListeners();
  }

  SonarrReleasesSorting? _sortType =
      SonarrDatabase.DEFAULT_SORTING_RELEASES.read();
  SonarrReleasesSorting get sortType => _sortType!;
  set sortType(SonarrReleasesSorting sortType) {
    _sortType = sortType;
    notifyListeners();
  }

  bool? _sortAscending =
      SonarrDatabase.DEFAULT_SORTING_RELEASES_ASCENDING.read();
  bool get sortAscending => _sortAscending!;
  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }
}
