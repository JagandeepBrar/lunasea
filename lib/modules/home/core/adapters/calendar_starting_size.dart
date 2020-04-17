import 'package:flutter/material.dart';
import 'package:lunasea/core/database/database.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_starting_size.g.dart';

@HiveType(typeId: 13, adapterName: 'CalendarStartingSizeAdapter')
enum CalendarStartingSize {
    @HiveField(0)
    ONE_WEEK,
    @HiveField(1)
    TWO_WEEKS,
    @HiveField(2)
    ONE_MONTH,
}

extension CalendarStartingSizeExtension on CalendarStartingSize {
    CalendarFormat get data {
        switch(this) {
            case CalendarStartingSize.TWO_WEEKS: return CalendarFormat.twoWeeks;
            case CalendarStartingSize.ONE_MONTH: return CalendarFormat.month;
            case CalendarStartingSize.ONE_WEEK:
            default: return CalendarFormat.week;
        }
    }

    String get name {
        switch(this) {
            case CalendarStartingSize.TWO_WEEKS: return 'Two Weeks';
            case CalendarStartingSize.ONE_MONTH: return 'One Month';
            case CalendarStartingSize.ONE_WEEK:
            default: return 'One Week';
        }
    }

    IconData get icon {
        switch(this) {
            case CalendarStartingSize.TWO_WEEKS: return Icons.photo_size_select_large;
            case CalendarStartingSize.ONE_MONTH: return Icons.photo_size_select_actual;
            case CalendarStartingSize.ONE_WEEK:
            default: return Icons.photo_size_select_small;
        }
    }
}
