import 'package:flutter/foundation.dart';

class RadarrModel extends ChangeNotifier {
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

    bool _hideUnmonitoredMovies = false;
    bool get hideUnmonitoredMovies => _hideUnmonitoredMovies;
    set hideUnmonitoredMovies(bool hideUnmonitoredMovies) {
        assert(hideUnmonitoredMovies != null);
        _hideUnmonitoredMovies = hideUnmonitoredMovies;
        notifyListeners();
    }
    
    String _addSearchQuery = '';
    String get addSearchQuery => _addSearchQuery;
    set addSearchQuery(String addSearchQuery) {
        assert(addSearchQuery != null);
        _addSearchQuery = addSearchQuery;
        notifyListeners();
    }
}
