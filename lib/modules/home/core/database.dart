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
    CALENDAR_STARTING_DAY,
    CALENDAR_STARTING_SIZE,
    CALENDAR_ENABLE_LIDARR,
    CALENDAR_ENABLE_RADARR,
    CALENDAR_ENABLE_SONARR,
}

extension HomeDatabaseValueExtension on HomeDatabaseValue {
    String get key {
        switch(this) {
            case HomeDatabaseValue.CALENDAR_STARTING_DAY: return 'HOME_CALENDAR_STARTING_DAY';
            case HomeDatabaseValue.CALENDAR_STARTING_SIZE: return 'HOME_CALENDAR_STARTING_SIZE';
            case HomeDatabaseValue.CALENDAR_ENABLE_LIDARR: return 'HOME_CALENDAR_ENABLE_LIDARR';
            case HomeDatabaseValue.CALENDAR_ENABLE_RADARR: return 'HOME_CALENDAR_ENABLE_RADARR';
            case HomeDatabaseValue.CALENDAR_ENABLE_SONARR: return 'HOME_CALENDAR_ENABLE_SONARR';
            default: return '';
        }
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case HomeDatabaseValue.CALENDAR_STARTING_DAY: return _box.get(this.key, defaultValue: CalendarStartingDay.MONDAY);
            case HomeDatabaseValue.CALENDAR_STARTING_SIZE: return _box.get(this.key, defaultValue: CalendarStartingSize.ONE_WEEK);
            case HomeDatabaseValue.CALENDAR_ENABLE_LIDARR: return _box.get(this.key, defaultValue: true);
            case HomeDatabaseValue.CALENDAR_ENABLE_RADARR: return _box.get(this.key, defaultValue: true);
            case HomeDatabaseValue.CALENDAR_ENABLE_SONARR: return _box.get(this.key, defaultValue: true);
            //default: return null;
        }
    }
}
