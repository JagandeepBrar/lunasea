import 'package:lunasea/core/models/configuration/profile.dart';
import 'package:lunasea/core/state/module_state.dart';
import 'package:lunasea/system/profile.dart';
import 'package:lunasea/database/tables/dashboard.dart';
import 'package:lunasea/modules/dashboard/core/adapters/calendar_starting_type.dart';
import 'package:lunasea/modules/dashboard/core/api/api.dart';
import 'package:lunasea/modules/dashboard/core/api/data/abstract.dart';

class ModuleState extends LunaModuleState {
  ModuleState() {
    reset();
  }

  @override
  void reset() {
    resetToday();
    resetAPI();
    resetUpcoming();
  }

  CalendarStartingType _calendarStartingType =
      DashboardDatabase.CALENDAR_STARTING_TYPE.read();
  CalendarStartingType get calendarStartingType => _calendarStartingType;
  set calendarStartingType(CalendarStartingType calendarStartingType) {
    _calendarStartingType = calendarStartingType;
    notifyListeners();
  }

  API? _api;
  API? get api => _api;
  void resetAPI() {
    ProfileHiveObject? _profile = LunaProfile.current;
    _api = API.from(_profile);
    notifyListeners();
  }

  DateTime? _today;
  DateTime? get today => _today;
  void resetToday() {
    _today = DateTime.now();
    notifyListeners();
  }

  Future<Map<DateTime, List<CalendarData>>>? _upcoming;
  Future<Map<DateTime, List<CalendarData>>>? get upcoming => _upcoming;
  void resetUpcoming() {
    if (_api != null) _upcoming = _api!.getUpcoming(DateTime.now());
    notifyListeners();
  }
}
