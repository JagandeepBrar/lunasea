// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qualityprofile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LidarrQualityProfileAdapter extends TypeAdapter<LidarrQualityProfile> {
  @override
  final int typeId = 9;

  @override
  LidarrQualityProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LidarrQualityProfile(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LidarrQualityProfile obj) {
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
      other is LidarrQualityProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
