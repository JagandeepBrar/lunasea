import 'package:flutter/foundation.dart';

class SettingsState extends ChangeNotifier {
    SettingsState() {
        reset(initialize: true);
    }

    /// Reset the state of Home back to the default
    /// 
    /// If `initialize` is true, resets everything.
    /// If false, the navigation index, etc. are not reset.
    void reset({ bool initialize = false }) {
        if(initialize) {
            _navigationIndex = 0;
        }
    }

    int _navigationIndex;
    int get navigationIndex => _navigationIndex;
    set navigationIndex(int navigationIndex) {
        assert(navigationIndex != null);
        _navigationIndex = navigationIndex;
        notifyListeners();
    }
}
