import 'package:flutter/foundation.dart';

class NZBGetModel extends ChangeNotifier {
    bool _error = false;
    bool get error => _error;
    set error(bool error) {
        assert(error != null);
        _error = error;
        notifyListeners();
    }

    bool _paused = true;
    bool get paused => _paused;
    set paused(bool paused) {
        assert(paused != null);
        _paused = paused;
        notifyListeners();
    }

    int _speed = 0;
    int get speed => _speed;
    set speed(int speed) {
        assert(speed != null);
        _speed = speed;
        notifyListeners();
    }

    String _currentSpeed = '0.0 B/s';
    String get currentSpeed => _currentSpeed;
    set currentSpeed(String currentSpeed) {
        assert(currentSpeed != null);
        _currentSpeed = currentSpeed;
        notifyListeners();
    }

    String _queueTimeLeft = '0:00:00';
    String get queueTimeLeft => _queueTimeLeft;
    set queueTimeLeft(String queueTimeLeft) {
        assert(queueTimeLeft != null);
        _queueTimeLeft = queueTimeLeft;
        notifyListeners();
    }

    String _queueSizeLeft = '0.0 B';
    String get queueSizeLeft => _queueSizeLeft;
    set queueSizeLeft(String queueSizeLeft) {
        assert(queueSizeLeft != null);
        _queueSizeLeft = queueSizeLeft;
        notifyListeners();
    }

    String _speedLimit = '0.0 B';
    String get speedLimit => _speedLimit;
    set speedLimit(String speedLimit) {
        assert(speedLimit != null);
        _speedLimit = speedLimit;
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

    int _navigationIndex = 0;
    int get navigationIndex => _navigationIndex;
    set navigationIndex(int navigationIndex) {
        assert(navigationIndex != null);
        _navigationIndex = navigationIndex;
        notifyListeners();
    }
}
