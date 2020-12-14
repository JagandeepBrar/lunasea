import 'package:hive/hive.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home/core.dart';

class HomeDatabase extends LunaModuleDatabase {
    void registerAdapters() {
        Hive.registerAdapter(CalendarStartingDayAdapter());
        Hive.registerAdapter(CalendarStartingSizeAdapter());
        Hive.registerAdapter(CalendarStartingTypeAdapter());
    }

    @override
    Map<String, dynamic> export() {
        Map<String, dynamic> data = {};
        //TODO
        return data;
    }

    @override
    void import(Map<String, dynamic> config) {
        // TODO
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
        final _box = Database.lunaSeaBox;
        switch(this) {
            case HomeDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
            case HomeDatabaseValue.CALENDAR_STARTING_DAY: return _box.get(this.key, defaultValue: CalendarStartingDay.MONDAY);
            case HomeDatabaseValue.CALENDAR_STARTING_SIZE: return _box.get(this.key, defaultValue: CalendarStartingSize.ONE_WEEK);
            case HomeDatabaseValue.CALENDAR_STARTING_TYPE: return _box.get(this.key, defaultValue: CalendarStartingType.CALENDAR);
            case HomeDatabaseValue.CALENDAR_ENABLE_LIDARR: return _box.get(this.key, defaultValue: true);
            case HomeDatabaseValue.CALENDAR_ENABLE_RADARR: return _box.get(this.key, defaultValue: true);
            case HomeDatabaseValue.CALENDAR_ENABLE_SONARR: return _box.get(this.key, defaultValue: true);
            case HomeDatabaseValue.MODULES_BRAND_COLOURS: return _box.get(this.key, defaultValue: false);
            case HomeDatabaseValue.CALENDAR_DAYS_PAST: return _box.get(this.key, defaultValue: 14);
            case HomeDatabaseValue.CALENDAR_DAYS_FUTURE: return _box.get(this.key, defaultValue: 14);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
