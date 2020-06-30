import 'package:flutter/foundation.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrModel extends ChangeNotifier {
    ///Catalogue Sticky Header Content

    String _searchCatalogueFilter = '';
    String get searchCatalogueFilter => _searchCatalogueFilter;
    set searchCatalogueFilter(String searchCatalogueFilter) {
        assert(searchCatalogueFilter != null);
        _searchCatalogueFilter = searchCatalogueFilter;
        notifyListeners();
    }

    LidarrCatalogueSorting _sortCatalogueType = LidarrCatalogueSorting.alphabetical;
    LidarrCatalogueSorting get sortCatalogueType => _sortCatalogueType;
    set sortCatalogueType(LidarrCatalogueSorting sortCatalogueType) {
        assert(sortCatalogueType != null);
        _sortCatalogueType = sortCatalogueType;
        notifyListeners();
    }

    bool _sortCatalogueAscending = true;
    bool get sortCatalogueAscending => _sortCatalogueAscending;
    set sortCatalogueAscending(bool sortCatalogueAscending) {
        assert(sortCatalogueAscending != null);
        _sortCatalogueAscending = sortCatalogueAscending;
        notifyListeners();
    }

    bool _hideUnmonitoredArtists = false;
    bool get hideUnmonitoredArtists => _hideUnmonitoredArtists;
    set hideUnmonitoredArtists(bool hideUnmonitoredArtists) {
        assert(hideUnmonitoredArtists != null);
        _hideUnmonitoredArtists = hideUnmonitoredArtists;
        notifyListeners();
    }

    bool _hideUnmonitoredAlbums = false;
    bool get hideUnmonitoredAlbums => _hideUnmonitoredAlbums;
    set hideUnmonitoredAlbums(bool hideUnmonitoredAlbums) {
        assert(hideUnmonitoredAlbums != null);
        _hideUnmonitoredAlbums = hideUnmonitoredAlbums;
        notifyListeners();
    }

    ///Releases Sticky Header Content

    String _searchReleasesFilter = '';
    String get searchReleasesFilter => _searchReleasesFilter;
    set searchReleasesFilter(String searchReleasesFilter) {
        assert(searchReleasesFilter != null);
        _searchReleasesFilter = searchReleasesFilter;
        notifyListeners();
    }

    LidarrReleasesSorting _sortReleasesType = LidarrReleasesSorting.weight;
    LidarrReleasesSorting get sortReleasesType => _sortReleasesType;
    set sortReleasesType(LidarrReleasesSorting sortReleasesType) {
        assert(sortReleasesType != null);
        _sortReleasesType = sortReleasesType;
        notifyListeners();
    }

    bool _sortReleasesAscending = true;
    bool get sortReleasesAscending => _sortReleasesAscending;
    set sortReleasesAscending(bool sortReleasesAscending) {
        assert(sortReleasesAscending != null);
        _sortReleasesAscending = sortReleasesAscending;
        notifyListeners();
    }

    bool _hideRejectedReleases = false;
    bool get hideRejectedReleases => _hideRejectedReleases;
    set hideRejectedReleases(bool hideRejectedReleases) {
        assert(hideRejectedReleases != null);
        _hideRejectedReleases = hideRejectedReleases;
        notifyListeners();
    }

    /// Add New Series Content

    String _addSearchQuery = '';
    String get addSearchQuery => _addSearchQuery;
    set addSearchQuery(String addSearchQuery) {
        assert(addSearchQuery != null);
        _addSearchQuery = addSearchQuery;
        notifyListeners();
    }

    int _navigationIndex = 0;
    int get navigationIndex => _navigationIndex;
    set navigationIndex(int navigationIndex) {
        assert(navigationIndex != null);
        _navigationIndex = navigationIndex;
        notifyListeners();
    }

    int _artistNavigationIndex = 0;
    int get artistNavigationIndex => _artistNavigationIndex;
    set artistNavigationIndex(int artistNavigationIndex) {
        assert(artistNavigationIndex != null);
        _artistNavigationIndex = artistNavigationIndex;
        notifyListeners();
    }
}
