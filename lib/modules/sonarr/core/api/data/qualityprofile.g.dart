// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qualityprofile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SonarrQualityProfileAdapter extends TypeAdapter<SonarrQualityProfile> {
  @override
  final typeId = 2;

  @override
  SonarrQualityProfile read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SonarrQualityProfile(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SonarrQualityProfile obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }
}
