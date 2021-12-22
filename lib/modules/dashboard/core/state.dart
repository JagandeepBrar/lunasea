import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';

class DashboardState extends LunaModuleState {
  DashboardState() {
    reset();
  }

  @override
  void reset() {
    resetToday();
    resetAPI();
    resetUpcoming();
  }

  CalendarStartingType _calendarStartingType =
      DashboardDatabaseValue.CALENDAR_STARTING_TYPE.data;
  CalendarStartingType get calendarStartingType => _calendarStartingType;
  set calendarStartingType(CalendarStartingType calendarStartingType) {
    assert(calendarStartingType != null);
    _calendarStartingType = calendarStartingType;
    notifyListeners();
  }

  CalendarAPI _api;
  CalendarAPI get api => _api;
  void resetAPI() {
    ProfileHiveObject _profile = Database.currentProfileObject;
    _api = CalendarAPI.from(_profile);
    notifyListeners();
  }

  DateTime _today;
  DateTime get today => _today;
  void resetToday() {
    _today = DateTime.now();
    notifyListeners();
  }

  Future<Map<DateTime, List<CalendarData>>> _upcoming;
  Future<Map<DateTime, List<CalendarData>>> get upcoming => _upcoming;
  void resetUpcoming() {
    if (_api != null) _upcoming = _api.getUpcoming(DateTime.now());
    notifyListeners();
  }
}
