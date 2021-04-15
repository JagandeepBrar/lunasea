import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';

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
        for(DashboardDatabaseValue value in DashboardDatabaseValue.values) {
            switch(value) {
                // Non-primitive values
                case DashboardDatabaseValue.CALENDAR_STARTING_DAY: data[value.key] = (DashboardDatabaseValue.CALENDAR_STARTING_DAY.data as CalendarStartingDay).key; break;
                case DashboardDatabaseValue.CALENDAR_STARTING_SIZE: data[value.key] = (DashboardDatabaseValue.CALENDAR_STARTING_SIZE.data as CalendarStartingSize).key; break;
                case DashboardDatabaseValue.CALENDAR_STARTING_TYPE: data[value.key] = (DashboardDatabaseValue.CALENDAR_STARTING_TYPE.data as CalendarStartingType).key; break;
                // Primitive values
                case DashboardDatabaseValue.NAVIGATION_INDEX:
                case DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR:
                case DashboardDatabaseValue.CALENDAR_ENABLE_RADARR:
                case DashboardDatabaseValue.CALENDAR_ENABLE_SONARR:
                case DashboardDatabaseValue.MODULES_BRAND_COLOURS:
                case DashboardDatabaseValue.CALENDAR_DAYS_PAST:
                case DashboardDatabaseValue.CALENDAR_DAYS_FUTURE: data[value.key] = value.data; break;
            }
        }
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        for(String key in config.keys) {
            DashboardDatabaseValue value = valueFromKey(key);
            if(value != null) {
                switch(value) {
                    // Non-primitive values
                    case DashboardDatabaseValue.CALENDAR_STARTING_DAY: value.put(CalendarStartingDay.MONDAY.fromKey(config[key])); break;
                    case DashboardDatabaseValue.CALENDAR_STARTING_SIZE: value.put(CalendarStartingSize.ONE_WEEK.fromKey(config[key])); break;
                    case DashboardDatabaseValue.CALENDAR_STARTING_TYPE: value.put(CalendarStartingType.CALENDAR.fromKey(config[key])); break;
                    // Primitive values
                    case DashboardDatabaseValue.NAVIGATION_INDEX:
                    case DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR:
                    case DashboardDatabaseValue.CALENDAR_ENABLE_RADARR:
                    case DashboardDatabaseValue.CALENDAR_ENABLE_SONARR:
                    case DashboardDatabaseValue.MODULES_BRAND_COLOURS:
                    case DashboardDatabaseValue.CALENDAR_DAYS_PAST:
                    case DashboardDatabaseValue.CALENDAR_DAYS_FUTURE: value.put(config[key]); break;
                }
            }
        }
    }

    @override
    DashboardDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'HOME_NAVIGATION_INDEX': return DashboardDatabaseValue.NAVIGATION_INDEX;
            case 'HOME_CALENDAR_STARTING_DAY': return DashboardDatabaseValue.CALENDAR_STARTING_DAY;
            case 'HOME_CALENDAR_STARTING_SIZE': return DashboardDatabaseValue.CALENDAR_STARTING_SIZE;
            case 'HOME_CALENDAR_STARTING_TYPE': return DashboardDatabaseValue.CALENDAR_STARTING_TYPE;
            case 'HOME_CALENDAR_ENABLE_LIDARR': return DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR;
            case 'HOME_CALENDAR_ENABLE_RADARR': return DashboardDatabaseValue.CALENDAR_ENABLE_RADARR;
            case 'HOME_CALENDAR_ENABLE_SONARR': return DashboardDatabaseValue.CALENDAR_ENABLE_SONARR;
            case 'HOME_MODULES_BRAND_COLOURS': return DashboardDatabaseValue.MODULES_BRAND_COLOURS;
            case 'HOME_CALENDAR_DAYS_PAST': return DashboardDatabaseValue.CALENDAR_DAYS_PAST;
            case 'HOME_CALENDAR_DAYS_FUTURE': return DashboardDatabaseValue.CALENDAR_DAYS_FUTURE;
            default: return null;
        }
    }
}

enum DashboardDatabaseValue {
    NAVIGATION_INDEX,
    CALENDAR_STARTING_DAY,
    CALENDAR_STARTING_SIZE,
    CALENDAR_STARTING_TYPE,
    CALENDAR_ENABLE_LIDARR,
    CALENDAR_ENABLE_RADARR,
    CALENDAR_ENABLE_SONARR,
    MODULES_BRAND_COLOURS,
    CALENDAR_DAYS_PAST,
    CALENDAR_DAYS_FUTURE,
}

extension DashboardDatabaseValueExtension on DashboardDatabaseValue {
    String get key {
        switch(this) {
            case DashboardDatabaseValue.NAVIGATION_INDEX: return 'HOME_NAVIGATION_INDEX';
            case DashboardDatabaseValue.CALENDAR_STARTING_DAY: return 'HOME_CALENDAR_STARTING_DAY';
            case DashboardDatabaseValue.CALENDAR_STARTING_SIZE: return 'HOME_CALENDAR_STARTING_SIZE';
            case DashboardDatabaseValue.CALENDAR_STARTING_TYPE: return 'HOME_CALENDAR_STARTING_TYPE';
            case DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR: return 'HOME_CALENDAR_ENABLE_LIDARR';
            case DashboardDatabaseValue.CALENDAR_ENABLE_RADARR: return 'HOME_CALENDAR_ENABLE_RADARR';
            case DashboardDatabaseValue.CALENDAR_ENABLE_SONARR: return 'HOME_CALENDAR_ENABLE_SONARR';
            case DashboardDatabaseValue.MODULES_BRAND_COLOURS: return 'HOME_MODULES_BRAND_COLOURS';
            case DashboardDatabaseValue.CALENDAR_DAYS_PAST: return 'HOME_CALENDAR_DAYS_PAST';
            case DashboardDatabaseValue.CALENDAR_DAYS_FUTURE: return 'HOME_CALENDAR_DAYS_FUTURE';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final box = Database.lunaSeaBox;
        switch(this) {
            case DashboardDatabaseValue.NAVIGATION_INDEX: return box.get(key, defaultValue: 0);
            case DashboardDatabaseValue.CALENDAR_STARTING_DAY: return box.get(key, defaultValue: CalendarStartingDay.MONDAY);
            case DashboardDatabaseValue.CALENDAR_STARTING_SIZE: return box.get(key, defaultValue: CalendarStartingSize.ONE_WEEK);
            case DashboardDatabaseValue.CALENDAR_STARTING_TYPE: return box.get(key, defaultValue: CalendarStartingType.CALENDAR);
            case DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR: return box.get(key, defaultValue: true);
            case DashboardDatabaseValue.CALENDAR_ENABLE_RADARR: return box.get(key, defaultValue: true);
            case DashboardDatabaseValue.CALENDAR_ENABLE_SONARR: return box.get(key, defaultValue: true);
            case DashboardDatabaseValue.MODULES_BRAND_COLOURS: return box.get(key, defaultValue: false);
            case DashboardDatabaseValue.CALENDAR_DAYS_PAST: return box.get(key, defaultValue: 14);
            case DashboardDatabaseValue.CALENDAR_DAYS_FUTURE: return box.get(key, defaultValue: 14);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case DashboardDatabaseValue.NAVIGATION_INDEX: if(value.runtimeType == int) box.put(key, value); return;
            case DashboardDatabaseValue.CALENDAR_STARTING_DAY: if(value.runtimeType == CalendarStartingDay) box.put(key, value); return;
            case DashboardDatabaseValue.CALENDAR_STARTING_SIZE: if(value.runtimeType == CalendarStartingSize) box.put(key, value); return;
            case DashboardDatabaseValue.CALENDAR_STARTING_TYPE: if(value.runtimeType == CalendarStartingType) box.put(key, value); return;
            case DashboardDatabaseValue.CALENDAR_ENABLE_LIDARR: if(value.runtimeType == bool) box.put(key, value); return;
            case DashboardDatabaseValue.CALENDAR_ENABLE_RADARR: if(value.runtimeType == bool) box.put(key, value); return;
            case DashboardDatabaseValue.CALENDAR_ENABLE_SONARR: if(value.runtimeType == bool) box.put(key, value); return;
            case DashboardDatabaseValue.MODULES_BRAND_COLOURS: if(value.runtimeType == bool) box.put(key, value); return;
            case DashboardDatabaseValue.CALENDAR_DAYS_PAST: if(value.runtimeType == int) box.put(key, value); return;
            case DashboardDatabaseValue.CALENDAR_DAYS_FUTURE: if(value.runtimeType == int) box.put(key, value); return;
        }
        LunaLogger().warning('DashboardDatabaseValueExtension', 'put', 'Attempted to enter data for invalid DashboardDatabaseValue: ${this?.toString() ?? 'null'}');
    }

    ValueListenableBuilder listen({ @required Widget Function(BuildContext, dynamic, Widget) builder }) =>  ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [key]),
        builder: builder,
    );
}
