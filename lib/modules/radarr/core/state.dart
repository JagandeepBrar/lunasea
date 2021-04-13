import 'dart:async';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrState extends LunaModuleState {
    RadarrState() {
        reset();
    }

    @override
    void dispose() {
        _getQueueTimer?.cancel();
        super.dispose();
    }
    
    @override
    void reset() {
        // Reset stored data
        _movies = null;
        _upcoming = null;
        _missing = null;
        _rootFolders = null;
        _qualityProfiles = null;
        _qualityDefinitions = null;
        _languages = null;
        _tags = null;
        _queue = null;
        // Reinitialize
        resetProfile();
        if(_enabled) {
            fetchRootFolders();
            fetchQualityProfiles();
            fetchQualityDefinitions();
            fetchLanguages();
            fetchTags();
            fetchMovies();
            fetchQueue();
        }
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
        _api = !_enabled ? null : Radarr(
            host: _host,
            apiKey: _apiKey,
            headers: Map<String, dynamic>.from(_headers),
        );
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

    RadarrMoviesFilter _moviesFilterType = RadarrDatabaseValue.DEFAULT_FILTERING_MOVIES.data;
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
    void fetchMovies() {
        if(_api != null) {
            _movies = _api.movie.getAll();
            _fetchUpcoming();
            _fetchMissing();
        }
        notifyListeners();
    }

    Future<void> resetSingleMovie(int movieId) async {
        assert(movieId != null);
        if(_api != null) {
            RadarrMovie movie = await _api.movie.get(movieId: movieId);
            List<RadarrMovie> allMovies = await _movies;
            int index = allMovies?.indexWhere((m) => m.id == movieId) ?? -1;
            index >= 0 ? allMovies[index] = movie : allMovies.add(movie);
            _fetchUpcoming();
            _fetchMissing();
        }
        notifyListeners();
    }

    Future<void> setSingleMovie(RadarrMovie movie) async {
        assert(movie != null);
        List<RadarrMovie> allMovies = await _movies;
        int index = allMovies?.indexWhere((m) => m.id == movie.id) ?? -1;
        index >= 0 ? allMovies[index] = movie : allMovies.add(movie);
        _fetchUpcoming();
        _fetchMissing();
        notifyListeners();
    }

    Future<List<RadarrRootFolder>> _rootFolders;
    Future<List<RadarrRootFolder>> get rootFolders => _rootFolders;
    void fetchRootFolders() {
        if(_enabled ?? false) _rootFolders = _api.rootFolder.get();
        notifyListeners();
    }

    ////////////////
    /// UPCOMING ///
    ////////////////
    
    Future<List<RadarrMovie>> _upcoming;
    Future<List<RadarrMovie>> get upcoming => _upcoming;
    void _fetchUpcoming() {
        if(_movies != null) _upcoming = _movies.then((movies) {
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
    }

    ///////////////
    /// MISSING ///
    ///////////////

    Future<List<RadarrMovie>> _missing;
    Future<List<RadarrMovie>> get missing => _missing;
    void _fetchMissing() {
        if(_movies != null) _missing = _movies.then((movies) {
            List<RadarrMovie> _movies = movies.where((movie) {
                if(!movie.monitored) return false;
                if(movie.hasFile || movie.movieFile != null) return false;
                if(!movie.lunaIsReleased) return false;
                return true;
            }).toList();
            _movies.sort((a,b) {
                int _comparison;
                if(a.lunaEarlierReleaseDate == null && b.lunaEarlierReleaseDate != null) return 1;
                if(b.lunaEarlierReleaseDate == null && a.lunaEarlierReleaseDate != null) return -1;
                if(a.lunaEarlierReleaseDate == null && b.lunaEarlierReleaseDate == null) _comparison = 0;
                if(_comparison == null) _comparison = b.lunaEarlierReleaseDate.compareTo(a.lunaEarlierReleaseDate);
                if(_comparison == 0) return a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase());
                return _comparison;
            });
            return _movies;
        });
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

    void fetchQualityProfiles() {
        if(_api != null) _qualityProfiles = _api.qualityProfile.getAll();
        notifyListeners();
    }

    Future<List<RadarrQualityDefinition>> _qualityDefinitions;
    Future<List<RadarrQualityDefinition>> get qualityDefinitions => _qualityDefinitions;
    set qualityDefinitions(Future<List<RadarrQualityDefinition>> qualityDefinitions) {
        assert(qualityDefinitions != null);
        _qualityDefinitions = qualityDefinitions;
        notifyListeners();
    }

    void fetchQualityDefinitions() {
        if(_api != null) _qualityDefinitions = _api.qualityProfile.getDefinitions();
        notifyListeners();
    }

    Future<List<RadarrLanguage>> _languages;
    Future<List<RadarrLanguage>> get languages => _languages;
    set languages(Future<List<RadarrLanguage>> languages) {
        assert(languages != null);
        _languages = languages;
        notifyListeners();
    }

    Future<void> fetchLanguages() async {
        if(_api != null) _languages = _api.language.getAll();
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

    void fetchTags() {
        if(_api != null) _tags = _api.tag.getAll();
        notifyListeners();
    }

    /////////////
    /// QUEUE ///
    /////////////
    
    /// Timer to handle refreshing queue data
    Timer _getQueueTimer;

    void createQueueTimer() => _getQueueTimer = Timer.periodic(
        Duration(seconds: RadarrDatabaseValue.QUEUE_REFRESH_RATE.data),
        (_) => fetchQueue(),
    );

    void cancelQueueTimer() => _getQueueTimer?.cancel();
    
    
    Future<RadarrQueue> _queue;
    Future<RadarrQueue> get queue => _queue;
    set queue(Future<RadarrQueue> queue) {
        assert(queue != null);
        _queue = queue;
        notifyListeners();
    }

    void fetchQueue() {
        cancelQueueTimer();
        if(_api != null) {
            _queue = _api.queue.get();
            createQueueTimer();
        }
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
