// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seriestype.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SonarrSeriesTypeAdapter extends TypeAdapter<SonarrSeriesType> {
  @override
  final typeId = 4;

  @override
  SonarrSeriesType read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SonarrSeriesType(
      type: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SonarrSeriesType obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.type);
  }
}
