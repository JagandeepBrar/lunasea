// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_starting_day.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarStartingDayAdapter extends TypeAdapter<CalendarStartingDay> {
  @override
  final typeId = 12;

  @override
  CalendarStartingDay read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CalendarStartingDay.MONDAY;
      case 1:
        return CalendarStartingDay.TUESDAY;
      case 2:
        return CalendarStartingDay.WEDNESDAY;
      case 3:
        return CalendarStartingDay.THURSDAY;
      case 4:
        return CalendarStartingDay.FRIDAY;
      case 5:
        return CalendarStartingDay.SATURDAY;
      case 6:
        return CalendarStartingDay.SUNDAY;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, CalendarStartingDay obj) {
    switch (obj) {
      case CalendarStartingDay.MONDAY:
        writer.writeByte(0);
        break;
      case CalendarStartingDay.TUESDAY:
        writer.writeByte(1);
        break;
      case CalendarStartingDay.WEDNESDAY:
        writer.writeByte(2);
        break;
      case CalendarStartingDay.THURSDAY:
        writer.writeByte(3);
        break;
      case CalendarStartingDay.FRIDAY:
        writer.writeByte(4);
        break;
      case CalendarStartingDay.SATURDAY:
        writer.writeByte(5);
        break;
      case CalendarStartingDay.SUNDAY:
        writer.writeByte(6);
        break;
    }
  }
}
