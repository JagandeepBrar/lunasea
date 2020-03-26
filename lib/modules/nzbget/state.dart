import 'package:flutter/foundation.dart';

class NZBGetModel extends ChangeNotifier {
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

    String _currentSpeed = '';
    String get currentSpeed => _currentSpeed;
    set currentSpeed(String currentSpeed) {
        assert(currentSpeed != null);
        _currentSpeed = currentSpeed;
        notifyListeners();
    }
}
