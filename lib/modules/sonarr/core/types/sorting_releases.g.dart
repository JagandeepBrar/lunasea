// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sorting_releases.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SonarrReleasesSortingAdapter extends TypeAdapter<SonarrReleasesSorting> {
  @override
  final int typeId = 17;

  @override
  SonarrReleasesSorting read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SonarrReleasesSorting.AGE;
      case 1:
        return SonarrReleasesSorting.ALPHABETICAL;
      case 2:
        return SonarrReleasesSorting.SEEDERS;
      case 3:
        return SonarrReleasesSorting.SIZE;
      case 4:
        return SonarrReleasesSorting.TYPE;
      case 5:
        return SonarrReleasesSorting.WEIGHT;
      default:
        return SonarrReleasesSorting.AGE;
    }
  }

  @override
  void write(BinaryWriter writer, SonarrReleasesSorting obj) {
    switch (obj) {
      case SonarrReleasesSorting.AGE:
        writer.writeByte(0);
        break;
      case SonarrReleasesSorting.ALPHABETICAL:
        writer.writeByte(1);
        break;
      case SonarrReleasesSorting.SEEDERS:
        writer.writeByte(2);
        break;
      case SonarrReleasesSorting.SIZE:
        writer.writeByte(3);
        break;
      case SonarrReleasesSorting.TYPE:
        writer.writeByte(4);
        break;
      case SonarrReleasesSorting.WEIGHT:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SonarrReleasesSortingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
