import 'package:flutter/material.dart';

import '../../../core/database/database.dart';
import '../../../core/database/module_database.dart';
import '../../../core/utilities/logger.dart';
import '../../../vendor.dart';
import 'adapters/calendar_starting_day.dart';
import 'adapters/calendar_starting_size.dart';
import 'adapters/calendar_starting_type.dart';

enum DashboardDatabaseValue {
  NAVIGATION_INDEX,
  CALENDAR_STARTING_DAY,
  CALENDAR_STARTING_SIZE,
  CALENDAR_STARTING_TYPE,
  CALENDAR_ENABLE_LIDARR,
  CALENDAR_ENABLE_RADARR,
  CALENDAR_ENABLE_SONARR,
  CALENDAR_DAYS_PAST,
  CALENDAR_DAYS_FUTURE,
  CALENDAR_SHOW_PAST_DAYS,
}

class DashboardDatabase extends LunaModuleDatabase {
  @override
  void registerAdapters() {
    Hive.registerAdapter(CalendarStartingDayAdapter());
    Hive.registerAdapter(CalendarStartingSizeAdapter());
    Hive.registerAdapter(CalendarStartingTypeAdapter());
  }

  @override
  Map<String, dynamic> export() {
    Map<String, dynamic> data = {};
    for (DashboardDatabaseValue value in DashboardDatabaseValue.values) {
      switch (value) {
        case DashboardDatabaseValue.CALENDAR_STARTING_DAY:
          final db = DashboardDatabaseValue.CALENDAR_STARTING_DAY.data;
          data[value.key] = (db as CalendarStartingDay).key;
          break;
        case DashboardDatabaseValue.CALENDAR_STARTING_SIZE:
          final db = DashboardDatabaseValue.CALENDAR_STARTING_SIZE.data;
          data[value.key] = (db as CalendarStartingSize).key;
          break;
        case DashboardDatabaseValue.CALENDAR_STARTING_TYPE:
          final db = DashboardDatabaseValue.CALENDAR_STARTING_TYPE.data;
          data[value.key] = (db as CalendarStartingType).key;
          break;
        default:
          data[value.key] = value.data;
          break;
      }
    }
    return data;
  }

  @override
  void import(Map<String, dynamic> config) {
    for (String key in config.keys) {
      DashboardDatabaseValue? value = valueFromKey(key);
      if (value != null) {
        switch (value) {
          case DashboardDatabaseValue.CALENDAR_STARTING_DAY:
            value.put(CalendarStartingDay.MONDAY.fromKey(config[key]));
            break;
          case DashboardDatabaseValue.CALENDAR_STARTING_SIZE:
            value.put(CalendarStartingSize.ONE_WEEK.fromKey(config[key]));
            break;
          case DashboardDatabaseValue.CALENDAR_STARTING_TYPE:
            value.put(CalendarStartingType.CALENDAR.fromKey(config[key]));
            break;
          default:
            value.put(config[key]);
            break;
        }
      }
    }
  }

  @override
  DashboardDatabaseValue? valueFromKey(String key) {
    for (DashboardDatabaseValue value in DashboardDatabaseValue.values) {
      if (value.key == key) return value;
    }
    return null;
  }
}

extension DashboardDatabaseValueExtension on DashboardDatabaseValue {
  String get key {
    return 'HOME_${this.name}';
  }

  dynamic get data {
    return Database.lunasea.box.get(this.key, defaultValue: this._defaultValue);
  }

  void put(dynamic value) {
    if (this._isTypeValid(value)) {
      Database.lunasea.box.put(this.key, value);
    } else {
      LunaLogger().warning(
        this.runtimeType.toString(),
        'put',
        'Invalid Database Insert (${this.key}, ${value.runtimeType})',
      );
    }
  }

  ValueListenableBuilder listen({
    Key? key,
    required Widget Function(BuildContext, dynamic, Widget?) builder,
  }) {
    return ValueListenableBuilder(
      key: key,
      valueListenable: Database.lunasea.box.listenable(keys: [this.key]),
      builder: builder,
    );
  }

  bool _isTypeValid(dynamic value) {
    switch (this) {
      case DashboardDatabaseValue.NAVIGATION_INDEX:
        return value is int;
      case DashboardDatabaseValue.CALENDAR_STARTING_DAY:
        return value is CalendarStartingDay;
      case DashboardDatabaseValue.CALENDAR_STARTING_SIZE:
        return value is CalendarStartingSize;
      case DashboardDatabaseValue.CALENDAR_STARTING_TYPE:
        return value is CalendarStartingType;
      case DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR:
        return value is bool;
      case DashboardDatabaseValue.CALENDAR_ENABLE_RADARR:
        return value is bool;
      case DashboardDatabaseValue.CALENDAR_ENABLE_SONARR:
        return value is bool;
      case DashboardDatabaseValue.CALENDAR_DAYS_PAST:
        return value is int;
      case DashboardDatabaseValue.CALENDAR_DAYS_FUTURE:
        return value is int;
      case DashboardDatabaseValue.CALENDAR_SHOW_PAST_DAYS:
        return value is bool;
    }
  }

  dynamic get _defaultValue {
    switch (this) {
      case DashboardDatabaseValue.NAVIGATION_INDEX:
        return 0;
      case DashboardDatabaseValue.CALENDAR_STARTING_DAY:
        return CalendarStartingDay.MONDAY;
      case DashboardDatabaseValue.CALENDAR_STARTING_SIZE:
        return CalendarStartingSize.ONE_WEEK;
      case DashboardDatabaseValue.CALENDAR_STARTING_TYPE:
        return CalendarStartingType.CALENDAR;
      case DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR:
        return true;
      case DashboardDatabaseValue.CALENDAR_ENABLE_RADARR:
        return true;
      case DashboardDatabaseValue.CALENDAR_ENABLE_SONARR:
        return true;
      case DashboardDatabaseValue.CALENDAR_DAYS_PAST:
        return 14;
      case DashboardDatabaseValue.CALENDAR_DAYS_FUTURE:
        return 14;
      case DashboardDatabaseValue.CALENDAR_SHOW_PAST_DAYS:
        return false;
    }
  }
}
