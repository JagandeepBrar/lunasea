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
    
    Future<TautulliGraphData> _playCountByDateGraph;
    Future<TautulliGraphData> get playCountByDateGraph => _playCountByDateGraph;
    set playCountByDateGraph(Future<TautulliGraphData> playCountByDateGraph) {
        assert(playCountByDateGraph != null);
        _playCountByDateGraph = playCountByDateGraph;
        notifyListeners();
    }

    void _resetPlayCountByDateGraph(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) _playCountByDateGraph = _state.api.history.getPlaysByDate(
            timeRange: TautulliDatabaseValue.GRAPHS_DAYS.data,
            yAxis: _state.graphYAxis,
        );
        notifyListeners();
    }

    void resetAllPlayPeriodGraphs(BuildContext context) {
        _resetPlayCountByDateGraph(context);
    }

    void resetAllStreamInfoGraphs(BuildContext context) {}
}
