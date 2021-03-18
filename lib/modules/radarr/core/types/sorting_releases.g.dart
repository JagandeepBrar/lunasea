// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sorting_releases.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RadarrReleasesSortingAdapter extends TypeAdapter<RadarrReleasesSorting> {
  @override
  final int typeId = 21;

  @override
  RadarrReleasesSorting read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RadarrReleasesSorting.AGE;
      case 1:
        return RadarrReleasesSorting.ALPHABETICAL;
      case 2:
        return RadarrReleasesSorting.SEEDERS;
      case 3:
        return RadarrReleasesSorting.SIZE;
      case 4:
        return RadarrReleasesSorting.TYPE;
      case 5:
        return RadarrReleasesSorting.WEIGHT;
      default:
        return RadarrReleasesSorting.AGE;
    }
  }

  @override
  void write(BinaryWriter writer, RadarrReleasesSorting obj) {
    switch (obj) {
      case RadarrReleasesSorting.AGE:
        writer.writeByte(0);
        break;
      case RadarrReleasesSorting.ALPHABETICAL:
        writer.writeByte(1);
        break;
      case RadarrReleasesSorting.SEEDERS:
        writer.writeByte(2);
        break;
      case RadarrReleasesSorting.SIZE:
        writer.writeByte(3);
        break;
      case RadarrReleasesSorting.TYPE:
        writer.writeByte(4);
        break;
      case RadarrReleasesSorting.WEIGHT:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RadarrReleasesSortingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
