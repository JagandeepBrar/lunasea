import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrState extends ChangeNotifier {
    SonarrState() {
        reset(initialize: true);
    }
    
    /// Reset the state of Sonarr back to the default
    /// 
    /// If `initialize` is true, resets everything, else it resets the profile + data.
    /// If false, the navigation index, etc. are not reset.
    void reset({ bool initialize = false }) {
        if(initialize) {}
        resetProfile();
        notifyListeners();
    }
    
    GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
    GlobalKey<ScaffoldState> rootScaffoldKey = GlobalKey<ScaffoldState>();

    /**********
    * PROFILE *
    **********/

    /// API handler instance
    SonarrAPI _api;
    SonarrAPI get api => _api;

    /// Is the API enabled?
    bool _enabled;
    bool get enabled => _enabled;

    /// Sonarr host
    String _host;
    String get host => _host;

    /// Sonarr API key
    String _apiKey;
    String get apiKey => _apiKey;

    /// Headers to attach to all requests
    Map<dynamic, dynamic> _headers;
    Map<dynamic, dynamic> get headers => _headers;

    /// Reset the profile data, reinitializes API instance
    void resetProfile() {
        ProfileHiveObject _profile = Database.currentProfileObject;
        // Copy profile into state
        _enabled = _profile.sonarrEnabled ?? false;
        _host = _profile.sonarrHost ?? '';
        _apiKey = _profile.sonarrKey ?? '';
        _headers = _profile.sonarrHeaders ?? {};
        // Create the API instance if Sonarr is enabled
        _api = _enabled
            ? SonarrAPI.from(Database.currentProfileObject)
            : null;
    }

    /// OLD

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
