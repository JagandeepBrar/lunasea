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
        return LunaLogType.FATAL;
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
      case LunaLogType.FATAL:
        writer.writeByte(2);
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
