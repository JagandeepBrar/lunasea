import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliState extends ChangeNotifier {
    TautulliState() {
        reset(initialize: true);
    }
    
    /// Reset the state of Tautulli back to the default
    /// 
    /// If `initialize` is true, resets everything, else it resets the profile + data.
    /// If false, the navigation index, etc. are not reset.
    void reset({ bool initialize = false }) {
        if(initialize) {
            _statisticsType = TautulliStatsType.PLAYS;
            _statisticsTimeRange = TautulliStatisticsTimeRange.ONE_MONTH;
            _graphYAxis = TautulliGraphYAxis.PLAYS;
        }
        resetProfile();
        resetActivity();
        resetUsers();
        resetHistory();
        notifyListeners();
    }

    GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
    GlobalKey<ScaffoldState> rootScaffoldKey = GlobalKey<ScaffoldState>();

    /**********
    * PROFILE *
    **********/

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

    /// Is strict TLS enabled?
    bool _strictTLS;
    bool get strictTLS => _strictTLS;

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
        _strictTLS = _profile.tautulliStrictTLS ?? true;
        _headers = _profile.tautulliHeaders ?? {};
        // Create the API instance if Tautulli is enabled
        _api = _enabled
            ? Tautulli(
                host: _host,
                apiKey: _apiKey,
                strictTLS: _strictTLS,
                headers: Map<String, dynamic>.from(_headers),
            )
            : null;
    }

    /***********
    * ACTIVITY *
    ************/
    
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

    /********
    * USERS *
    ********/

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

    /**********
    * HISTORY *
    **********/

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

    /***********
    * STATISTICS
    ***********/

    /// Stores the time range for the statistics
    TautulliStatisticsTimeRange _statisticsTimeRange;
    TautulliStatisticsTimeRange get statisticsTimeRange => _statisticsTimeRange;
    set statisticsTimeRange(TautulliStatisticsTimeRange statisticsTimeRange) {
        assert(statisticsTimeRange != null);
        _statisticsTimeRange = statisticsTimeRange;
        notifyListeners();
    }

    /// Stores the type of statistics
    TautulliStatsType _statisticsType;
    TautulliStatsType get statisticsType => _statisticsType;
    set statisticsType(TautulliStatsType statisticsType) {
        assert(statisticsType != null);
        _statisticsType = statisticsType;
        notifyListeners();
    }

    /*********
    * GRAPHS *
    *********/

    /// Store the graph Y axis
    TautulliGraphYAxis _graphYAxis;
    TautulliGraphYAxis get graphYAxis => _graphYAxis;
    set graphYAxis(TautulliGraphYAxis graphYAxis) {
        assert(graphYAxis != null);
        _graphYAxis = graphYAxis;
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
