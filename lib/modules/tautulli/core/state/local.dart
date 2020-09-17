import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLocalState extends ChangeNotifier {
    //////////////////
    /// NAVIGATION ///
    //////////////////

    int _userDetailsNavigationIndex = 0;
    int get userDetailsNavigationIndex => _userDetailsNavigationIndex;
    set userDetailsNavigationIndex(int userDetailsNavigationIndex) {
        assert(userDetailsNavigationIndex != null);
        _userDetailsNavigationIndex = userDetailsNavigationIndex;
        notifyListeners();
    }

    int _graphsNavigationIndex = 0;
    int get graphsNavigationIndex => _graphsNavigationIndex;
    set graphsNavigationIndex(int graphsNavigationIndex) {
        assert(graphsNavigationIndex != null);
        _graphsNavigationIndex = graphsNavigationIndex;
        notifyListeners();
    }

    int _mediaNavigationIndex = 0;
    int get mediaNavigationIndex => _mediaNavigationIndex;
    set mediaNavigationIndex(int mediaNavigationIndex) {
        assert(mediaNavigationIndex != null);
        _mediaNavigationIndex = mediaNavigationIndex;
        notifyListeners();
    }

    int _librariesDetailsNavigationIndex = 0;
    int get librariesDetailsNavigationIndex => _librariesDetailsNavigationIndex;
    set librariesDetailsNavigationIndex(int librariesDetailsNavigationIndex) {
        assert(librariesDetailsNavigationIndex != null);
        _librariesDetailsNavigationIndex = librariesDetailsNavigationIndex;
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

    ///////////////
    /// HISTORY ///
    ///////////////
    
    Map<int, Future<TautulliHistory>> _history = {};
    Map<int, Future<TautulliHistory>> get history => _history;
    void setHistory(int key, Future<TautulliHistory> data) {
        assert(key != null);
        assert(data != null);
        _history[key] = data;
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

    void resetSyncedItems(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _syncedItems = _state.api.libraries.getSyncedItems();
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

    void resetStatistics(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _statistics = _state.api.history.getHomeStats(
            timeRange: _state.statisticsTimeRange?.value,
            statsType: _state.statisticsType,
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

    void resetRecentlyAdded(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _recentlyAdded = _state.api.libraries.getRecentlyAdded(
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

    void resetLoginLogs(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _loginLogs = _state.api.users.getUserLogins(
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

    void resetNewsletterLogs(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _newsletterLogs = _state.api.notifications.getNewsletterLog(
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

    void resetNotificationLogs(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _notificationLogs = _state.api.notifications.getNotificationLog(
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

    void resetPlexMediaScannerLogs(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _plexMediaScannerLogs = _state.api.miscellaneous.getPlexLog(
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

    void resetPlexMediaServerLogs(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _plexMediaServerLogs = _state.api.miscellaneous.getPlexLog(
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

    void resetTautulliLogs(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _tautulliLogs = _state.api.miscellaneous.getLogs(
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

    void resetDailyPlayCountGraph(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _dailyPlayCountGraph = _state.api.history.getPlaysByDate(
            timeRange: TautulliDatabaseValue.GRAPHS_LINECHART_DAYS.data,
            yAxis: _state.graphYAxis,
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

    void resetPlaysByMonthGraph(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _playsByMonthGraph = _state.api.history.getPlaysPerMonth(
            timeRange: TautulliDatabaseValue.GRAPHS_MONTHS.data,
            yAxis: _state.graphYAxis,
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

    void resetPlayCountByDayOfWeekGraph(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _playCountByDayOfWeekGraph = _state.api.history.getPlaysByDayOfWeek(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _state.graphYAxis,
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

    void resetPlayCountByTopPlatformsGraph(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _playCountByTopPlatformsGraph = _state.api.history.getPlaysByTopTenPlatforms(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _state.graphYAxis,
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

    void resetPlayCountByTopUsersGraph(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _playCountByTopUsersGraph = _state.api.history.getPlaysByTopTenUsers(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _state.graphYAxis,
        );
        notifyListeners();
    }

    void resetAllPlayPeriodGraphs(BuildContext context) {
        resetDailyPlayCountGraph(context);
        resetPlaysByMonthGraph(context);
        resetPlayCountByDayOfWeekGraph(context);
        resetPlayCountByTopPlatformsGraph(context);
        resetPlayCountByTopUsersGraph(context);
    }

    Future<TautulliGraphData> _dailyStreamTypeBreakdownGraph;
    Future<TautulliGraphData> get dailyStreamTypeBreakdownGraph => _dailyStreamTypeBreakdownGraph;
    set dailyStreamTypeBreakdownGraph(Future<TautulliGraphData> dailyStreamTypeBreakdownGraph) {
        assert(dailyStreamTypeBreakdownGraph != null);
        _dailyStreamTypeBreakdownGraph = dailyStreamTypeBreakdownGraph;
        notifyListeners();
    }

    void resetDailyStreamTypeBreakdownGraph(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _dailyStreamTypeBreakdownGraph = _state.api.history.getPlaysByStreamType(
            timeRange: TautulliDatabaseValue.GRAPHS_LINECHART_DAYS.data,
            yAxis: _state.graphYAxis,
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

    void resetPlayCountBySourceResolutionGraph(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _playCountBySourceResolutionGraph = _state.api.history.getPlaysBySourceResolution(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _state.graphYAxis,
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

    void resetPlayCountByStreamResolutionGraph(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _playCountByStreamResolutionGraph = _state.api.history.getPlaysByStreamResolution(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _state.graphYAxis,
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

    void resetPlayCountByPlatformStreamTypeGraph(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _playCountByPlatformStreamTypeGraph = _state.api.history.getStreamTypeByTopTenPlatforms(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _state.graphYAxis,
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

    void resetPlayCountByUserStreamTypeGraph(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _playCountByUserStreamTypeGraph = _state.api.history.getStreamTypeByTopTenUsers(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _state.graphYAxis,
        );
        notifyListeners();
    }

    void resetAllStreamInformationGraphs(BuildContext context) {
        resetDailyStreamTypeBreakdownGraph(context);
        resetPlayCountBySourceResolutionGraph(context);
        resetPlayCountByStreamResolutionGraph(context);
        resetPlayCountByPlatformStreamTypeGraph(context);
        resetPlayCountByUserStreamTypeGraph(context);
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

    void resetUpdatePlexMediaServer(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _updatePlexMediaServer = _state.api.system.getPMSUpdate();
        notifyListeners();
    }

    Future<TautulliUpdateCheck> _updateTautulli;
    Future<TautulliUpdateCheck> get updateTautulli => _updateTautulli;
    set updateTautulli(Future<TautulliUpdateCheck> updateTautulli) {
        assert(updateTautulli != null);
        _updateTautulli = updateTautulli;
        notifyListeners();
    }

    void resetUpdateTautulli(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _updateTautulli = _state.api.system.updateCheck();
        notifyListeners();
    }

    void resetAllUpdates(BuildContext context) {
        resetUpdatePlexMediaServer(context);
        resetUpdateTautulli(context);
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

    void resetLibrariesTable(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _librariesTable = _state.api.libraries.getLibrariesTable(
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
    void fetchLibraryWatchTimeStats(BuildContext context, int sectionId) {
        assert(sectionId != null);
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        _libraryWatchTimeStats[sectionId] = _state.api.libraries.getLibraryWatchTimeStats(sectionId: sectionId);
        notifyListeners();
    }

    Map<int, Future<List<TautulliLibraryUserStats>>> _libraryUserStats = {};
    Map<int, Future<List<TautulliLibraryUserStats>>> get libraryUserStats => _libraryUserStats;
    void fetchLibraryUserStats(BuildContext context, int sectionId) {
        assert(sectionId != null);
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        _libraryUserStats[sectionId] = _state.api.libraries.getLibraryUserStats(sectionId: sectionId);
        notifyListeners();
    }
}
