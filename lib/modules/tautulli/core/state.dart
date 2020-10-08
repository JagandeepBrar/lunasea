import 'dart:async';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliState extends LunaGlobalState {
    TautulliState() {
        reset();
    }

    @override
    void dispose() {
        _getActivityTimer?.cancel();
        super.dispose();
    }

    @override
    void reset() {
        // Clear global data
        _activity = null;
        _users = null;
        _history = null;
        _syncedItems = null;
        _search = null;
        _statistics = null;
        _recentlyAdded = null;
        _loginLogs = null;
        _newsletterLogs = null;
        _notificationLogs = null;
        _plexMediaScannerLogs = null;
        _plexMediaServerLogs = null;
        _tautulliLogs = null;
        _dailyPlayCountGraph = null;
        _playsByMonthGraph = null;
        _playCountByDayOfWeekGraph = null;
        _playCountByTopPlatformsGraph = null;
        _playCountByTopUsersGraph = null;
        _dailyStreamTypeBreakdownGraph = null;
        _playCountBySourceResolutionGraph = null;
        _playCountByStreamResolutionGraph = null;
        _playCountByPlatformStreamTypeGraph = null;
        _playCountByUserStreamTypeGraph = null;
        _updatePlexMediaServer = null;
        _updateTautulli = null;
        _librariesTable = null;
        _searchQuery = '';

        // Clear user data
        _userProfile = {};
        _userSyncedItems = {};
        _userIPs = {};
        _userWatchStats = {};
        _userPlayerStats = {};
        _userHistory = {};
        _metadata = {};
        _libraryWatchTimeStats = {};
        _libraryUserStats = {};
        _geolocationInformation = {};
        _whoisInformation = {};
        
        // Reset global data
        resetProfile();
        resetActivity();
        resetUsers();
        resetHistory();
        notifyListeners();
    }
    
    ///////////////
    /// PROFILE ///
    ///////////////

    /// API handler instance
    Tautulli _api;
    Tautulli get api => _api;

    /// Is the API enabled?
    bool _enabled;
    bool get enabled => _enabled;

    /// Tautulli host
    String _host;
    String get host => _host;

    /// Tautulli API key
    String _apiKey;
    String get apiKey => _apiKey;

    /// Headers to attach to all requests
    Map<dynamic, dynamic> _headers;
    Map<dynamic, dynamic> get headers => _headers;

    /// Reset the profile data, reinitializes API instance
    void resetProfile() {
        ProfileHiveObject _profile = Database.currentProfileObject;
        // Copy profile into state
        _enabled = _profile.tautulliEnabled ?? false;
        _host = _profile.tautulliHost ?? '';
        _apiKey = _profile.tautulliKey ?? '';
        _headers = _profile.tautulliHeaders ?? {};
        // Create the API instance if Tautulli is enabled
        _api = _enabled
            ? Tautulli(
                host: _host,
                apiKey: _apiKey,
                headers: Map<String, dynamic>.from(_headers),
            )
            : null;
    }

    ////////////////
    /// ACTIVITY ///
    ////////////////
    
    /// Timer to handle refreshing activity data
    Timer _getActivityTimer;

    /// Create the periodic timer to handle refreshing activity data
    void createActivityTimer() => _getActivityTimer = Timer.periodic(
        Duration(seconds: TautulliDatabaseValue.REFRESH_RATE.data),
        (_) => activity = _api.activity.getActivity(),
    );

    /// Cancel the periodic timer
    void cancelActivityTimer() => _getActivityTimer?.cancel();

    /// Storing activity data
    Future<TautulliActivity> _activity;
    Future<TautulliActivity> get activity => _activity;
    set activity(Future<TautulliActivity> activity) {
        assert(activity != null);
        _activity = activity;
        notifyListeners();
    }

    /// Reset the activity by:
    /// - Cancelling the timer
    /// - Recreating the timer
    /// - Setting the initial state of the future to an instance of the API call
    void resetActivity() {
        cancelActivityTimer();
        _activity = null;
        if(_api != null) {
            _activity = _api.activity.getActivity();
            createActivityTimer();
        }
        notifyListeners();
    }

    /////////////
    /// USERS ///
    /////////////

    /// Storing the user table
    Future<TautulliUsersTable> _users;
    Future<TautulliUsersTable> get users => _users;
    set users(Future<TautulliUsersTable> users) {
        assert(users != null);
        _users = users;
        notifyListeners();
    }

    /// Reset the users by:
    /// - Setting the intial state of the future to an instance of the API call
    /// - Resets individual user data maps
    void resetUsers() {
        // Reset user table
        if(_api != null) {
            _users = _api.users.getUsersTable(
                length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
                orderDirection: TautulliOrderDirection.ASCENDING,
                orderColumn: TautulliUsersOrderColumn.FRIENDLY_NAME,
            );
        }
        notifyListeners();
    }

    ///////////////
    /// HISTORY ///
    ///////////////

    /// Storing the history table
    Future<TautulliHistory> _history;
    Future<TautulliHistory> get history => _history;
    set history(Future<TautulliHistory> history) {
        assert(history != null);
        _history = history;
        notifyListeners();
    }

    /// Reset the history by:
    /// - Setting the intial state of the future to an instance of the API call
    void resetHistory() {
        // Reset user table
        if(_api != null) {
            _history = _api.history.getHistory(
                length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
                orderDirection: TautulliOrderDirection.ASCENDING,
            );
        }
        notifyListeners();
    }

    Map<int, Future<TautulliHistory>> _individualHistory = {};
    Map<int, Future<TautulliHistory>> get individualHistory => _individualHistory;
    void setIndividualHistory(int userId, Future<TautulliHistory> data) {
        assert(userId != null);
        assert(data != null);
        _individualHistory[userId] = data;
        notifyListeners();
    }

    //////////////////
    /// STATISTICS ///
    //////////////////

    /// Stores the time range for the statistics
    TautulliStatisticsTimeRange _statisticsTimeRange = TautulliStatisticsTimeRange.ONE_MONTH;
    TautulliStatisticsTimeRange get statisticsTimeRange => _statisticsTimeRange;
    set statisticsTimeRange(TautulliStatisticsTimeRange statisticsTimeRange) {
        assert(statisticsTimeRange != null);
        _statisticsTimeRange = statisticsTimeRange;
        notifyListeners();
    }

    /// Stores the type of statistics
    TautulliStatsType _statisticsType = TautulliStatsType.PLAYS;
    TautulliStatsType get statisticsType => _statisticsType;
    set statisticsType(TautulliStatsType statisticsType) {
        assert(statisticsType != null);
        _statisticsType = statisticsType;
        notifyListeners();
    }

    //////////////
    /// GRAPHS ///
    //////////////

    /// Store the graph Y axis
    TautulliGraphYAxis _graphYAxis = TautulliGraphYAxis.PLAYS;
    TautulliGraphYAxis get graphYAxis => _graphYAxis;
    set graphYAxis(TautulliGraphYAxis graphYAxis) {
        assert(graphYAxis != null);
        _graphYAxis = graphYAxis;
        notifyListeners();
    }

    /////////////////
    /// USER DATA ///
    /////////////////

    Map<int, Future<TautulliUser>> _userProfile = {};
    Map<int, Future<TautulliUser>> get userProfile => _userProfile;
    void setUserProfile(int userId, Future<TautulliUser> data) {
        assert(userId != null);
        assert(data != null);
        _userProfile[userId] = data;
        notifyListeners();
    }

    Map<int, Future<List<TautulliSyncedItem>>> _userSyncedItems = {};
    Map<int, Future<List<TautulliSyncedItem>>> get userSyncedItems => _userSyncedItems;
    void setUserSyncedItems(int userId, Future<List<TautulliSyncedItem>> data) {
        assert(userId != null);
        assert(data != null);
        _userSyncedItems[userId] = data;
        notifyListeners();
    }

    Map<int, Future<TautulliUserIPs>> _userIPs = {};
    Map<int, Future<TautulliUserIPs>> get userIPs => _userIPs;
    void setUserIPs(int userId, Future<TautulliUserIPs> data) {
        assert(userId != null);
        assert(data != null);
        _userIPs[userId] = data;
        notifyListeners();
    }

    Map<int, Future<List<TautulliUserWatchTimeStats>>> _userWatchStats = {};
    Map<int, Future<List<TautulliUserWatchTimeStats>>> get userWatchStats => _userWatchStats;
    void setUserWatchStats(int userId, Future<List<TautulliUserWatchTimeStats>> data) {
        assert(userId != null);
        assert(data != null);
        _userWatchStats[userId] = data;
        notifyListeners();
    }

    Map<int, Future<List<TautulliUserPlayerStats>>> _userPlayerStats = {};
    Map<int, Future<List<TautulliUserPlayerStats>>> get userPlayerStats => _userPlayerStats;
    void setUserPlayerStats(int userId, Future<List<TautulliUserPlayerStats>> data) {
        assert(userId != null);
        assert(data != null);
        _userPlayerStats[userId] = data;
        notifyListeners();
    }

    Map<int, Future<TautulliHistory>> _userHistory = {};
    Map<int, Future<TautulliHistory>> get userHistory => _userHistory;
    void setUserHistory(int userId, Future<TautulliHistory> data) {
        assert(userId != null);
        assert(data != null);
        _userHistory[userId] = data;
        notifyListeners();
    }

    ////////////////////
    /// SYNCED ITEMS ///
    ////////////////////

    Future<List<TautulliSyncedItem>> _syncedItems;
    Future<List<TautulliSyncedItem>> get syncedItems => _syncedItems;
    set syncedItems(Future<List<TautulliSyncedItem>> syncedItems) {
        assert(syncedItems != null);
        _syncedItems = syncedItems;
        notifyListeners();
    }

    void resetSyncedItems() {
        if(_api != null) _syncedItems = _api.libraries.getSyncedItems();
        notifyListeners();
    }

    //////////////////
    /// STATISTICS ///
    //////////////////

    Future<List<TautulliHomeStats>> _statistics;
    Future<List<TautulliHomeStats>> get statistics => _statistics;
    set statistics(Future<List<TautulliHomeStats>> statistics) {
        assert(statistics != null);
        _statistics = statistics;
        notifyListeners();
    }

    void resetStatistics() {
        if(_api != null) _statistics = _api.history.getHomeStats(
            timeRange: _statisticsTimeRange?.value,
            statsType: _statisticsType,
            statsCount: TautulliDatabaseValue.STATISTICS_STATS_COUNT.data,
        );
        notifyListeners();
    }

    //////////////////////
    /// RECENTLY ADDED ///
    //////////////////////
    
    Future<List<TautulliRecentlyAdded>> _recentlyAdded;
    Future<List<TautulliRecentlyAdded>> get recentlyAdded => _recentlyAdded;
    set recentlyAdded(Future<List<TautulliRecentlyAdded>> recentlyAdded) {
        assert(recentlyAdded != null);
        _recentlyAdded = recentlyAdded;
        notifyListeners();
    }

    void resetRecentlyAdded() {
        if(_api != null) _recentlyAdded = _api.libraries.getRecentlyAdded(
            count: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
        );
        notifyListeners();
    }

    ////////////
    /// LOGS ///
    ////////////

    Future<TautulliUserLogins> _loginLogs;
    Future<TautulliUserLogins> get loginLogs => _loginLogs;
    set loginLogs(Future<TautulliUserLogins> loginLogs) {
        assert(loginLogs != null);
        _loginLogs = loginLogs;
        notifyListeners();
    }

    void resetLoginLogs() {
        if(_api != null) _loginLogs = _api.users.getUserLogins(
            length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
        );
        notifyListeners();
    }

    Future<TautulliNewsletterLogs> _newsletterLogs;
    Future<TautulliNewsletterLogs> get newsletterLogs => _newsletterLogs;
    set newsletterLogs(Future<TautulliNewsletterLogs> newsletterLogs) {
        assert(newsletterLogs != null);
        _newsletterLogs = newsletterLogs;
        notifyListeners();
    }

    void resetNewsletterLogs() {
        if(_api != null) _newsletterLogs = _api.notifications.getNewsletterLog(
            length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
        );
        notifyListeners();
    }

    Future<TautulliNotificationLogs> _notificationLogs;
    Future<TautulliNotificationLogs> get notificationLogs => _notificationLogs;
    set notificationLogs(Future<TautulliNotificationLogs> notificationLogs) {
        assert(notificationLogs != null);
        _notificationLogs = notificationLogs;
        notifyListeners();
    }

    void resetNotificationLogs() {
        if(_api != null) _notificationLogs = _api.notifications.getNotificationLog(
            length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
        );
        notifyListeners();
    }

    Future<List<TautulliPlexLog>> _plexMediaScannerLogs;
    Future<List<TautulliPlexLog>> get plexMediaScannerLogs => _plexMediaScannerLogs;
    set plexMediaScannerLogs(Future<List<TautulliPlexLog>> plexMediaScannerLogs) {
        assert(plexMediaScannerLogs != null);
        _plexMediaScannerLogs = plexMediaScannerLogs;
        notifyListeners();
    }

    void resetPlexMediaScannerLogs() {
        if(_api != null) _plexMediaScannerLogs = _api.miscellaneous.getPlexLog(
            window: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
            logType: TautulliPlexLogType.SCANNER,
        );
        notifyListeners();
    }

    Future<List<TautulliPlexLog>> _plexMediaServerLogs;
    Future<List<TautulliPlexLog>> get plexMediaServerLogs => _plexMediaServerLogs;
    set plexMediaServerLogs(Future<List<TautulliPlexLog>> plexMediaServerLogs) {
        assert(plexMediaServerLogs != null);
        _plexMediaServerLogs = plexMediaServerLogs;
        notifyListeners();
    }

    void resetPlexMediaServerLogs() {
        if(_api != null) _plexMediaServerLogs = _api.miscellaneous.getPlexLog(
            window: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
            logType: TautulliPlexLogType.SERVER,
        );
        notifyListeners();
    }

    Future<List<TautulliLog>> _tautulliLogs;
    Future<List<TautulliLog>> get tautulliLogs => _tautulliLogs;
    set tautulliLogs(Future<List<TautulliLog>> tautulliLogs) {
        assert(tautulliLogs != null);
        _tautulliLogs = tautulliLogs;
        notifyListeners();
    }

    void resetTautulliLogs() {
        if(_api != null) _tautulliLogs = _api.miscellaneous.getLogs(
            start: 0,
            end: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
        );
        notifyListeners();
    }

    ////////////// 
    /// GRAPHS ///
    //////////////
    
    Future<TautulliGraphData> _dailyPlayCountGraph;
    Future<TautulliGraphData> get dailyPlayCountGraph => _dailyPlayCountGraph;
    set dailyPlayCountGraph(Future<TautulliGraphData> dailyPlayCountGraph) {
        assert(dailyPlayCountGraph != null);
        _dailyPlayCountGraph = dailyPlayCountGraph;
        notifyListeners();
    }

    void resetDailyPlayCountGraph() {
        if(_api != null) _dailyPlayCountGraph = _api.history.getPlaysByDate(
            timeRange: TautulliDatabaseValue.GRAPHS_LINECHART_DAYS.data,
            yAxis: _graphYAxis,
        );
        notifyListeners();
    }

    Future<TautulliGraphData> _playsByMonthGraph;
    Future<TautulliGraphData> get playsByMonthGraph => _playsByMonthGraph;
    set playsByMonthGraph(Future<TautulliGraphData> playsByMonthGraph) {
        assert(playsByMonthGraph != null);
        _playsByMonthGraph = playsByMonthGraph;
        notifyListeners();
    }

    void resetPlaysByMonthGraph() {
        if(_api != null) _playsByMonthGraph = _api.history.getPlaysPerMonth(
            timeRange: TautulliDatabaseValue.GRAPHS_MONTHS.data,
            yAxis: _graphYAxis,
        );
        notifyListeners();
    }

    Future<TautulliGraphData> _playCountByDayOfWeekGraph;
    Future<TautulliGraphData> get playCountByDayOfWeekGraph => _playCountByDayOfWeekGraph;
    set playCountByDayOfWeekGraph(Future<TautulliGraphData> playCountByDayOfWeekGraph) {
        assert(playCountByDayOfWeekGraph != null);
        _playCountByDayOfWeekGraph = playCountByDayOfWeekGraph;
        notifyListeners();
    }

    void resetPlayCountByDayOfWeekGraph() {
        if(_api != null) _playCountByDayOfWeekGraph = _api.history.getPlaysByDayOfWeek(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _graphYAxis,
        );
        notifyListeners();
    }

    Future<TautulliGraphData> _playCountByTopPlatformsGraph;
    Future<TautulliGraphData> get playCountByTopPlatformsGraph => _playCountByTopPlatformsGraph;
    set playCountByTopPlatformsGraph(Future<TautulliGraphData> playCountByTopPlatformsGraph) {
        assert(playCountByTopPlatformsGraph != null);
        _playCountByTopPlatformsGraph = playCountByTopPlatformsGraph;
        notifyListeners();
    }

    void resetPlayCountByTopPlatformsGraph() {
        if(_api != null) _playCountByTopPlatformsGraph = _api.history.getPlaysByTopTenPlatforms(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _graphYAxis,
        );
        notifyListeners();
    }

    Future<TautulliGraphData> _playCountByTopUsersGraph;
    Future<TautulliGraphData> get playCountByTopUsersGraph => _playCountByTopUsersGraph;
    set playCountByTopUsersGraph(Future<TautulliGraphData> playCountByTopUsersGraph) {
        assert(playCountByTopUsersGraph != null);
        _playCountByTopUsersGraph = playCountByTopUsersGraph;
        notifyListeners();
    }

    void resetPlayCountByTopUsersGraph() {
        if(_api != null) _playCountByTopUsersGraph = _api.history.getPlaysByTopTenUsers(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _graphYAxis,
        );
        notifyListeners();
    }

    void resetAllPlayPeriodGraphs() {
        resetDailyPlayCountGraph();
        resetPlaysByMonthGraph();
        resetPlayCountByDayOfWeekGraph();
        resetPlayCountByTopPlatformsGraph();
        resetPlayCountByTopUsersGraph();
    }

    Future<TautulliGraphData> _dailyStreamTypeBreakdownGraph;
    Future<TautulliGraphData> get dailyStreamTypeBreakdownGraph => _dailyStreamTypeBreakdownGraph;
    set dailyStreamTypeBreakdownGraph(Future<TautulliGraphData> dailyStreamTypeBreakdownGraph) {
        assert(dailyStreamTypeBreakdownGraph != null);
        _dailyStreamTypeBreakdownGraph = dailyStreamTypeBreakdownGraph;
        notifyListeners();
    }

    void resetDailyStreamTypeBreakdownGraph() {
        if(_api != null) _dailyStreamTypeBreakdownGraph = _api.history.getPlaysByStreamType(
            timeRange: TautulliDatabaseValue.GRAPHS_LINECHART_DAYS.data,
            yAxis: _graphYAxis,
        );
        notifyListeners();
    }

    Future<TautulliGraphData> _playCountBySourceResolutionGraph;
    Future<TautulliGraphData> get playCountBySourceResolutionGraph => _playCountBySourceResolutionGraph;
    set playCountBySourceResolutionGraph(Future<TautulliGraphData> playCountBySourceResolutionGraph) {
        assert(playCountBySourceResolutionGraph != null);
        _playCountBySourceResolutionGraph = playCountBySourceResolutionGraph;
        notifyListeners();
    }

    void resetPlayCountBySourceResolutionGraph() {
        if(_api != null) _playCountBySourceResolutionGraph = _api.history.getPlaysBySourceResolution(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _graphYAxis,
        );
        notifyListeners();
    }

    Future<TautulliGraphData> _playCountByStreamResolutionGraph;
    Future<TautulliGraphData> get playCountByStreamResolutionGraph => _playCountByStreamResolutionGraph;
    set playCountByStreamResolutionGraph(Future<TautulliGraphData> playCountByStreamResolutionGraph) {
        assert(playCountByStreamResolutionGraph != null);
        _playCountByStreamResolutionGraph = playCountByStreamResolutionGraph;
        notifyListeners();
    }

    void resetPlayCountByStreamResolutionGraph() {
        if(_api != null) _playCountByStreamResolutionGraph = _api.history.getPlaysByStreamResolution(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _graphYAxis,
        );
        notifyListeners();
    }

    Future<TautulliGraphData> _playCountByPlatformStreamTypeGraph;
    Future<TautulliGraphData> get playCountByPlatformStreamTypeGraph => _playCountByPlatformStreamTypeGraph;
    set playCountByPlatformStreamTypeGraph(Future<TautulliGraphData> playCountByPlatformStreamTypeGraph) {
        assert(playCountByPlatformStreamTypeGraph != null);
        _playCountByPlatformStreamTypeGraph = playCountByPlatformStreamTypeGraph;
        notifyListeners();
    }

    void resetPlayCountByPlatformStreamTypeGraph() {
        if(_api != null) _playCountByPlatformStreamTypeGraph = _api.history.getStreamTypeByTopTenPlatforms(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _graphYAxis,
        );
        notifyListeners();
    }

    Future<TautulliGraphData> _playCountByUserStreamTypeGraph;
    Future<TautulliGraphData> get playCountByUserStreamTypeGraph => _playCountByUserStreamTypeGraph;
    set playCountByUserStreamTypeGraph(Future<TautulliGraphData> playCountByUserStreamTypeGraph) {
        assert(playCountByUserStreamTypeGraph != null);
        _playCountByUserStreamTypeGraph = playCountByUserStreamTypeGraph;
        notifyListeners();
    }

    void resetPlayCountByUserStreamTypeGraph() {
        if(_api != null) _playCountByUserStreamTypeGraph = _api.history.getStreamTypeByTopTenUsers(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _graphYAxis,
        );
        notifyListeners();
    }

    void resetAllStreamInformationGraphs() {
        resetDailyStreamTypeBreakdownGraph();
        resetPlayCountBySourceResolutionGraph();
        resetPlayCountByStreamResolutionGraph();
        resetPlayCountByPlatformStreamTypeGraph();
        resetPlayCountByUserStreamTypeGraph();
    }

    /////////////// 
    /// UPDATES ///
    ///////////////
    
    Future<TautulliPMSUpdate> _updatePlexMediaServer;
    Future<TautulliPMSUpdate> get updatePlexMediaServer => _updatePlexMediaServer;
    set updatePlexMediaServer(Future<TautulliPMSUpdate> updatePlexMediaServer) {
        assert(updatePlexMediaServer != null);
        _updatePlexMediaServer = updatePlexMediaServer;
        notifyListeners();
    }

    void resetUpdatePlexMediaServer() {
        if(_api != null) _updatePlexMediaServer = _api.system.getPMSUpdate();
        notifyListeners();
    }

    Future<TautulliUpdateCheck> _updateTautulli;
    Future<TautulliUpdateCheck> get updateTautulli => _updateTautulli;
    set updateTautulli(Future<TautulliUpdateCheck> updateTautulli) {
        assert(updateTautulli != null);
        _updateTautulli = updateTautulli;
        notifyListeners();
    }

    void resetUpdateTautulli() {
        if(_api != null) _updateTautulli = _api.system.updateCheck();
        notifyListeners();
    }

    void resetAllUpdates() {
        resetUpdatePlexMediaServer();
        resetUpdateTautulli();
    }

    /////////////////
    /// LIBRARIES ///
    /////////////////
    
    Future<TautulliLibrariesTable> _librariesTable;
    Future<TautulliLibrariesTable> get librariesTable => _librariesTable;
    set librariesTable(Future<TautulliLibrariesTable> librariesTable) {
        assert(librariesTable != null);
        _librariesTable = librariesTable;
        notifyListeners();
    }

    void resetLibrariesTable() {
        if(_api != null) _librariesTable = _api.libraries.getLibrariesTable(
            length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
            orderColumn: TautulliLibrariesOrderColumn.SECTION_NAME,
            orderDirection: TautulliOrderDirection.ASCENDING,
        );
        notifyListeners();
    }

    ////////////////
    /// METADATA ///
    ////////////////
    
    Map<int, Future<TautulliMetadata>> _metadata = {};
    Map<int, Future<TautulliMetadata>> get metadata => _metadata;
    void setMetadata(int ratingKey, Future<TautulliMetadata> metadata) {
        assert(ratingKey != null);
        assert(metadata != null);
        _metadata[ratingKey] = metadata;
        notifyListeners();
    }

    /////////////////////
    /// LIBRARY STATS ///
    /////////////////////
    
    Map<int, Future<List<TautulliLibraryWatchTimeStats>>> _libraryWatchTimeStats = {};
    Map<int, Future<List<TautulliLibraryWatchTimeStats>>> get libraryWatchTimeStats => _libraryWatchTimeStats;
    void fetchLibraryWatchTimeStats(int sectionId) {
        assert(sectionId != null);
        _libraryWatchTimeStats[sectionId] = _api.libraries.getLibraryWatchTimeStats(sectionId: sectionId);
        notifyListeners();
    }

    Map<int, Future<List<TautulliLibraryUserStats>>> _libraryUserStats = {};
    Map<int, Future<List<TautulliLibraryUserStats>>> get libraryUserStats => _libraryUserStats;
    void fetchLibraryUserStats(int sectionId) {
        assert(sectionId != null);
        _libraryUserStats[sectionId] = _api.libraries.getLibraryUserStats(sectionId: sectionId);
        notifyListeners();
    }

    //////////////
    /// SEARCH ///
    //////////////
    
    String _searchQuery = '';
    String get searchQuery => _searchQuery;
    set searchQuery(String searchQuery) {
        assert(searchQuery != null);
        _searchQuery = searchQuery;
        notifyListeners();
    }

    Future<TautulliSearch> _search;
    Future<TautulliSearch> get search => _search;
    void fetchSearch() {
        _search = _api.libraries.search(
            query: _searchQuery,
            limit: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
        );
        notifyListeners();
    }

    //////////////////
    /// IP ADDRESS ///
    //////////////////
    
    Map<String, Future<TautulliGeolocationInfo>> _geolocationInformation = {};
    Map<String, Future<TautulliGeolocationInfo>> get geolocationInformation => _geolocationInformation;
    void fetchGeolocationInformation(String ipAddress) {
        assert(ipAddress != null);
        _geolocationInformation[ipAddress] = _api.miscellaneous.getGeoIPLookup(ipAddress: ipAddress);
        notifyListeners();
    }

    Map<String, Future<TautulliWHOISInfo>> _whoisInformation = {};
    Map<String, Future<TautulliWHOISInfo>> get whoisInformation => _whoisInformation;
    void fetchWHOISInformation(String ipAddress) {
        assert(ipAddress != null);
        _whoisInformation[ipAddress] = _api.miscellaneous.getWHOISLookup(ipAddress: ipAddress);
        notifyListeners();
    }

    /*********
    * IMAGES *
    *********/

    /// Get the direct URL to an image via `pms_image_proxy` using a rating key.
    String getImageURLFromRatingKey(int ratingKey, { int width = 300 }) {
        if(host.endsWith('/')) return [
            host,
            'api/v2?apikey=$apiKey',
            '&cmd=pms_image_proxy',
            '&rating_key=$ratingKey',
            '&width=$width',
        ].join();
        return [
            host,
            '/api/v2?apikey=$apiKey',
            '&cmd=pms_image_proxy',
            '&rating_key=$ratingKey',
            '&width=$width',
        ].join();
    }

    /// Get the direct URL to an image via `pms_image_proxy` using an image path.
    String getImageURLFromPath(String path, { int width = 300 }) {
        if(host.endsWith('/')) return [
            host,
            'api/v2?apikey=$apiKey',
            '&cmd=pms_image_proxy',
            '&img=$path',
            '&width=$width',
        ].join();
        return [
            host,
            '/api/v2?apikey=$apiKey',
            '&cmd=pms_image_proxy',
            '&img=$path',
            '&width=$width',
        ].join();
    }
}
