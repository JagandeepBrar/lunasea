import 'package:flutter/foundation.dart';

class HomeModel extends ChangeNotifier {
    int _navigationIndex = 0;
    int get navigationIndex => _navigationIndex;
    set navigationIndex(int navigationIndex) {
        assert(navigationIndex != null);
        _navigationIndex = navigationIndex;
        notifyListeners();
    }

    bool _showCalendarSchedule = false;
    bool get showCalendarSchedule => _showCalendarSchedule;
    set showCalendarSchedule(bool showCalendarSchedule) {
        assert(showCalendarSchedule != null);
        _showCalendarSchedule = showCalendarSchedule;
        notifyListeners();
    }
}