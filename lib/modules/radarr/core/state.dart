import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrState extends LunaModuleState {
    RadarrState() {
        reset();
    }
    
    @override
    void reset() {
        _movies = null;
        _qualityProfiles = null;
        // Reinitialize
        resetProfile();
        resetQualityProfiles();
        resetMovies();
        notifyListeners();
    }

    ///////////////
    /// PROFILE ///
    ///////////////

    /// API handler instance
    Radarr _api;
    Radarr get api => _api;

    /// Is the API enabled?
    bool _enabled;
    bool get enabled => _enabled;
    
    /// Radarr host
    String _host;
    String get host => _host;

    /// Radarr API key
    String _apiKey;
    String get apiKey => _apiKey;

    /// Headers to attach to all requests
    Map<dynamic, dynamic> _headers;
    Map<dynamic, dynamic> get headers => _headers;

    /// Reset the profile data, reinitializes API instance
    void resetProfile() {
        ProfileHiveObject _profile = Database.currentProfileObject;
        // Copy profile into state
        _enabled = _profile.radarrEnabled ?? false;
        _host = _profile.radarrHost ?? '';
        _apiKey = _profile.radarrKey ?? '';
        _headers = _profile.radarrHeaders ?? {};
        // Create the API instance if Radarr is enabled
        _api = _enabled
            ? Radarr(
                host: _host,
                apiKey: _apiKey,
                headers: Map<String, dynamic>.from(_headers),
            )
            : null;
    }

    //////////////
    /// MOVIES ///
    //////////////
    
    String _moviesSearchQuery = '';
    String get moviesSearchQuery => _moviesSearchQuery;
    set moviesSearchQuery(String moviesSearchQuery) {
        assert(moviesSearchQuery != null);
        _moviesSearchQuery = moviesSearchQuery;
        notifyListeners();
    }

    RadarrMoviesSorting _moviesSortType = RadarrDatabaseValue.DEFAULT_SORTING_MOVIES.data;
    RadarrMoviesSorting get moviesSortType => _moviesSortType;
    set moviesSortType(RadarrMoviesSorting moviesSortType) {
        assert(moviesSortType != null);
        _moviesSortType = moviesSortType;
        notifyListeners();
    }

    RadarrMoviesFilter _moviesFilterType = RadarrMoviesFilter.ALL;
    RadarrMoviesFilter get moviesFilterType => _moviesFilterType;
    set moviesFilterType(RadarrMoviesFilter moviesFilterType) {
        assert(moviesFilterType != null);
        _moviesFilterType = moviesFilterType;
        notifyListeners();
    }

    bool _moviesSortAscending = RadarrDatabaseValue.DEFAULT_SORTING_MOVIES_ASCENDING.data;
    bool get moviesSortAscending => _moviesSortAscending;
    set moviesSortAscending(bool moviesSortAscending) {
        assert(moviesSortAscending != null);
        _moviesSortAscending = moviesSortAscending;
        notifyListeners();
    }
    
    Future<List<RadarrMovie>> _movies;
    Future<List<RadarrMovie>> get movies => _movies;
    set movies(Future<List<RadarrMovie>> movies) {
        assert(movies != null);
        _movies = movies;
        notifyListeners();
    }

    void resetMovies() {
        if(_api != null) _movies = _api.movie.getAll();
        notifyListeners();
    }

    ////////////////
    /// PROFILES ///
    ////////////////
    
    Future<List<RadarrQualityProfile>> _qualityProfiles;
    Future<List<RadarrQualityProfile>> get qualityProfiles => _qualityProfiles;
    set qualityProfiles(Future<List<RadarrQualityProfile>> qualityProfiles) {
        assert(qualityProfiles != null);
        _qualityProfiles = qualityProfiles;
        notifyListeners();
    }

    void resetQualityProfiles() {
        if(_api != null) _qualityProfiles = _api.qualityProfile.getAll();
        notifyListeners();
    }

    //////////////
    /// IMAGES ///
    //////////////
    
    String getPosterURL(int movieId, { bool highRes = false }) {
        if(_enabled) {
            String _base = _host.endsWith('/') ? '${_host}api/v3/MediaCover' : '$_host/api/v3/MediaCover';
            return highRes
                ? '$_base/$movieId/poster.jpg?apikey=$_apiKey'
                : '$_base/$movieId/poster-500.jpg?apikey=$_apiKey'; 
        }
        return null;
    }

    String getBannerURL(int movieId, { bool highRes = false }) {
        if(_enabled) {
            String _base = _host.endsWith('/') ? '${_host}api/v3/MediaCover' : '$_host/api/v3/MediaCover';
            return highRes
                ? '$_base/$movieId/banner.jpg?apikey=$_apiKey'
                : '$_base/$movieId/banner-70.jpg?apikey=$_apiKey'; 
        }
        return null;
    }

    String getFanartURL(int movieId, { bool highRes = false }) {
        if(_enabled) {
            String _base = _host.endsWith('/') ? '${_host}api/v3/MediaCover' : '$_host/api/v3/MediaCover';
            print('$_base/$movieId/fanart-360.jpg?apikey=$_apiKey');
            return highRes
                ? '$_base/$movieId/fanart.jpg?apikey=$_apiKey'
                : '$_base/$movieId/fanart-360.jpg?apikey=$_apiKey'; 
        }
        return null;
    }
}
