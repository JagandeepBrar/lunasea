import 'package:flutter/foundation.dart';
import 'package:lunasea/modules/home.dart';

class HomeState extends ChangeNotifier {
    HomeState() {
        reset(initialize: true);
    }

    /// Reset the state of Home back to the default
    /// 
    /// If `initialize` is true, resets everything.
    /// If false, the navigation index, etc. are not reset.
    void reset({ bool initialize = false }) {
        if(initialize) {
            _navigationIndex = HomeDatabaseValue.NAVIGATION_INDEX.data;
            _calendarStartingType = HomeDatabaseValue.CALENDAR_STARTING_TYPE.data;
        }
    }

    int _navigationIndex;
    int get navigationIndex => _navigationIndex;
    set navigationIndex(int navigationIndex) {
        assert(navigationIndex != null);
        _navigationIndex = navigationIndex;
        notifyListeners();
    }

    CalendarStartingType _calendarStartingType;
    CalendarStartingType get calendarStartingType => _calendarStartingType;
    set calendarStartingType(CalendarStartingType calendarStartingType) {
        assert(calendarStartingType != null);
        _calendarStartingType = calendarStartingType;
        notifyListeners();
    }
}
