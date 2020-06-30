import 'package:hive/hive.dart';
import 'package:lunasea/core/database/database.dart';
import './adapters.dart';

class HomeDatabase {
    HomeDatabase._();

    static void registerAdapters() {
        Hive.registerAdapter(CalendarStartingDayAdapter());
        Hive.registerAdapter(CalendarStartingSizeAdapter());
    }
}

enum HomeDatabaseValue {
    NAVIGATION_INDEX,
    CALENDAR_STARTING_DAY,
    CALENDAR_STARTING_SIZE,
    CALENDAR_ENABLE_LIDARR,
    CALENDAR_ENABLE_RADARR,
    CALENDAR_ENABLE_SONARR,
}

extension HomeDatabaseValueExtension on HomeDatabaseValue {
    String get key {
        switch(this) {
            case HomeDatabaseValue.NAVIGATION_INDEX: return 'HOME_NAVIGATION_INDEX';
            case HomeDatabaseValue.CALENDAR_STARTING_DAY: return 'HOME_CALENDAR_STARTING_DAY';
            case HomeDatabaseValue.CALENDAR_STARTING_SIZE: return 'HOME_CALENDAR_STARTING_SIZE';
            case HomeDatabaseValue.CALENDAR_ENABLE_LIDARR: return 'HOME_CALENDAR_ENABLE_LIDARR';
            case HomeDatabaseValue.CALENDAR_ENABLE_RADARR: return 'HOME_CALENDAR_ENABLE_RADARR';
            case HomeDatabaseValue.CALENDAR_ENABLE_SONARR: return 'HOME_CALENDAR_ENABLE_SONARR';
        }
        throw Exception('key not found'); 
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case HomeDatabaseValue.NAVIGATION_INDEX: return _box.get(this.key, defaultValue: 0);
            case HomeDatabaseValue.CALENDAR_STARTING_DAY: return _box.get(this.key, defaultValue: CalendarStartingDay.MONDAY);
            case HomeDatabaseValue.CALENDAR_STARTING_SIZE: return _box.get(this.key, defaultValue: CalendarStartingSize.ONE_WEEK);
            case HomeDatabaseValue.CALENDAR_ENABLE_LIDARR: return _box.get(this.key, defaultValue: true);
            case HomeDatabaseValue.CALENDAR_ENABLE_RADARR: return _box.get(this.key, defaultValue: true);
            case HomeDatabaseValue.CALENDAR_ENABLE_SONARR: return _box.get(this.key, defaultValue: true);
        }
        throw Exception('data not found'); 
    }

    void put(dynamic value) => Database.lunaSeaBox.put(this.key, value);
}
