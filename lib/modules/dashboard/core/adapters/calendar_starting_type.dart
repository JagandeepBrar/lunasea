import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'calendar_starting_type.g.dart';

@HiveType(typeId: 15, adapterName: 'CalendarStartingTypeAdapter')
enum CalendarStartingType {
  @HiveField(0)
  CALENDAR,
  @HiveField(1)
  SCHEDULE,
}

extension CalendarStartingTypeExtension on CalendarStartingType {
  String get name {
    switch (this) {
      case CalendarStartingType.SCHEDULE:
        return 'dashboard.Schedule'.tr();
      case CalendarStartingType.CALENDAR:
        return 'dashboard.Calendar'.tr();
    }
    throw Exception('Invalid CalendarStartingType');
  }

  String get key {
    switch (this) {
      case CalendarStartingType.SCHEDULE:
        return 'schedule';
      case CalendarStartingType.CALENDAR:
        return 'calendar';
    }
    throw Exception('Invalid CalendarStartingType');
  }

  IconData get icon {
    switch (this) {
      case CalendarStartingType.SCHEDULE:
        return LunaIcons.calendar;
      case CalendarStartingType.CALENDAR:
        return Icons.calendar_view_day;
    }
    throw Exception('Invalid CalendarStartingType');
  }

  CalendarStartingType fromKey(String key) {
    switch (key) {
      case 'schedule':
        return CalendarStartingType.SCHEDULE;
      case 'calendar':
        return CalendarStartingType.CALENDAR;
      default:
        return null;
    }
  }
}
