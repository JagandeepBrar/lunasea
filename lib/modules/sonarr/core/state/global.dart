import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrState extends LunaGlobalState {
    SonarrState() {
        reset();
    }
    
    @override
    void reset() {
        _series = null;
        _qualityProfiles = null;
        _languageProfiles = null;
        resetProfile();
        resetSeries();
        resetMissing();
        resetQualityProfiles();
        resetLanguageProfiles();
        resetTags();
        notifyListeners();
    }
    
    GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
    GlobalKey<ScaffoldState> rootScaffoldKey = GlobalKey<ScaffoldState>();

    ///////////////
    /// PROFILE ///
    ///////////////

    /// API handler instance
    Sonarr _api;
    Sonarr get api => _api;

    /// Is the API enabled?
    bool _enabled;
    bool get enabled => _enabled;
    
    bool _enableVersion3;
    bool get enableVersion3 => _enableVersion3;

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
        _enableVersion3 = _profile.sonarrVersion3 ?? false;
        _host = _profile.sonarrHost ?? '';
        _apiKey = _profile.sonarrKey ?? '';
        _headers = _profile.sonarrHeaders ?? {};
        // Create the API instance if Sonarr is enabled
        _api = _enabled
            ? Sonarr(
                host: _host,
                apiKey: _apiKey,
                headers: Map<String, dynamic>.from(_headers),
            )
            : null;
    }

    //////////////
    /// SERIES ///
    //////////////

    SonarrSeriesSorting _seriesSortType = SonarrSeriesSorting.ALPHABETICAL;
    SonarrSeriesSorting get seriesSortType => _seriesSortType;
    set seriesSortType(SonarrSeriesSorting seriesSortType) {
        assert(seriesSortType != null);
        _seriesSortType = seriesSortType;
        notifyListeners();
    }

    SonarrSeriesHiding _seriesHidingType = SonarrSeriesHiding.ALL;
    SonarrSeriesHiding get seriesHidingType => _seriesHidingType;
    set seriesHidingType(SonarrSeriesHiding seriesHidingType) {
        assert(seriesHidingType != null);
        _seriesHidingType = seriesHidingType;
        notifyListeners();
    }

    bool _seriesSortAscending = true;
    bool get seriesSortAscending => _seriesSortAscending;
    set seriesSortAscending(bool seriesSortAscending) {
        assert(seriesSortAscending != null);
        _seriesSortAscending = seriesSortAscending;
        notifyListeners();
    }
    
    Future<List<SonarrSeries>> _series;
    Future<List<SonarrSeries>> get series => _series;
    set series(Future<List<SonarrSeries>> series) {
        assert(series != null);
        _series = series;
        notifyListeners();
    }

    void resetSeries() {
        if(_api != null) _series = _api.series.getAllSeries();
        notifyListeners();
    }

    ///////////////
    /// MISSING ///
    ///////////////
    
    Future<SonarrMissing> _missing;
    Future<SonarrMissing> get missing => _missing;
    set missing(Future<SonarrMissing> missing) {
        assert(missing != null);
        _missing = missing;
        notifyListeners();
    }

    void resetMissing() {
        if(_api != null) _missing = _api.wanted.getMissing(
            pageSize: SonarrDatabaseValue.CONTENT_LOAD_LENGTH.data,
            sortDir: SonarrSortDirection.DESCENDING,
            sortKey: SonarrWantedMissingSortKey.AIRDATE_UTC,
        );
        notifyListeners();
    }


    ////////////////
    /// PROFILES ///
    ////////////////
    
    Future<List<SonarrQualityProfile>> _qualityProfiles;
    Future<List<SonarrQualityProfile>> get qualityProfiles => _qualityProfiles;
    set qualityProfiles(Future<List<SonarrQualityProfile>> qualityProfiles) {
        assert(qualityProfiles != null);
        _qualityProfiles = qualityProfiles;
        notifyListeners();
    }

    void resetQualityProfiles() {
        if(_api != null) _qualityProfiles = _api.profile.getQualityProfiles();
        notifyListeners();
    }

    Future<List<SonarrLanguageProfile>> _languageProfiles;
    Future<List<SonarrLanguageProfile>> get languageProfiles => _languageProfiles;
    set languageProfiles(Future<List<SonarrLanguageProfile>> languageProfiles) {
        assert(languageProfiles != null);
        _languageProfiles = languageProfiles;
        notifyListeners();
    }

    void resetLanguageProfiles() {
        if(_api != null && _enableVersion3) _languageProfiles = _api.profile.getLanguageProfiles();
        notifyListeners();
    }

    ////////////
    /// TAGS ///
    ////////////
    
    Future<List<SonarrTag>> _tags;
    Future<List<SonarrTag>> get tags => _tags;
    set tags(Future<List<SonarrTag>> tags) {
        assert(tags != null);
        _tags = tags;
        notifyListeners();
    }

    void resetTags() {
        if(_api != null) _tags = _api.tag.getTags();
        notifyListeners();
    }

    /////////////////////
    /// DELETE SERIES ///
    /////////////////////
    
    bool _removeSeriesDeleteFiles = false;
    bool get removeSeriesDeleteFiles => _removeSeriesDeleteFiles;
    set removeSeriesDeleteFiles(bool removeSeriesDeleteFiles) {
        assert(removeSeriesDeleteFiles != null);
        _removeSeriesDeleteFiles = removeSeriesDeleteFiles;
        notifyListeners();
    }

    //////////////
    /// IMAGES ///
    //////////////

    String getBannerURL(int seriesId, { bool highRes = false }) {
        if(_enabled) {
            String _base = _host.endsWith('/') ? '${_host}api/MediaCover' : '$_host/api/MediaCover';
            return highRes
                ? '$_base/$seriesId/banner.jpg?apikey=$_apiKey'
                : '$_base/$seriesId/banner-70.jpg?apikey=$_apiKey'; 
        }
        return null;
    }

    String getPosterURL(int seriesId, { bool highRes = false }) {
        if(_enabled) {
            String _base = _host.endsWith('/') ? '${_host}api/MediaCover' : '$_host/api/MediaCover';
            return highRes
                ? '$_base/$seriesId/poster.jpg?apikey=$_apiKey'
                : '$_base/$seriesId/poster-500.jpg?apikey=$_apiKey'; 
        }
        return null;
    }

    String getFanartURL(int seriesId, { bool highRes = false }) {
        if(_enabled) {
            String _base = _host.endsWith('/') ? '${_host}api/MediaCover' : '$_host/api/MediaCover';
            return highRes
                ? '$_base/$seriesId/fanart.jpg?apikey=$_apiKey'
                : '$_base/$seriesId/fanart-360.jpg?apikey=$_apiKey'; 
        }
        return null;
    }
}
