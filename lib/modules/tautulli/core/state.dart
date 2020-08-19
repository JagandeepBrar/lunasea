import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart' hide Tautulli;
import 'package:tautulli/tautulli.dart';

class TautulliState extends ChangeNotifier {
    TautulliState() {
        reset();
    }
    
    /// Reset the entire state of Tautulli back to the default
    void reset() {
        _resetProfile();
        _resetActivityTimer();
        _navigationIndex = TautulliDatabaseValue.NAVIGATION_INDEX.data;
        notifyListeners();
    }

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
    void _resetProfile() {
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

    /*************
    * NAVIGATION *
    *************/

    /// Index for the main page navigation bar
    int _navigationIndex;
    int get navigationIndex => _navigationIndex;
    set navigationIndex(int navigationIndex) {
        assert(navigationIndex != null);
        _navigationIndex = navigationIndex;
        notifyListeners();
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

    /// Reset the activity by:
    /// - Cancelling the timer
    /// - Recreating the timer
    /// - Setting the initial state of future to an instance of the API call
    void _resetActivityTimer() {
        cancelActivityTimer();
        if(_api != null) {
            _activity = _api.activity.getActivity();
            createActivityTimer();
        }
    }

    /// Storing activity data
    Future<TautulliActivity> _activity;
    Future<TautulliActivity> get activity => _activity;
    set activity(Future<TautulliActivity> activity) {
        assert(activity != null);
        _activity = activity;
        notifyListeners();
    }

    /*********
    * IMAGES *
    *********/

    /// Get the direct URL to an image via `pms_image_proxy` using a rating key.
    String getImageURLFromRatingKey(int ratingKey) => host.endsWith('/')
        ? '${host}api/v2?apikey=$apiKey&cmd=pms_image_proxy&rating_key=$ratingKey'
        : '$host/api/v2?apikey=$apiKey&cmd=pms_image_proxy&rating_key=$ratingKey';

    /// Get the direct URL to an image via `pms_image_proxy` using an image path.
    String getImageURLFromPath(String path) => host.endsWith('/')
        ? '${host}api/v2?apikey=$apiKey&cmd=pms_image_proxy&img=$path'
        : '$host/api/v2?apikey=$apiKey&cmd=pms_image_proxy&img=$path';
}
