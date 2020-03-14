import 'package:flutter/foundation.dart';

class LidarrModel extends ChangeNotifier {
    String _searchFilter = '';
    String get searchFilter => _searchFilter;
    set searchFilter(String searchFilter) {
        assert(searchFilter != null);
        _searchFilter = searchFilter;
        notifyListeners();
    }

    String _sortType = 'abc';
    String get sortType => _sortType;
    set sortType(String sortType) {
        assert(sortType != null);
        _sortType = sortType;
        notifyListeners();
    }

    bool _sortAscending = true;
    bool get sortAscending => _sortAscending;
    set sortAscending(bool sortAscending) {
        assert(sortAscending != null);
        _sortAscending = sortAscending;
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
}
