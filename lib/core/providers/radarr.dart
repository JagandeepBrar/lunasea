import 'package:flutter/foundation.dart';
import 'package:lunasea/core/api.dart';

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

    RadarrRootFolder _addRootFolder;
    RadarrRootFolder get addRootFolder => _addRootFolder;
    set addRootFolder(RadarrRootFolder addRootFolder) {
        assert(addRootFolder != null);
        _addRootFolder = addRootFolder;
        notifyListeners();
    }
    
    RadarrQualityProfile _addQualityProfile;
    RadarrQualityProfile get addQualityProfile => _addQualityProfile;
    set addQualityProfile(RadarrQualityProfile addQualityProfile) {
        assert(addQualityProfile != null);
        _addQualityProfile = addQualityProfile;
        notifyListeners();
    }

    RadarrAvailability _addAvailability;
    RadarrAvailability get addAvailability => _addAvailability;
    set addAvailability(RadarrAvailability addAvailability) {
        assert(addAvailability != null);
        _addAvailability = addAvailability;
        notifyListeners();
    }
}
