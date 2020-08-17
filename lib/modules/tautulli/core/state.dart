import 'package:flutter/foundation.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart' hide Tautulli;
import 'package:tautulli/tautulli.dart';

class TautulliState extends ChangeNotifier {
    TautulliState() {
        reset(notify: false);
    }
    
    void reset({ bool notify = true }) {
        _resetProfile();
        _navigationIndex = TautulliDatabaseValue.NAVIGATION_INDEX.data;
        if(notify) {
            print('notified');
            notifyListeners();
        }
    }

    /// ------- ///
    /// PROFILE ///
    /// ------- ///

    Tautulli _api;
    Tautulli get api => _api;

    bool _enabled;
    bool get enabled => _enabled;

    String _host;
    String get host => _host;

    String _apiKey;
    String get apiKey => _apiKey;

    bool _strictTLS;
    bool get strictTLS => _strictTLS;

    Map<dynamic, dynamic> _headers;
    Map<dynamic, dynamic> get headers => _headers;

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

    /// ---------- ///
    /// NAVIGATION ///
    /// ---------- ///

    int _navigationIndex;
    int get navigationIndex => _navigationIndex;
    set navigationIndex(int navigationIndex) {
        assert(navigationIndex != null);
        _navigationIndex = navigationIndex;
        notifyListeners();
    }
}
