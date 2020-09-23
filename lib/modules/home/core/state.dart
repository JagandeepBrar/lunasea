import 'package:flutter/foundation.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class HomeState extends ChangeNotifier implements LunaGlobalState {
    @override
    void reset() {}
    
    int _navigationIndex = HomeDatabaseValue.NAVIGATION_INDEX.data;
    int get navigationIndex => _navigationIndex;
    set navigationIndex(int navigationIndex) {
        assert(navigationIndex != null);
        _navigationIndex = navigationIndex;
        notifyListeners();
    }

    CalendarStartingType _calendarStartingType = HomeDatabaseValue.CALENDAR_STARTING_TYPE.data;
    CalendarStartingType get calendarStartingType => _calendarStartingType;
    set calendarStartingType(CalendarStartingType calendarStartingType) {
        assert(calendarStartingType != null);
        _calendarStartingType = calendarStartingType;
        notifyListeners();
    }
}
