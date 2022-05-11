import 'package:flutter/material.dart';
import 'package:lunasea/vendor.dart';

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
  }

  IconData get icon {
    switch (this) {
      case CalendarStartingSize.ONE_WEEK:
        return Icons.photo_size_select_small_rounded;
      case CalendarStartingSize.TWO_WEEKS:
        return Icons.photo_size_select_large_rounded;
      case CalendarStartingSize.ONE_MONTH:
        return Icons.photo_size_select_actual_rounded;
    }
  }

  CalendarStartingSize? fromKey(String key) {
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
