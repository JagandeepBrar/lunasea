import 'dart:async';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrState extends LunaModuleState {
  SonarrState() {
    reset();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void reset() {
    // Reset stored data
    _series = null;
    _upcoming = null;
    _missing = null;
    _rootFolders = null;
    _qualityProfiles = null;
    _languageProfiles = null;
    _tags = null;
    _episodes = {};
    _selectedEpisodes = [];
    // Reset search query fields
    _releasesSearchQuery = '';
    // Reinitialize
    resetProfile();
    if (_enabled) {
      fetchSeries();
      fetchUpcoming();
      fetchMissing();
      fetchQualityProfiles();
      fetchLanguageProfiles();
      fetchRootFolders();
      fetchTags();
    }
    notifyListeners();
  }

  ///////////////
  /// PROFILE ///
  ///////////////

  /// API handler instance
  Sonarr _api;
  Sonarr get api => _api;

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
        ? Sonarr(
            host: _host,
            apiKey: _apiKey,
            headers: Map<String, dynamic>.from(_headers),
          )
        : null;
  }

  ////////////////
  /// EPISODES ///
  ////////////////

  Map<int, Future<List<SonarrEpisode>>> _episodes = {};
  Map<int, Future<List<SonarrEpisode>>> get episodes => _episodes;
  void fetchEpisodes(int seriesId) {
    assert(seriesId != null);
    if (_api != null)
      _episodes[seriesId] = _api.episode.getMulti(seriesId: seriesId);
    notifyListeners();
  }

  List<int> _selectedEpisodes = [];
  List<int> get selectedEpisodes => _selectedEpisodes;
  set selectedEpisodes(List<int> selectedEpisodes) {
    assert(selectedEpisodes != null);
    _selectedEpisodes = selectedEpisodes;
    notifyListeners();
  }

  void addSelectedEpisode(int id) {
    if (!_selectedEpisodes.contains(id)) _selectedEpisodes.add(id);
    notifyListeners();
  }

  void removeSelectedEpisode(int id) {
    if (_selectedEpisodes.contains(id)) _selectedEpisodes.remove(id);
    notifyListeners();
  }

  void toggleSelectedEpisode(int id) {
    _selectedEpisodes.contains(id)
        ? _selectedEpisodes.remove(id)
        : _selectedEpisodes.add(id);
    notifyListeners();
  }

  Future<List<SonarrRootFolder>> _rootFolders;
  Future<List<SonarrRootFolder>> get rootFolders => _rootFolders;
  void fetchRootFolders() {
    if (_api != null) _rootFolders = _api.rootFolder.getRootFolders();
    notifyListeners();
  }

  ////////////////
  /// RELEASES ///
  ////////////////

  String _releasesSearchQuery = '';
  String get releasesSearchQuery => _releasesSearchQuery;
  set releasesSearchQuery(String releasesSearchQuery) {
    assert(releasesSearchQuery != null);
    _releasesSearchQuery = releasesSearchQuery;
    notifyListeners();
  }

  SonarrReleasesFilter _releasesFilterType =
      SonarrDatabaseValue.DEFAULT_FILTERING_RELEASES.data;
  SonarrReleasesFilter get releasesFilterType => _releasesFilterType;
  set releasesFilterType(SonarrReleasesFilter releasesFilterType) {
    assert(releasesFilterType != null);
    _releasesFilterType = releasesFilterType;
    notifyListeners();
  }

  SonarrReleasesSorting _releasesSortType =
      SonarrDatabaseValue.DEFAULT_SORTING_RELEASES.data;
  SonarrReleasesSorting get releasesSortType => _releasesSortType;
  set releasesSortType(SonarrReleasesSorting releasesSortType) {
    assert(releasesSortType != null);
    _releasesSortType = releasesSortType;
    notifyListeners();
  }

  bool _releasesSortAscending =
      SonarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data;
  bool get releasesSortAscending => _releasesSortAscending;
  set releasesSortAscending(bool releasesSortAscending) {
    assert(releasesSortAscending != null);
    _releasesSortAscending = releasesSortAscending;
    notifyListeners();
  }

  //////////////
  /// SERIES ///
  //////////////

  String _seriesSearchQuery = '';
  String get seriesSearchQuery => _seriesSearchQuery;
  set seriesSearchQuery(String seriesSearchQuery) {
    assert(seriesSearchQuery != null);
    _seriesSearchQuery = seriesSearchQuery;
    notifyListeners();
  }

  SonarrSeriesSorting _seriesSortType =
      SonarrDatabaseValue.DEFAULT_SORTING_SERIES.data;
  SonarrSeriesSorting get seriesSortType => _seriesSortType;
  set seriesSortType(SonarrSeriesSorting seriesSortType) {
    assert(seriesSortType != null);
    _seriesSortType = seriesSortType;
    notifyListeners();
  }

  SonarrSeriesFilter _seriesFilterType =
      SonarrDatabaseValue.DEFAULT_FILTERING_SERIES.data;
  SonarrSeriesFilter get seriesFilterType => _seriesFilterType;
  set seriesFilterType(SonarrSeriesFilter seriesFilterType) {
    assert(seriesFilterType != null);
    _seriesFilterType = seriesFilterType;
    notifyListeners();
  }

  bool _seriesSortAscending =
      SonarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data;
  bool get seriesSortAscending => _seriesSortAscending;
  set seriesSortAscending(bool seriesSortAscending) {
    assert(seriesSortAscending != null);
    _seriesSortAscending = seriesSortAscending;
    notifyListeners();
  }

  Future<Map<int, SonarrSeries>> _series;
  Future<Map<int, SonarrSeries>> get series => _series;
  void fetchSeries() {
    if (_api != null) {
      _series = _api.series.getAll().then((series) {
        return {
          for (SonarrSeries s in series) s.id: s,
        };
      });
    }
    notifyListeners();
  }

  Future<void> resetSingleSeries(int seriesId) async {
    assert(seriesId != null);
    if (_api != null) {
      SonarrSeries series = await _api.series.get(seriesId: seriesId);
      (await _series)[seriesId] = series;
    }
    notifyListeners();
  }

  Future<void> setSingleSeries(SonarrSeries series) async {
    assert(series != null);
    (await _series)[series.id] = series;
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

  void fetchMissing() {
    if (_api != null)
      _missing = _api.wanted.getMissing(
        pageSize: SonarrDatabaseValue.CONTENT_PAGE_SIZE.data,
        sortDir: SonarrSortDirection.DESCENDING,
        sortKey: SonarrWantedMissingSortKey.AIRDATE_UTC,
        includeSeries: true,
      );
    notifyListeners();
  }

  ////////////////
  /// UPCOMING ///
  ////////////////

  Future<List<SonarrCalendar>> _upcoming;
  Future<List<SonarrCalendar>> get upcoming => _upcoming;
  set upcoming(Future<List<SonarrCalendar>> upcoming) {
    assert(upcoming != null);
    _upcoming = upcoming;
    notifyListeners();
  }

  void fetchUpcoming() {
    DateTime start = DateTime.now();
    DateTime end = start
        .add(Duration(days: SonarrDatabaseValue.UPCOMING_FUTURE_DAYS.data));
    if (_api != null)
      _upcoming = _api.calendar.get(
        start: start,
        end: end,
        includeEpisodeFile: true,
        includeSeries: true,
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

  void fetchQualityProfiles() {
    if (_api != null) _qualityProfiles = _api.profile.getQualityProfiles();
    notifyListeners();
  }

  Future<List<SonarrLanguageProfile>> _languageProfiles;
  Future<List<SonarrLanguageProfile>> get languageProfiles => _languageProfiles;
  set languageProfiles(Future<List<SonarrLanguageProfile>> languageProfiles) {
    assert(languageProfiles != null);
    _languageProfiles = languageProfiles;
    notifyListeners();
  }

  void fetchLanguageProfiles() {
    if (_api != null) _languageProfiles = _api.profile.getLanguageProfiles();
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

  void fetchTags() {
    if (_api != null) _tags = _api.tag.getAllTags();
    notifyListeners();
  }

  //////////////
  /// IMAGES ///
  //////////////

  String getBannerURL(int seriesId, {bool highRes = false}) {
    if (_enabled) {
      String _base = _host.endsWith('/')
          ? '${_host}api/MediaCover'
          : '$_host/api/MediaCover';
      return highRes
          ? '$_base/$seriesId/banner.jpg?apikey=$_apiKey'
          : '$_base/$seriesId/banner-70.jpg?apikey=$_apiKey';
    }
    return null;
  }

  String getPosterURL(int seriesId, {bool highRes = false}) {
    if (_enabled) {
      String _base = _host.endsWith('/')
          ? '${_host}api/MediaCover'
          : '$_host/api/MediaCover';
      return highRes
          ? '$_base/$seriesId/poster.jpg?apikey=$_apiKey'
          : '$_base/$seriesId/poster-500.jpg?apikey=$_apiKey';
    }
    return null;
  }

  String getFanartURL(int seriesId, {bool highRes = false}) {
    if (_enabled) {
      String _base = _host.endsWith('/')
          ? '${_host}api/MediaCover'
          : '$_host/api/MediaCover';
      return highRes
          ? '$_base/$seriesId/fanart.jpg?apikey=$_apiKey'
          : '$_base/$seriesId/fanart-360.jpg?apikey=$_apiKey';
    }
    return null;
  }
}
