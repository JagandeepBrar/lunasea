// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'external_module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExternalModuleHiveObjectAdapter
    extends TypeAdapter<ExternalModuleHiveObject> {
  @override
  final int typeId = 26;

  @override
  ExternalModuleHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExternalModuleHiveObject(
      displayName: fields[0] as String,
      host: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExternalModuleHiveObject obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.host);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExternalModuleHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
