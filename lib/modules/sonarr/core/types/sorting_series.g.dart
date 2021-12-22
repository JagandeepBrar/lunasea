// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sorting_series.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SonarrSeriesSortingAdapter extends TypeAdapter<SonarrSeriesSorting> {
  @override
  final int typeId = 16;

  @override
  SonarrSeriesSorting read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SonarrSeriesSorting.ALPHABETICAL;
      case 1:
        return SonarrSeriesSorting.DATE_ADDED;
      case 2:
        return SonarrSeriesSorting.EPISODES;
      case 3:
        return SonarrSeriesSorting.NETWORK;
      case 4:
        return SonarrSeriesSorting.NEXT_AIRING;
      case 8:
        return SonarrSeriesSorting.PREVIOUS_AIRING;
      case 5:
        return SonarrSeriesSorting.QUALITY;
      case 6:
        return SonarrSeriesSorting.SIZE;
      case 7:
        return SonarrSeriesSorting.TYPE;
      default:
        return SonarrSeriesSorting.ALPHABETICAL;
    }
  }

  @override
  void write(BinaryWriter writer, SonarrSeriesSorting obj) {
    switch (obj) {
      case SonarrSeriesSorting.ALPHABETICAL:
        writer.writeByte(0);
        break;
      case SonarrSeriesSorting.DATE_ADDED:
        writer.writeByte(1);
        break;
      case SonarrSeriesSorting.EPISODES:
        writer.writeByte(2);
        break;
      case SonarrSeriesSorting.NETWORK:
        writer.writeByte(3);
        break;
      case SonarrSeriesSorting.NEXT_AIRING:
        writer.writeByte(4);
        break;
      case SonarrSeriesSorting.PREVIOUS_AIRING:
        writer.writeByte(8);
        break;
      case SonarrSeriesSorting.QUALITY:
        writer.writeByte(5);
        break;
      case SonarrSeriesSorting.SIZE:
        writer.writeByte(6);
        break;
      case SonarrSeriesSorting.TYPE:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SonarrSeriesSortingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
