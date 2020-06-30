import 'package:flutter/foundation.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrModel extends ChangeNotifier {
    ///Catalogue Sticky Header Content

    String _searchCatalogueFilter = '';
    String get searchCatalogueFilter => _searchCatalogueFilter;
    set searchCatalogueFilter(String searchCatalogueFilter) {
        assert(searchCatalogueFilter != null);
        _searchCatalogueFilter = searchCatalogueFilter;
        notifyListeners();
    }


    RadarrCatalogueSorting _sortCatalogueType = RadarrCatalogueSorting.alphabetical;
    RadarrCatalogueSorting get sortCatalogueType => _sortCatalogueType;
    set sortCatalogueType(RadarrCatalogueSorting sortCatalogueType) {
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

    bool _hideUnmonitoredMovies = false;
    bool get hideUnmonitoredMovies => _hideUnmonitoredMovies;
    set hideUnmonitoredMovies(bool hideUnmonitoredMovies) {
        assert(hideUnmonitoredMovies != null);
        _hideUnmonitoredMovies = hideUnmonitoredMovies;
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

    RadarrReleasesSorting _sortReleasesType = RadarrReleasesSorting.weight;
    RadarrReleasesSorting get sortReleasesType => _sortReleasesType;
    set sortReleasesType(RadarrReleasesSorting sortReleasesType) {
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

    ///Add New Movie Content
    
    String _addSearchQuery = '';
    String get addSearchQuery => _addSearchQuery;
    set addSearchQuery(String addSearchQuery) {
        assert(addSearchQuery != null);
        _addSearchQuery = addSearchQuery;
        notifyListeners();
    }

    ///Navigation Indexes

    int _navigationIndex = 0;
    int get navigationIndex => _navigationIndex;
    set navigationIndex(int navigationIndex) {
        assert(navigationIndex != null);
        _navigationIndex = navigationIndex;
        notifyListeners();
    }

    int _movieNavigationIndex = 0;
    int get movieNavigationIndex => _movieNavigationIndex;
    set movieNavigationIndex(int movieNavigationIndex) {
        assert(movieNavigationIndex != null);
        _movieNavigationIndex = movieNavigationIndex;
        notifyListeners();
    }
}
