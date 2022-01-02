// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seriestype.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeprecatedSonarrSeriesTypeAdapter
    extends TypeAdapter<DeprecatedSonarrSeriesType> {
  @override
  final int typeId = 4;

  @override
  DeprecatedSonarrSeriesType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeprecatedSonarrSeriesType(
      type: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DeprecatedSonarrSeriesType obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeprecatedSonarrSeriesTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
