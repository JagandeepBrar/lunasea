import 'package:flutter/foundation.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrModel extends ChangeNotifier {
    ///Catalogue Sticky Header Content

    String _searchCatalogueFilter = '';
    String get searchCatalogueFilter => _searchCatalogueFilter;
    set searchCatalogueFilter(String searchCatalogueFilter) {
        assert(searchCatalogueFilter != null);
        _searchCatalogueFilter = searchCatalogueFilter;
        notifyListeners();
    }

    SonarrCatalogueSorting _sortCatalogueType = SonarrCatalogueSorting.alphabetical;
    SonarrCatalogueSorting get sortCatalogueType => _sortCatalogueType;
    set sortCatalogueType(SonarrCatalogueSorting sortCatalogueType) {
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

    bool _hideUnmonitoredSeries = false;
    bool get hideUnmonitoredSeries => _hideUnmonitoredSeries;
    set hideUnmonitoredSeries(bool hideUnmonitoredSeries) {
        assert(hideUnmonitoredSeries != null);
        _hideUnmonitoredSeries = hideUnmonitoredSeries;
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

    SonarrReleasesSorting _sortReleasesType = SonarrReleasesSorting.weight;
    SonarrReleasesSorting get sortReleasesType => _sortReleasesType;
    set sortReleasesType(SonarrReleasesSorting sortReleasesType) {
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

    ///Navigation Indexes

    int _navigationIndex = 0;
    int get navigationIndex => _navigationIndex;
    set navigationIndex(int navigationIndex) {
        assert(navigationIndex != null);
        _navigationIndex = navigationIndex;
        notifyListeners();
    }

    int _seriesNavigationIndex = 1;
    int get seriesNavigationIndex => _seriesNavigationIndex;
    set seriesNavigationIndex(int seriesNavigationIndex) {
        assert(seriesNavigationIndex != null);
        _seriesNavigationIndex = seriesNavigationIndex;
        notifyListeners();
    }
}
