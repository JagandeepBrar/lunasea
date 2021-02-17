// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_releases.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RadarrReleasesFilterAdapter extends TypeAdapter<RadarrReleasesFilter> {
  @override
  final int typeId = 20;

  @override
  RadarrReleasesFilter read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RadarrReleasesFilter.ALL;
      case 1:
        return RadarrReleasesFilter.APPROVED;
      case 2:
        return RadarrReleasesFilter.REJECTED;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, RadarrReleasesFilter obj) {
    switch (obj) {
      case RadarrReleasesFilter.ALL:
        writer.writeByte(0);
        break;
      case RadarrReleasesFilter.APPROVED:
        writer.writeByte(1);
        break;
      case RadarrReleasesFilter.REJECTED:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RadarrReleasesFilterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
