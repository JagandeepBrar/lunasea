import 'package:flutter/foundation.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrModel extends ChangeNotifier {
    SonarrModel() {
        _catalogue = StateFutureContainer<List<SonarrCatalogueData>>(() => notifyListeners());
        _missing = StateFutureContainer<List<SonarrMissingData>>(() => notifyListeners());
        _upcoming = StateFutureContainer<List<SonarrUpcomingData>>(() => notifyListeners());
        _history = StateFutureContainer<List<SonarrHistoryData>>(() => notifyListeners());
    }
    
    StateFutureContainer<List<SonarrCatalogueData>> _catalogue;
    StateFutureContainer<List<SonarrCatalogueData>> get catalogue => _catalogue;
    StateFutureContainer<List<SonarrMissingData>> _missing;
    StateFutureContainer<List<SonarrMissingData>> get missing => _missing;
    StateFutureContainer<List<SonarrUpcomingData>> _upcoming;
    StateFutureContainer<List<SonarrUpcomingData>> get upcoming => _upcoming;
    StateFutureContainer<List<SonarrHistoryData>> _history;
    StateFutureContainer<List<SonarrHistoryData>> get history => _history;

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

    SonarrRootFolder _addRootFolder;
    SonarrRootFolder get addRootFolder => _addRootFolder;
    set addRootFolder(SonarrRootFolder addRootFolder) {
        assert(addRootFolder != null);
        _addRootFolder = addRootFolder;
        notifyListeners();
    }

    SonarrQualityProfile _addQualityProfile;
    SonarrQualityProfile get addQualityProfile => _addQualityProfile;
    set addQualityProfile(SonarrQualityProfile addQualityProfile) {
        assert(addQualityProfile != null);
        _addQualityProfile = addQualityProfile;
        notifyListeners();
    }

    SonarrSeriesType _addSeriesType;
    SonarrSeriesType get addSeriesType => _addSeriesType;
    set addSeriesType(SonarrSeriesType addSeriesType) {
        assert(addSeriesType != null);
        _addSeriesType = addSeriesType;
        notifyListeners();
    }

    int _navigationIndex = 0;
    int get navigationIndex => _navigationIndex;
    set navigationIndex(int navigationIndex) {
        assert(navigationIndex != null);
        _navigationIndex = navigationIndex;
        notifyListeners();
    }
}
