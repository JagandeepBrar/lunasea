import 'package:lunasea/core/database/database.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_starting_day.g.dart';

@HiveType(typeId: 12, adapterName: 'CalendarStartingDayAdapter')
enum CalendarStartingDay {
    @HiveField(0)
    MONDAY,
    @HiveField(1)
    TUESDAY,
    @HiveField(2)
    WEDNESDAY,
    @HiveField(3)
    THURSDAY,
    @HiveField(4)
    FRIDAY,
    @HiveField(5)
    SATURDAY,
    @HiveField(6)
    SUNDAY,
}

extension CalendarStartingDayExtension on CalendarStartingDay {
    StartingDayOfWeek get data {
        switch(this) {
            case CalendarStartingDay.MONDAY: return StartingDayOfWeek.monday;
            case CalendarStartingDay.TUESDAY: return StartingDayOfWeek.tuesday;
            case CalendarStartingDay.WEDNESDAY: return StartingDayOfWeek.wednesday;
            case CalendarStartingDay.THURSDAY: return StartingDayOfWeek.thursday;
            case CalendarStartingDay.FRIDAY: return StartingDayOfWeek.friday;
            case CalendarStartingDay.SATURDAY: return StartingDayOfWeek.saturday;
            case CalendarStartingDay.SUNDAY: return StartingDayOfWeek.sunday;
            default: return null;
        }
    }

    String get name {
        switch(this) {
            case CalendarStartingDay.MONDAY: return 'Monday';
            case CalendarStartingDay.TUESDAY: return 'Tuesday';
            case CalendarStartingDay.WEDNESDAY: return 'Wednesday';
            case CalendarStartingDay.THURSDAY: return 'Thursday';
            case CalendarStartingDay.FRIDAY: return 'Friday';
            case CalendarStartingDay.SATURDAY: return 'Saturday';
            case CalendarStartingDay.SUNDAY: return 'Sunday';
            default: return null;
        }
    }

    String get key {
        switch(this) {   
            case CalendarStartingDay.MONDAY: return 'mon';
            case CalendarStartingDay.TUESDAY: return 'tue';
            case CalendarStartingDay.WEDNESDAY: return 'wed';
            case CalendarStartingDay.THURSDAY: return 'thu';
            case CalendarStartingDay.FRIDAY: return 'fri';
            case CalendarStartingDay.SATURDAY: return 'sat';
            case CalendarStartingDay.SUNDAY: return 'sun';
            default: return null;
        }
    }

    CalendarStartingDay fromKey(String key) {
        switch(key) {
            case 'mon': return CalendarStartingDay.MONDAY;
            case 'tue': return CalendarStartingDay.TUESDAY;
            case 'wed': return CalendarStartingDay.WEDNESDAY;
            case 'thu': return CalendarStartingDay.THURSDAY;
            case 'fri': return CalendarStartingDay.FRIDAY;
            case 'sat': return CalendarStartingDay.SATURDAY;
            case 'sun': return CalendarStartingDay.SUNDAY;
            default: return null;
        }
    }
}