import 'package:flutter/foundation.dart';

class SABnzbdModel extends ChangeNotifier {
    bool _error = false;
    bool get error => _error;
    set error(bool error) {
        assert(error != null);
        _error = error;
        notifyListeners();
    }
    
    int _navigationIndex = 0;
    int get navigationIndex => _navigationIndex;
    set navigationIndex(int navigationIndex) {
        assert(navigationIndex != null);
        _navigationIndex = navigationIndex;
        notifyListeners();
    }

    String _historySearchFilter = '';
    String get historySearchFilter => _historySearchFilter;
    set historySearchFilter(String historySearchFilter) {
        assert(historySearchFilter != null);
        _historySearchFilter = historySearchFilter;
        notifyListeners();
    }

    bool _historyHideFailed = false;
    bool get historyHideFailed => _historyHideFailed;
    set historyHideFailed(bool historyHideFailed) {
        assert(historyHideFailed != null);
        _historyHideFailed = historyHideFailed;
        notifyListeners();
    }
}
