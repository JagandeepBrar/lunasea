// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_releases.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SonarrReleasesFilterAdapter extends TypeAdapter<SonarrReleasesFilter> {
  @override
  final int typeId = 28;

  @override
  SonarrReleasesFilter read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SonarrReleasesFilter.ALL;
      case 1:
        return SonarrReleasesFilter.APPROVED;
      case 2:
        return SonarrReleasesFilter.REJECTED;
      default:
        return SonarrReleasesFilter.ALL;
    }
  }

  @override
  void write(BinaryWriter writer, SonarrReleasesFilter obj) {
    switch (obj) {
      case SonarrReleasesFilter.ALL:
        writer.writeByte(0);
        break;
      case SonarrReleasesFilter.APPROVED:
        writer.writeByte(1);
        break;
      case SonarrReleasesFilter.REJECTED:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SonarrReleasesFilterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
