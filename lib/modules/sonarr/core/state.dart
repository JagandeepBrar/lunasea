import 'package:flutter/foundation.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrModel extends ChangeNotifier {
    SonarrModel() {
        _catalogue = FutureContainer<List<SonarrCatalogueData>>(() => notifyListeners());
        _missing = FutureContainer<List<SonarrMissingData>>(() => notifyListeners());
        _upcoming = FutureContainer<List<SonarrUpcomingData>>(() => notifyListeners());
        _history = FutureContainer<List<SonarrHistoryData>>(() => notifyListeners());
    }
    
    FutureContainer<List<SonarrCatalogueData>> _catalogue;
    FutureContainer<List<SonarrCatalogueData>> get catalogue => _catalogue;
    FutureContainer<List<SonarrMissingData>> _missing;
    FutureContainer<List<SonarrMissingData>> get missing => _missing;
    FutureContainer<List<SonarrUpcomingData>> _upcoming;
    FutureContainer<List<SonarrUpcomingData>> get upcoming => _upcoming;
    FutureContainer<List<SonarrHistoryData>> _history;
    FutureContainer<List<SonarrHistoryData>> get history => _history;

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

    bool _hideUnmonitoredSeries = false;
    bool get hideUnmonitoredSeries => _hideUnmonitoredSeries;
    set hideUnmonitoredSeries(bool hideUnmonitoredSeries) {
        assert(hideUnmonitoredSeries != null);
        _hideUnmonitoredSeries = hideUnmonitoredSeries;
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

    int _seriesNavigationIndex = 1;
    int get seriesNavigationIndex => _seriesNavigationIndex;
    set seriesNavigationIndex(int seriesNavigationIndex) {
        assert(seriesNavigationIndex != null);
        _seriesNavigationIndex = seriesNavigationIndex;
        notifyListeners();
    }
}
