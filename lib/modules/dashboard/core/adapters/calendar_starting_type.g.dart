// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_starting_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarStartingTypeAdapter extends TypeAdapter<CalendarStartingType> {
  @override
  final int typeId = 15;

  @override
  CalendarStartingType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CalendarStartingType.CALENDAR;
      case 1:
        return CalendarStartingType.SCHEDULE;
      default:
        return CalendarStartingType.CALENDAR;
    }
  }

  @override
  void write(BinaryWriter writer, CalendarStartingType obj) {
    switch (obj) {
      case CalendarStartingType.CALENDAR:
        writer.writeByte(0);
        break;
      case CalendarStartingType.SCHEDULE:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarStartingTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
