import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
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
    switch (this) {
      case CalendarStartingSize.ONE_WEEK:
        return CalendarFormat.week;
      case CalendarStartingSize.TWO_WEEKS:
        return CalendarFormat.twoWeeks;
      case CalendarStartingSize.ONE_MONTH:
        return CalendarFormat.month;
    }
    throw Exception('Invalid CalendarStartingSize');
  }

  String get name {
    switch (this) {
      case CalendarStartingSize.ONE_WEEK:
        return 'dashboard.OneWeek'.tr();
      case CalendarStartingSize.TWO_WEEKS:
        return 'dashboard.TwoWeeks'.tr();
      case CalendarStartingSize.ONE_MONTH:
        return 'dashboard.OneMonth'.tr();
    }
  }

  String get key {
    switch (this) {
      case CalendarStartingSize.ONE_WEEK:
        return 'oneweek';
      case CalendarStartingSize.TWO_WEEKS:
        return 'twoweeks';
      case CalendarStartingSize.ONE_MONTH:
        return 'onemonth';
    }
    throw Exception('Invalid CalendarStartingSize');
  }

  IconData get icon {
    switch (this) {
      case CalendarStartingSize.ONE_WEEK:
        return Icons.photo_size_select_small;
      case CalendarStartingSize.TWO_WEEKS:
        return Icons.photo_size_select_large;
      case CalendarStartingSize.ONE_MONTH:
        return Icons.photo_size_select_actual;
    }
    throw Exception('Invalid CalendarStartingSize');
  }

  CalendarStartingSize fromKey(String key) {
    switch (key) {
      case 'oneweek':
        return CalendarStartingSize.ONE_WEEK;
      case 'twoweeks':
        return CalendarStartingSize.TWO_WEEKS;
      case 'onemonth':
        return CalendarStartingSize.ONE_MONTH;
      default:
        return null;
    }
  }
}
