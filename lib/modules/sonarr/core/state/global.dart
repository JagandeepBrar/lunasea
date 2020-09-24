import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrState extends ChangeNotifier implements LunaGlobalState {
    SonarrState() {
        reset();
    }
    
    @override
    void reset() {
        resetProfile();
        resetSeries();
        notifyListeners();
    }
    
    GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
    GlobalKey<ScaffoldState> rootScaffoldKey = GlobalKey<ScaffoldState>();

    /**********
    * PROFILE *
    **********/

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

    SonarrSeriesSorting _seriesSortType = SonarrSeriesSorting.alphabetical;
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

    //////////////
    /// IMAGES ///
    //////////////

    String getBannerURL({ @required int seriesId, bool highRes = false }) {
        if(_enabled) {
            String _base = _host.endsWith('/') ? '${_host}api/MediaCover' : '$_host/api/MediaCover';
            return highRes
                ? '$_base/$seriesId/banner.jpg?apikey=$_apiKey'
                : '$_base/$seriesId/banner-70.jpg?apikey=$_apiKey'; 
        }
        return null;
    }

    String getPosterURL({ @required int seriesId, bool highRes = false }) {
        if(_enabled) {
            String _base = _host.endsWith('/') ? '${_host}api/MediaCover' : '$_host/api/MediaCover';
            return highRes
                ? '$_base/$seriesId/poster.jpg?apikey=$_apiKey'
                : '$_base/$seriesId/poster-500.jpg?apikey=$_apiKey'; 
        }
        return null;
    }

    String getFanartURL({ @required int seriesId, bool highRes = false }) {
        if(_enabled) {
            String _base = _host.endsWith('/') ? '${_host}api/MediaCover' : '$_host/api/MediaCover';
            return highRes
                ? '$_base/$seriesId/fanart.jpg?apikey=$_apiKey'
                : '$_base/$seriesId/fanart-360.jpg?apikey=$_apiKey'; 
        }
        return null;
    }
}
