import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrState extends LunaModuleState {
    RadarrState() {
        reset();
    }
    
    @override
    void reset() {
        _movies = null;
        _moviesLookup = null;
        _upcoming = null;
        _qualityProfiles = null;
        _tags = null;
        _moviesSearchQuery = '';
        _addSearchQuery = '';
        // Reinitialize
        resetProfile();
        resetQualityProfiles();
        resetTags();
        resetMovies();
        resetUpcoming();
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

    ////////////////////
    /// MOVIE LOOKUP ///
    ////////////////////
    
    String _addSearchQuery = '';
    String get addSearchQuery => _addSearchQuery;
    set addSearchQuery(String addSearchQuery) {
        assert(addSearchQuery != null);
        _addSearchQuery = addSearchQuery;
        notifyListeners();
    }

    Future<List<RadarrMovie>> _moviesLookup;
    Future<List<RadarrMovie>> get moviesLookup => _moviesLookup;
    void fetchMoviesLookup() {
        if(_api != null) _moviesLookup = _api.movieLookup.get(term: _addSearchQuery ?? '');
        notifyListeners();
    }

    ////////////////
    /// UPCOMING ///
    ////////////////
    
    Future<List<RadarrMovie>> _upcoming;
    Future<List<RadarrMovie>> get upcoming => _upcoming;

    void resetUpcoming() {
        if(_api != null) _upcoming = _api.movie.getAll().then((movies) {
            List<RadarrMovie> _missingOnly = movies.where((movie) => movie.monitored && !movie.hasFile).toList();
            // List of movies not yet released, but in cinemas, sorted by date
            List<RadarrMovie> _notYetReleased = [];
            List<RadarrMovie> _notYetInCinemas = [];
            _missingOnly.forEach((movie) {
                if(movie.lunaIsInCinemas && !movie.lunaIsReleased) _notYetReleased.add(movie);
                if(!movie.lunaIsInCinemas && !movie.lunaIsReleased) _notYetInCinemas.add(movie);
            });
            _notYetReleased.sort((a,b) => a.lunaCompareToByReleaseDate(b));
            _notYetInCinemas.sort((a,b) => a.lunaCompareToByInCinemas(b));
            // Concat and return full array
            return [
                ..._notYetReleased,
                ..._notYetInCinemas,
            ];
        });
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

    ////////////
    /// TAGS ///
    ////////////
    
    Future<List<RadarrTag>> _tags;
    Future<List<RadarrTag>> get tags => _tags;
    set tags(Future<List<RadarrTag>> tags) {
        assert(tags != null);
        _tags = tags;
        notifyListeners();
    }

    void resetTags() {
        if(_api != null) _tags = _api.tag.getAll();
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
            return highRes
                ? '$_base/$movieId/fanart.jpg?apikey=$_apiKey'
                : '$_base/$movieId/fanart-360.jpg?apikey=$_apiKey'; 
        }
        return null;
    }
}
