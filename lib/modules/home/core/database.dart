import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home/core.dart';

class HomeDatabase extends LunaModuleDatabase {
    @override
    void registerAdapters() {
        Hive.registerAdapter(CalendarStartingDayAdapter());
        Hive.registerAdapter(CalendarStartingSizeAdapter());
        Hive.registerAdapter(CalendarStartingTypeAdapter());
    }

    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        for(HomeDatabaseValue value in HomeDatabaseValue.values) {
            switch(value) {
                // Non-primitive values
                case HomeDatabaseValue.CALENDAR_STARTING_DAY: data[value.key] = (HomeDatabaseValue.CALENDAR_STARTING_DAY.data as CalendarStartingDay).key; break;
                case HomeDatabaseValue.CALENDAR_STARTING_SIZE: data[value.key] = (HomeDatabaseValue.CALENDAR_STARTING_SIZE.data as CalendarStartingSize).key; break;
                case HomeDatabaseValue.CALENDAR_STARTING_TYPE: data[value.key] = (HomeDatabaseValue.CALENDAR_STARTING_TYPE.data as CalendarStartingType).key; break;
                // Primitive values
                case HomeDatabaseValue.NAVIGATION_INDEX:
                case HomeDatabaseValue.CALENDAR_ENABLE_LIDARR:
                case HomeDatabaseValue.CALENDAR_ENABLE_RADARR:
                case HomeDatabaseValue.CALENDAR_ENABLE_SONARR:
                case HomeDatabaseValue.MODULES_BRAND_COLOURS:
                case HomeDatabaseValue.CALENDAR_DAYS_PAST:
                case HomeDatabaseValue.CALENDAR_DAYS_FUTURE: data[value.key] = value.data; break;
            }
        }
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        for(String key in config.keys) {
            HomeDatabaseValue value = valueFromKey(key);
            if(value != null) switch(value) {
                // Non-primitive values
                case HomeDatabaseValue.CALENDAR_STARTING_DAY: value.put(CalendarStartingDay.MONDAY.fromKey(config[key])); break;
                case HomeDatabaseValue.CALENDAR_STARTING_SIZE: value.put(CalendarStartingSize.ONE_WEEK.fromKey(config[key])); break;
                case HomeDatabaseValue.CALENDAR_STARTING_TYPE: value.put(CalendarStartingType.CALENDAR.fromKey(config[key])); break;
                // Primitive values
                case HomeDatabaseValue.NAVIGATION_INDEX:
                case HomeDatabaseValue.CALENDAR_ENABLE_LIDARR:
                case HomeDatabaseValue.CALENDAR_ENABLE_RADARR:
                case HomeDatabaseValue.CALENDAR_ENABLE_SONARR:
                case HomeDatabaseValue.MODULES_BRAND_COLOURS:
                case HomeDatabaseValue.CALENDAR_DAYS_PAST:
                case HomeDatabaseValue.CALENDAR_DAYS_FUTURE: value.put(config[key]); break;
            }
        }
    }

    @override
    HomeDatabaseValue valueFromKey(String key) {
        switch(key) {
            case 'HOME_NAVIGATION_INDEX': return HomeDatabaseValue.NAVIGATION_INDEX;
            case 'HOME_CALENDAR_STARTING_DAY': return HomeDatabaseValue.CALENDAR_STARTING_DAY;
            case 'HOME_CALENDAR_STARTING_SIZE': return HomeDatabaseValue.CALENDAR_STARTING_SIZE;
            case 'HOME_CALENDAR_STARTING_TYPE': return HomeDatabaseValue.CALENDAR_STARTING_TYPE;
            case 'HOME_CALENDAR_ENABLE_LIDARR': return HomeDatabaseValue.CALENDAR_ENABLE_LIDARR;
            case 'HOME_CALENDAR_ENABLE_RADARR': return HomeDatabaseValue.CALENDAR_ENABLE_RADARR;
            case 'HOME_CALENDAR_ENABLE_SONARR': return HomeDatabaseValue.CALENDAR_ENABLE_SONARR;
            case 'HOME_MODULES_BRAND_COLOURS': return HomeDatabaseValue.MODULES_BRAND_COLOURS;
            case 'HOME_CALENDAR_DAYS_PAST': return HomeDatabaseValue.CALENDAR_DAYS_PAST;
            case 'HOME_CALENDAR_DAYS_FUTURE': return HomeDatabaseValue.CALENDAR_DAYS_FUTURE;
            default: return null;
        }
    }
}

enum HomeDatabaseValue {
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

extension HomeDatabaseValueExtension on HomeDatabaseValue {
    String get key {
        switch(this) {
            case HomeDatabaseValue.NAVIGATION_INDEX: return 'HOME_NAVIGATION_INDEX';
            case HomeDatabaseValue.CALENDAR_STARTING_DAY: return 'HOME_CALENDAR_STARTING_DAY';
            case HomeDatabaseValue.CALENDAR_STARTING_SIZE: return 'HOME_CALENDAR_STARTING_SIZE';
            case HomeDatabaseValue.CALENDAR_STARTING_TYPE: return 'HOME_CALENDAR_STARTING_TYPE';
            case HomeDatabaseValue.CALENDAR_ENABLE_LIDARR: return 'HOME_CALENDAR_ENABLE_LIDARR';
            case HomeDatabaseValue.CALENDAR_ENABLE_RADARR: return 'HOME_CALENDAR_ENABLE_RADARR';
            case HomeDatabaseValue.CALENDAR_ENABLE_SONARR: return 'HOME_CALENDAR_ENABLE_SONARR';
            case HomeDatabaseValue.MODULES_BRAND_COLOURS: return 'HOME_MODULES_BRAND_COLOURS';
            case HomeDatabaseValue.CALENDAR_DAYS_PAST: return 'HOME_CALENDAR_DAYS_PAST';
            case HomeDatabaseValue.CALENDAR_DAYS_FUTURE: return 'HOME_CALENDAR_DAYS_FUTURE';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final box = Database.lunaSeaBox;
        switch(this) {
            case HomeDatabaseValue.NAVIGATION_INDEX: return box.get(this.key, defaultValue: 0);
            case HomeDatabaseValue.CALENDAR_STARTING_DAY: return box.get(this.key, defaultValue: CalendarStartingDay.MONDAY);
            case HomeDatabaseValue.CALENDAR_STARTING_SIZE: return box.get(this.key, defaultValue: CalendarStartingSize.ONE_WEEK);
            case HomeDatabaseValue.CALENDAR_STARTING_TYPE: return box.get(this.key, defaultValue: CalendarStartingType.CALENDAR);
            case HomeDatabaseValue.CALENDAR_ENABLE_LIDARR: return box.get(this.key, defaultValue: true);
            case HomeDatabaseValue.CALENDAR_ENABLE_RADARR: return box.get(this.key, defaultValue: true);
            case HomeDatabaseValue.CALENDAR_ENABLE_SONARR: return box.get(this.key, defaultValue: true);
            case HomeDatabaseValue.MODULES_BRAND_COLOURS: return box.get(this.key, defaultValue: false);
            case HomeDatabaseValue.CALENDAR_DAYS_PAST: return box.get(this.key, defaultValue: 14);
            case HomeDatabaseValue.CALENDAR_DAYS_FUTURE: return box.get(this.key, defaultValue: 14);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) {
        final box = Database.lunaSeaBox;
        switch(this) {
            case HomeDatabaseValue.NAVIGATION_INDEX: if(value.runtimeType == int) box.put(this.key, value); return;
            case HomeDatabaseValue.CALENDAR_STARTING_DAY: if(value.runtimeType == CalendarStartingDay) box.put(this.key, value); return;
            case HomeDatabaseValue.CALENDAR_STARTING_SIZE: if(value.runtimeType == CalendarStartingSize) box.put(this.key, value); return;
            case HomeDatabaseValue.CALENDAR_STARTING_TYPE: if(value.runtimeType == CalendarStartingType) box.put(this.key, value); return;
            case HomeDatabaseValue.CALENDAR_ENABLE_LIDARR: if(value.runtimeType == bool) box.put(this.key, value); return;
            case HomeDatabaseValue.CALENDAR_ENABLE_RADARR: if(value.runtimeType == bool) box.put(this.key, value); return;
            case HomeDatabaseValue.CALENDAR_ENABLE_SONARR: if(value.runtimeType == bool) box.put(this.key, value); return;
            case HomeDatabaseValue.MODULES_BRAND_COLOURS: if(value.runtimeType == bool) box.put(this.key, value); return;
            case HomeDatabaseValue.CALENDAR_DAYS_PAST: if(value.runtimeType == int) box.put(this.key, value); return;
            case HomeDatabaseValue.CALENDAR_DAYS_FUTURE: if(value.runtimeType == int) box.put(this.key, value); return;
        }
        LunaLogger().warning('HomeDatabaseValueExtension', 'put', 'Attempted to enter data for invalid HomeDatabaseValue: ${this?.toString() ?? 'null'}');
    }

    ValueListenableBuilder listen({ @required Widget Function(BuildContext, dynamic, Widget) builder }) =>  ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [this.key]),
        builder: builder,
    );
}
