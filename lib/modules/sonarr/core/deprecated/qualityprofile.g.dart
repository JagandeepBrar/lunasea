// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qualityprofile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeprecatedSonarrQualityProfileAdapter
    extends TypeAdapter<DeprecatedSonarrQualityProfile> {
  @override
  final int typeId = 2;

  @override
  DeprecatedSonarrQualityProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeprecatedSonarrQualityProfile(
      id: fields[0] as int?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DeprecatedSonarrQualityProfile obj) {
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
      other is DeprecatedSonarrQualityProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
