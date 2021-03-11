// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LunaLogHiveObjectAdapter extends TypeAdapter<LunaLogHiveObject> {
  @override
  final int typeId = 23;

  @override
  LunaLogHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LunaLogHiveObject(
      type: fields[1] as LunaLogType,
      message: fields[4] as String,
      className: fields[2] as String,
      methodName: fields[3] as String,
      error: fields[5] as dynamic,
      stackTrace: fields[6] as StackTrace,
    );
  }

  @override
  void write(BinaryWriter writer, LunaLogHiveObject obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.className)
      ..writeByte(3)
      ..write(obj.methodName)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.error)
      ..writeByte(6)
      ..write(obj.stackTrace);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LunaLogHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
