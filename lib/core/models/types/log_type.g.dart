// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LunaLogTypeAdapter extends TypeAdapter<LunaLogType> {
  @override
  final int typeId = 24;

  @override
  LunaLogType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LunaLogType.WARNING;
      case 1:
        return LunaLogType.ERROR;
      case 2:
        return LunaLogType.CRITICAL;
      case 3:
        return LunaLogType.DEBUG;
      default:
        return LunaLogType.WARNING;
    }
  }

  @override
  void write(BinaryWriter writer, LunaLogType obj) {
    switch (obj) {
      case LunaLogType.WARNING:
        writer.writeByte(0);
        break;
      case LunaLogType.ERROR:
        writer.writeByte(1);
        break;
      case LunaLogType.CRITICAL:
        writer.writeByte(2);
        break;
      case LunaLogType.DEBUG:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LunaLogTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
