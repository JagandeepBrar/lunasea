import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/core/database/database.dart';

part 'calendar_starting_type.g.dart';

@HiveType(typeId: 15, adapterName: 'CalendarStartingTypeAdapter')
enum CalendarStartingType {
    @HiveField(0)
    CALENDAR,
    @HiveField(1)
    SCHEDULE,
}

extension CalendarStartingTypeExtension on CalendarStartingType {
    String get data {
        switch(this) {
            case CalendarStartingType.SCHEDULE: return 'schedule';
            case CalendarStartingType.CALENDAR:
            default: return 'calendar';
        }
    }

    String get name {
        switch(this) {
            case CalendarStartingType.SCHEDULE: return 'Schedule';
            case CalendarStartingType.CALENDAR:
            default: return 'Calendar';
        }
    }

    IconData get icon {
        switch(this) {
            case CalendarStartingType.SCHEDULE: return Icons.calendar_view_day;
            case CalendarStartingType.CALENDAR:
            default: return CustomIcons.calendar;
        }
    }
}