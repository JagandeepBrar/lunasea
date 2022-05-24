import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrState extends LunaModuleState {
  LidarrState() {
    reset();
  }

  @override
  void reset() {}

  ///Catalogue Sticky Header Content
  String _searchCatalogueFilter = '';
  String get searchCatalogueFilter => _searchCatalogueFilter;
  set searchCatalogueFilter(String searchCatalogueFilter) {
    _searchCatalogueFilter = searchCatalogueFilter;
    notifyListeners();
  }

  LidarrCatalogueSorting _sortCatalogueType =
      LidarrCatalogueSorting.alphabetical;
  LidarrCatalogueSorting get sortCatalogueType => _sortCatalogueType;
  set sortCatalogueType(LidarrCatalogueSorting sortCatalogueType) {
    _sortCatalogueType = sortCatalogueType;
    notifyListeners();
  }

  bool _sortCatalogueAscending = true;
  bool get sortCatalogueAscending => _sortCatalogueAscending;
  set sortCatalogueAscending(bool sortCatalogueAscending) {
    _sortCatalogueAscending = sortCatalogueAscending;
    notifyListeners();
  }

  bool _hideUnmonitoredArtists = false;
  bool get hideUnmonitoredArtists => _hideUnmonitoredArtists;
  set hideUnmonitoredArtists(bool hideUnmonitoredArtists) {
    _hideUnmonitoredArtists = hideUnmonitoredArtists;
    notifyListeners();
  }

  ///Releases Sticky Header Content

  String _searchReleasesFilter = '';
  String get searchReleasesFilter => _searchReleasesFilter;
  set searchReleasesFilter(String searchReleasesFilter) {
    _searchReleasesFilter = searchReleasesFilter;
    notifyListeners();
  }

  LidarrReleasesSorting _sortReleasesType = LidarrReleasesSorting.weight;
  LidarrReleasesSorting get sortReleasesType => _sortReleasesType;
  set sortReleasesType(LidarrReleasesSorting sortReleasesType) {
    _sortReleasesType = sortReleasesType;
    notifyListeners();
  }

  bool _sortReleasesAscending = true;
  bool get sortReleasesAscending => _sortReleasesAscending;
  set sortReleasesAscending(bool sortReleasesAscending) {
    _sortReleasesAscending = sortReleasesAscending;
    notifyListeners();
  }

  bool _hideRejectedReleases = false;
  bool get hideRejectedReleases => _hideRejectedReleases;
  set hideRejectedReleases(bool hideRejectedReleases) {
    _hideRejectedReleases = hideRejectedReleases;
    notifyListeners();
  }

  /// Add New Series Content

  String _addSearchQuery = '';
  String get addSearchQuery => _addSearchQuery;
  set addSearchQuery(String addSearchQuery) {
    _addSearchQuery = addSearchQuery;
    notifyListeners();
  }
}
