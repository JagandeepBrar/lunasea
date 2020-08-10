// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_starting_size.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarStartingSizeAdapter extends TypeAdapter<CalendarStartingSize> {
  @override
  final int typeId = 13;

  @override
  CalendarStartingSize read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CalendarStartingSize.ONE_WEEK;
      case 1:
        return CalendarStartingSize.TWO_WEEKS;
      case 2:
        return CalendarStartingSize.ONE_MONTH;
      case 3:
        return CalendarStartingSize.SCHEDULE;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, CalendarStartingSize obj) {
    switch (obj) {
      case CalendarStartingSize.ONE_WEEK:
        writer.writeByte(0);
        break;
      case CalendarStartingSize.TWO_WEEKS:
        writer.writeByte(1);
        break;
      case CalendarStartingSize.ONE_MONTH:
        writer.writeByte(2);
        break;
      case CalendarStartingSize.SCHEDULE:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarStartingSizeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
