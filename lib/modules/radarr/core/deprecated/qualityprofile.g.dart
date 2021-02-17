// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qualityprofile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeprecatedRadarrQualityProfileAdapter
    extends TypeAdapter<DeprecatedRadarrQualityProfile> {
  @override
  final int typeId = 6;

  @override
  DeprecatedRadarrQualityProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeprecatedRadarrQualityProfile(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DeprecatedRadarrQualityProfile obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeprecatedRadarrQualityProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
