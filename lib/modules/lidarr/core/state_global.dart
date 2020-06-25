import 'package:flutter/foundation.dart';
import 'package:lunasea/modules.dart';

class LidarrModel extends ChangeNotifier {
    String _searchFilter = '';
    String get searchFilter => _searchFilter;
    set searchFilter(String searchFilter) {
        assert(searchFilter != null);
        _searchFilter = searchFilter;
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
