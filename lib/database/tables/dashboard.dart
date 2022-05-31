import 'package:lunasea/database/table.dart';
import 'package:lunasea/modules/dashboard/core/adapters/calendar_starting_day.dart';
import 'package:lunasea/modules/dashboard/core/adapters/calendar_starting_size.dart';
import 'package:lunasea/modules/dashboard/core/adapters/calendar_starting_type.dart';
import 'package:lunasea/vendor.dart';

enum DashboardDatabase<T> with LunaTableMixin<T> {
  NAVIGATION_INDEX<int>(0),
  CALENDAR_STARTING_DAY<CalendarStartingDay>(CalendarStartingDay.MONDAY),
  CALENDAR_STARTING_SIZE<CalendarStartingSize>(CalendarStartingSize.ONE_WEEK),
  CALENDAR_STARTING_TYPE<CalendarStartingType>(CalendarStartingType.CALENDAR),
  CALENDAR_ENABLE_LIDARR<bool>(true),
  CALENDAR_ENABLE_RADARR<bool>(true),
  CALENDAR_ENABLE_SONARR<bool>(true),
  CALENDAR_DAYS_PAST<int>(14),
  CALENDAR_DAYS_FUTURE<int>(14),
  CALENDAR_SHOW_PAST_DAYS<bool>(false);

  @override
  String get table => TABLE_DASHBOARD_KEY;

  @override
  final T defaultValue;

  const DashboardDatabase(this.defaultValue);

  @override
  void registerAdapters() {
    Hive.registerAdapter(CalendarStartingDayAdapter());
    Hive.registerAdapter(CalendarStartingSizeAdapter());
    Hive.registerAdapter(CalendarStartingTypeAdapter());
  }

  @override
  dynamic export() {
    if (this == DashboardDatabase.CALENDAR_STARTING_DAY) {
      return DashboardDatabase.CALENDAR_STARTING_DAY.read().key;
    }
    if (this == DashboardDatabase.CALENDAR_STARTING_SIZE) {
      return DashboardDatabase.CALENDAR_STARTING_SIZE.read().key;
    }
    if (this == DashboardDatabase.CALENDAR_STARTING_TYPE) {
      return DashboardDatabase.CALENDAR_STARTING_TYPE.read().key;
    }
    return super.export();
  }

  @override
  void import(dynamic value) {
    if (this == DashboardDatabase.CALENDAR_STARTING_DAY) {
      final item = CalendarStartingDay.MONDAY.fromKey(value.toString());
      if (item != null) update(item as T);
      return;
    }
    if (this == DashboardDatabase.CALENDAR_STARTING_SIZE) {
      final item = CalendarStartingSize.ONE_WEEK.fromKey(value.toString());
      if (item != null) return update(item as T);
      return;
    }
    if (this == DashboardDatabase.CALENDAR_STARTING_TYPE) {
      final item = CalendarStartingType.CALENDAR.fromKey(value.toString());
      if (item != null) return update(item as T);
      return;
    }
    return super.import(value);
  }
}
