import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';

class DashboardState extends LunaModuleState {
    @override
    void reset() {}
    
    int _navigationIndex = DashboardDatabaseValue.NAVIGATION_INDEX.data;
    int get navigationIndex => _navigationIndex;
    set navigationIndex(int navigationIndex) {
        assert(navigationIndex != null);
        _navigationIndex = navigationIndex;
        notifyListeners();
    }

    CalendarStartingType _calendarStartingType = DashboardDatabaseValue.CALENDAR_STARTING_TYPE.data;
    CalendarStartingType get calendarStartingType => _calendarStartingType;
    set calendarStartingType(CalendarStartingType calendarStartingType) {
        assert(calendarStartingType != null);
        _calendarStartingType = calendarStartingType;
        notifyListeners();
    }
}
