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
}

extension HomeDatabaseValueExtension on HomeDatabaseValue {
    String get key {
        switch(this) {
            case HomeDatabaseValue.CALENDAR_STARTING_DAY: return 'HOME_CALENDAR_STARTING_DAY';
            case HomeDatabaseValue.CALENDAR_STARTING_SIZE: return 'HOME_CALENDAR_STARTING_SIZE';
        }
        return '';
    }

    dynamic get data {
        final _box = Database.lunaSeaBox;
        switch(this) {
            case HomeDatabaseValue.CALENDAR_STARTING_DAY: return _box.get(this.key, defaultValue: CalendarStartingDay.MONDAY);
            case HomeDatabaseValue.CALENDAR_STARTING_SIZE: return _box.get(this.key, defaultValue: CalendarStartingSize.ONE_WEEK);
            default: return null;
        }
    }
}
