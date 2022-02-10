import 'dart:async';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrState extends LunaModuleState {
  ReadarrState() {
    reset();
  }

  @override
  void reset() {
    _authors = null;
    _books = null;
    _upcoming = null;
    _missing = null;
    _rootFolders = null;
    _qualityProfiles = null;
    _metadataProfiles = null;
    _tags = null;

    resetProfile();
    if (_enabled) {
      fetchAllAuthors();
      fetchAllBooks();
      fetchUpcoming();
      fetchMissing();
      fetchRootFolders();
      fetchQualityProfiles();
      fetchMetadataProfiles();
      fetchTags();
    }
    notifyListeners();
  }

  ///////////////
  /// PROFILE ///
  ///////////////

  /// API handler instance
  Readarr? _api;
  Readarr? get api => _api;

  /// Is the API enabled?
  bool _enabled = false;
  bool get enabled => _enabled;

  /// Readarr host
  String _host = '';
  String get host => _host;

  /// Readarr API key
  String _apiKey = '';
  String get apiKey => _apiKey;

  /// Headers to attach to all requests
  Map<dynamic, dynamic> _headers = {};
  Map<dynamic, dynamic> get headers => _headers;

  /// Reset the profile data, reinitializes API instance
  void resetProfile() {
    ProfileHiveObject _profile = LunaProfile.current;
    // Copy profile into state
    _api = null;
    _enabled = _profile.readarrEnabled ?? false;
    _host = _profile.readarrHost ?? '';
    _apiKey = _profile.readarrKey ?? '';
    _headers = _profile.readarrHeaders ?? {};
    // Create the API instance if Readarr is enabled
    if (_enabled) {
      _api = Readarr(
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
      ReadarrDatabaseValue.DEFAULT_VIEW_SERIES.data;
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

  ReadarrAuthorSorting _seriesSortType =
      ReadarrDatabaseValue.DEFAULT_SORTING_SERIES.data;
  ReadarrAuthorSorting get seriesSortType => _seriesSortType;
  set seriesSortType(ReadarrAuthorSorting seriesSortType) {
    _seriesSortType = seriesSortType;
    notifyListeners();
  }

  ReadarrAuthorFilter _seriesFilterType =
      ReadarrDatabaseValue.DEFAULT_FILTERING_SERIES.data;
  ReadarrAuthorFilter get seriesFilterType => _seriesFilterType;
  set seriesFilterType(ReadarrAuthorFilter seriesFilterType) {
    _seriesFilterType = seriesFilterType;
    notifyListeners();
  }

  bool _seriesSortAscending =
      ReadarrDatabaseValue.DEFAULT_SORTING_SERIES_ASCENDING.data;
  bool get seriesSortAscending => _seriesSortAscending;
  set seriesSortAscending(bool seriesSortAscending) {
    _seriesSortAscending = seriesSortAscending;
    notifyListeners();
  }

  ///////////////
  /// AUTHORS ///
  ///////////////

  Future<Map<int, ReadarrAuthor>>? _authors;
  Future<Map<int, ReadarrAuthor>>? get authors => _authors;
  void fetchAllAuthors() {
    if (_api != null) {
      _authors = _api!.author.getAll().then((series) {
        return {
          for (ReadarrAuthor s in series) s.id!: s,
        };
      });
    }
    notifyListeners();
  }

  Future<void> fetchAuthor(int authorId) async {
    if (_api != null) {
      ReadarrAuthor series = await _api!.author.get(authorId: authorId);
      (await _authors)![authorId] = series;
    }
    notifyListeners();
  }

  Future<void> setSingleAuthor(ReadarrAuthor series) async {
    (await _authors)![series.id!] = series;
    notifyListeners();
  }

  Future<void> removeSingleAuthor(int authorId) async {
    (await _authors)!.remove(authorId);
    notifyListeners();
  }

  /////////////
  /// BOOKS ///
  /////////////

  Future<Map<int, ReadarrBook>>? _books;
  Future<Map<int, ReadarrBook>>? get books => _books;
  void fetchAllBooks() {
    if (_api != null) {
      _books = _api!.book.getAll().then((books) {
        return {
          for (ReadarrBook b in books) b.id!: b,
        };
      });
    }
    notifyListeners();
  }

  Future<void> setSingleBook(ReadarrBook book) async {
    (await _books)![book.id!] = book;
    notifyListeners();
  }

  Future<void> removeSingleBook(int bookId) async {
    (await _books)!.remove(bookId);
    notifyListeners();
  }

  ///////////////
  /// MISSING ///
  ///////////////

  Future<ReadarrMissing>? _missing;
  Future<ReadarrMissing>? get missing => _missing;
  set missing(Future<ReadarrMissing>? missing) {
    _missing = missing;
    notifyListeners();
  }

  void fetchMissing() {
    if (_api != null)
      _missing = _api!.wanted.getMissing(
        pageSize: ReadarrDatabaseValue.CONTENT_PAGE_SIZE.data,
        sortDir: ReadarrSortDirection.DESCENDING,
        sortKey: ReadarrWantedMissingSortKey.RELEASE_DATE,
      );
    notifyListeners();
  }

  ////////////////
  /// UPCOMING ///
  ////////////////

  Future<List<ReadarrBook>>? _upcoming;
  Future<List<ReadarrBook>>? get upcoming => _upcoming;
  set upcoming(Future<List<ReadarrBook>>? upcoming) {
    _upcoming = upcoming;
    notifyListeners();
  }

  void fetchUpcoming() {
    DateTime start = DateTime.now();
    DateTime end = start
        .add(Duration(days: ReadarrDatabaseValue.UPCOMING_FUTURE_DAYS.data));
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

  Future<List<ReadarrQualityProfile>>? _qualityProfiles;
  Future<List<ReadarrQualityProfile>>? get qualityProfiles => _qualityProfiles;
  set qualityProfiles(Future<List<ReadarrQualityProfile>>? qualityProfiles) {
    _qualityProfiles = qualityProfiles;
    notifyListeners();
  }

  void fetchQualityProfiles() {
    if (_api != null) _qualityProfiles = _api!.profile.getQualityProfiles();
    notifyListeners();
  }

  Future<List<ReadarrMetadataProfile>>? _metadataProfiles;
  Future<List<ReadarrMetadataProfile>>? get metadataProfiles =>
      _metadataProfiles;
  set metadataProfiles(Future<List<ReadarrMetadataProfile>>? metadataProfiles) {
    _metadataProfiles = metadataProfiles;
    notifyListeners();
  }

  void fetchMetadataProfiles() {
    if (_api != null) _metadataProfiles = _api!.profile.getMetadataProfiles();
    notifyListeners();
  }

  ////////////////////
  /// ROOT FOLDERS ///
  ////////////////////

  Future<List<ReadarrRootFolder>>? _rootFolders;
  Future<List<ReadarrRootFolder>>? get rootFolders => _rootFolders;
  void fetchRootFolders() {
    if (_api != null) _rootFolders = _api!.rootFolder.get();
    notifyListeners();
  }

  ////////////
  /// TAGS ///
  ////////////

  Future<List<ReadarrTag>>? _tags;
  Future<List<ReadarrTag>>? get tags => _tags;
  set tags(Future<List<ReadarrTag>>? tags) {
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
        ? '${_host}api/v1/MediaCover'
        : '$_host/api/v1/MediaCover';
  }

  String? getAuthorPosterURL(int? authorId) {
    if (_enabled) {
      return '${_baseImageURL()}/author/$authorId/poster-500.jpg?apikey=$_apiKey';
    }
    return null;
  }

  String? getBookCoverURL(int? bookId) {
    if (_enabled) {
      return '${_baseImageURL()}/book/$bookId/cover-500.jpg?apikey=$_apiKey';
    }
    return null;
  }
}
