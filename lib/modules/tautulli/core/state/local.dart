import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLocalState extends ChangeNotifier {
    /************
    * USER DATA *
    ************/

    /// Storing individual user profile data
    Map<int, Future<TautulliUser>> _userProfile = {};
    Map<int, Future<TautulliUser>> get userProfile => _userProfile;
    void setUserProfile(int userId, Future<TautulliUser> data) {
        assert(userId != null);
        assert(data != null);
        _userProfile[userId] = data;
        notifyListeners();
    }

    /// Storing individual user synced items
    Map<int, Future<List<TautulliSyncedItem>>> _userSyncedItems = {};
    Map<int, Future<List<TautulliSyncedItem>>> get userSyncedItems => _userSyncedItems;
    void setUserSyncedItems(int userId, Future<List<TautulliSyncedItem>> data) {
        assert(userId != null);
        assert(data != null);
        _userSyncedItems[userId] = data;
        notifyListeners();
    }

    /// Storing individual user IP addresses
    Map<int, Future<TautulliUserIPs>> _userIPs = {};
    Map<int, Future<TautulliUserIPs>> get userIPs => _userIPs;
    void setUserIPs(int userId, Future<TautulliUserIPs> data) {
        assert(userId != null);
        assert(data != null);
        _userIPs[userId] = data;
        notifyListeners();
    }

    /// Storing individual user watch time stats
    Map<int, Future<List<TautulliUserWatchTimeStats>>> _userWatchStats = {};
    Map<int, Future<List<TautulliUserWatchTimeStats>>> get userWatchStats => _userWatchStats;
    void setUserWatchStats(int userId, Future<List<TautulliUserWatchTimeStats>> data) {
        assert(userId != null);
        assert(data != null);
        _userWatchStats[userId] = data;
        notifyListeners();
    }

    /// Storing individual user player stats
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

    /***************
    * SYNCED ITEMS *
    ***************/

    /// Storing the synced items table
    Future<List<TautulliSyncedItem>> _syncedItems;
    Future<List<TautulliSyncedItem>> get syncedItems => _syncedItems;
    set syncedItems(Future<List<TautulliSyncedItem>> syncedItems) {
        assert(syncedItems != null);
        _syncedItems = syncedItems;
        notifyListeners();
    }

    /// Reset the synced items by:
    /// - Setting the intial state of the future to an instance of the API call
    void resetSyncedItems(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) {
            _syncedItems = _state.api.libraries.getSyncedItems();
        }
        notifyListeners();
    }

    /*************
    * STATISTICS *
    *************/

    /// Storing the statistics table
    Future<List<TautulliHomeStats>> _statistics;
    Future<List<TautulliHomeStats>> get statistics => _statistics;
    set statistics(Future<List<TautulliHomeStats>> statistics) {
        assert(statistics != null);
        _statistics = statistics;
        notifyListeners();
    }

    /// Reset the statistics by:
    /// - Setting the intial state of the future to an instance of the API call
    void resetStatistics(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) {
            _statistics = _state.api.history.getHomeStats(
                timeRange: _state.statisticsTimeRange?.value,
                statsType: _state.statisticsType,
                statsCount: TautulliDatabaseValue.STATISTICS_STATS_COUNT.data,
            );
        }
        notifyListeners();
    }

    /*****************
    * RECENTLY ADDED *
    *****************/
    
    /// Storing the recently added table
    Future<List<TautulliRecentlyAdded>> _recentlyAdded;
    Future<List<TautulliRecentlyAdded>> get recentlyAdded => _recentlyAdded;
    set recentlyAdded(Future<List<TautulliRecentlyAdded>> recentlyAdded) {
        assert(recentlyAdded != null);
        _recentlyAdded = recentlyAdded;
        notifyListeners();
    }

    /// Reset the recently added by:
    /// - Setting the intial state of the future to an instance of the API call
    void resetRecentlyAdded(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) {
            _recentlyAdded = _state.api.libraries.getRecentlyAdded(
                count: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
            );
        }
        notifyListeners();
    }

    /*******
    * LOGS *
    *******/

    /// Storing login logs table
    Future<TautulliUserLogins> _loginLogs;
    Future<TautulliUserLogins> get loginLogs => _loginLogs;
    set loginLogs(Future<TautulliUserLogins> loginLogs) {
        assert(loginLogs != null);
        _loginLogs = loginLogs;
        notifyListeners();
    }

    /// Reset the login logs by:
    /// - Setting the initial state of the future to an instance of the API call
    void resetLoginLogs(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) {
            _loginLogs = _state.api.users.getUserLogins(
                length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
            );
        }
        notifyListeners();
    }

    /// Storing newsletter logs table
    Future<TautulliNewsletterLogs> _newsletterLogs;
    Future<TautulliNewsletterLogs> get newsletterLogs => _newsletterLogs;
    set newsletterLogs(Future<TautulliNewsletterLogs> newsletterLogs) {
        assert(newsletterLogs != null);
        _newsletterLogs = newsletterLogs;
        notifyListeners();
    }

    /// Reset the newsletter logs by:
    /// - Setting the initial state of the future to an instance of the API call
    void resetNewsletterLogs(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) {
            _newsletterLogs = _state.api.notifications.getNewsletterLog(
                length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
            );
        }
        notifyListeners();
    }

    /// Storing notification logs table
    Future<TautulliNotificationLogs> _notificationLogs;
    Future<TautulliNotificationLogs> get notificationLogs => _notificationLogs;
    set notificationLogs(Future<TautulliNotificationLogs> notificationLogs) {
        assert(notificationLogs != null);
        _notificationLogs = notificationLogs;
        notifyListeners();
    }

    /// Reset the newsletter logs by:
    /// - Setting the initial state of the future to an instance of the API call
    void resetNotificationLogs(BuildContext context) {
        TautulliState _state = Provider.of<TautulliState>(context, listen: false);
        if(_state.api != null) {
            _notificationLogs = _state.api.notifications.getNotificationLog(
                length: TautulliDatabaseValue.CONTENT_LOAD_LENGTH.data,
            );
        }
        notifyListeners();
    }
}
