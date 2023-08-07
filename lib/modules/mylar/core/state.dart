import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/types/list_view_option.dart';

class MylarState extends LunaModuleState {
  MylarState() {
    reset();
  }

  @override
  void reset() {
    _series = null;
    _upcoming = null;
    _missing = null;
    _rootFolders = null;
    _qualityProfiles = null;
    _languageProfiles = null;
    _tags = null;

    resetProfile();
    if (_enabled) {
      fetchAllSeries();
      fetchUpcoming();
      fetchMissing();
      fetchRootFolders();
      fetchQualityProfiles();
      fetchLanguageProfiles();
      fetchTags();
    }
    notifyListeners();
  }

  ///////////////
  /// PROFILE ///
  ///////////////

  /// API handler instance
  MylarAPI? _api;
  MylarAPI? get api => _api;

  /// Is the API enabled?
  bool _enabled = false;
  bool get enabled => _enabled;

  /// Mylar host
  String _host = '';
  String get host => _host;

  /// Mylar API key
  String _apiKey = '';
  String get apiKey => _apiKey;

  /// Headers to attach to all requests
  Map<dynamic, dynamic> _headers = {};
  Map<dynamic, dynamic> get headers => _headers;

  /// Reset the profile data, reinitializes API instance
  void resetProfile() {
    LunaProfile _profile = LunaProfile.current;
    // Copy profile into state
    _api = null;
    _enabled = _profile.mylarEnabled;
    _host = _profile.mylarHost;
    _apiKey = _profile.mylarKey;
    _headers = _profile.mylarHeaders;
    // Create the API instance if Mylar is enabled
    if (_enabled) {
      _api = MylarAPI(
        host: _host,
        apiKey: _apiKey,
        headers: Map<String, dynamic>.from(_headers),
      );
    }
  }

  /////////////////
  /// CATALOGUE ///
  /////////////////

  LunaListViewOption _seriesViewType =
      MylarDatabase.DEFAULT_VIEW_SERIES.read();
  LunaListViewOption get seriesViewType => _seriesViewType;
  set seriesViewType(LunaListViewOption seriesViewType) {
    _seriesViewType = seriesViewType;
    notifyListeners();
  }

  String _seriesSearchQuery = '';
  String get seriesSearchQuery => _seriesSearchQuery;
  set seriesSearchQuery(String seriesSearchQuery) {
    _seriesSearchQuery = seriesSearchQuery;
    notifyListeners();
  }

  MylarSeriesSorting _seriesSortType =
      MylarDatabase.DEFAULT_SORTING_SERIES.read();
  MylarSeriesSorting get seriesSortType => _seriesSortType;
  set seriesSortType(MylarSeriesSorting seriesSortType) {
    _seriesSortType = seriesSortType;
    notifyListeners();
  }

  MylarSeriesFilter _seriesFilterType =
      MylarDatabase.DEFAULT_FILTERING_SERIES.read();
  MylarSeriesFilter get seriesFilterType => _seriesFilterType;
  set seriesFilterType(MylarSeriesFilter seriesFilterType) {
    _seriesFilterType = seriesFilterType;
    notifyListeners();
  }

  bool _seriesSortAscending =
      MylarDatabase.DEFAULT_SORTING_SERIES_ASCENDING.read();
  bool get seriesSortAscending => _seriesSortAscending;
  set seriesSortAscending(bool seriesSortAscending) {
    _seriesSortAscending = seriesSortAscending;
    notifyListeners();
  }

  //////////////
  /// SERIES ///
  //////////////

  Future<Map<int, MylarSeries>>? _series;
  Future<Map<int, MylarSeries>>? get series => _series;
  void fetchAllSeries() {
    if (_api != null) {
      _series = _api!.series.getAll(includeSeasonImages: true).then((series) {
        return {
          for (MylarSeries s in series) s.id!: s,
        };
      });
    }
    notifyListeners();
  }

  Future<void> fetchSeries(int seriesId) async {
    if (_api != null) {
      MylarSeries series =
          await _api!.series.get(seriesId: seriesId, includeSeasonImages: true);
      (await _series)![seriesId] = series;
    }
    notifyListeners();
  }

  Future<void> setSingleSeries(MylarSeries series) async {
    (await _series)![series.id!] = series;
    notifyListeners();
  }

  Future<void> removeSingleSeries(int seriesId) async {
    (await _series)!.remove(seriesId);
    notifyListeners();
  }

  ///////////////
  /// MISSING ///
  ///////////////

  Future<MylarMissing>? _missing;
  Future<MylarMissing>? get missing => _missing;
  set missing(Future<MylarMissing>? missing) {
    _missing = missing;
    notifyListeners();
  }

  void fetchMissing() {
    if (_api != null)
      _missing = _api!.wanted.getMissing(
        pageSize: MylarDatabase.CONTENT_PAGE_SIZE.read(),
        sortDir: MylarSortDirection.DESCENDING,
        sortKey: MylarWantedMissingSortKey.AIRDATE_UTC,
      );
    notifyListeners();
  }

  ////////////////
  /// UPCOMING ///
  ////////////////

  Future<List<MylarCalendar>>? _upcoming;
  Future<List<MylarCalendar>>? get upcoming => _upcoming;
  set upcoming(Future<List<MylarCalendar>>? upcoming) {
    _upcoming = upcoming;
    notifyListeners();
  }

  void fetchUpcoming() {
    DateTime start = DateTime.now();
    DateTime end =
        start.add(Duration(days: MylarDatabase.UPCOMING_FUTURE_DAYS.read()));
    if (_api != null)
      _upcoming = _api!.calendar.get(
        start: start,
        end: end,
        includeEpisodeFile: true,
      );
    notifyListeners();
  }

  ////////////////
  /// PROFILES ///
  ////////////////

  Future<List<MylarQualityProfile>>? _qualityProfiles;
  Future<List<MylarQualityProfile>>? get qualityProfiles => _qualityProfiles;
  set qualityProfiles(Future<List<MylarQualityProfile>>? qualityProfiles) {
    _qualityProfiles = qualityProfiles;
    notifyListeners();
  }

  void fetchQualityProfiles() {
    if (_api != null) _qualityProfiles = _api!.profile.getQualityProfiles();
    notifyListeners();
  }

  Future<List<MylarLanguageProfile>>? _languageProfiles;
  Future<List<MylarLanguageProfile>>? get languageProfiles =>
      _languageProfiles;
  set languageProfiles(Future<List<MylarLanguageProfile>>? languageProfiles) {
    _languageProfiles = languageProfiles;
    notifyListeners();
  }

  Future<List<MylarLanguageProfile>> _fetchLanguageProfiles() async {
    try {
      final profiles = await _api!.profile.getLanguageProfiles();
      return profiles;
    } catch (error, stack) {
      LunaLogger().error(
        'Failed to fetch language profiles, assuming v4',
        error,
        stack,
      );
      return const [];
    }
  }

  void fetchLanguageProfiles() {
    if (_api != null) {
      _languageProfiles = _fetchLanguageProfiles();
    }
    notifyListeners();
  }

  ////////////////////
  /// ROOT FOLDERS ///
  ////////////////////

  Future<List<MylarRootFolder>>? _rootFolders;
  Future<List<MylarRootFolder>>? get rootFolders => _rootFolders;
  void fetchRootFolders() {
    if (_api != null) _rootFolders = _api!.rootFolder.get();
    notifyListeners();
  }

  ////////////
  /// TAGS ///
  ////////////

  Future<List<MylarTag>>? _tags;
  Future<List<MylarTag>>? get tags => _tags;
  set tags(Future<List<MylarTag>>? tags) {
    _tags = tags;
    notifyListeners();
  }

  void fetchTags() {
    if (_api != null) _tags = _api!.tag.getAll();
    notifyListeners();
  }

  //////////////
  /// IMAGES ///
  //////////////

  String _baseImageURL() {
    return _host.endsWith('/')
        ? '${_host}api/v3/MediaCover'
        : '$_host/api/v3/MediaCover';
  }

  String? getPosterURL(int? seriesId) {
    if (_enabled) {
      return '${_baseImageURL()}/$seriesId/poster-500.jpg?apikey=$_apiKey';
    }
    return null;
  }

  String? getFanartURL(int? seriesId, {bool highRes = false}) {
    if (_enabled) {
      return '${_baseImageURL()}/$seriesId/fanart-360.jpg?apikey=$_apiKey';
    }
    return null;
  }
}
