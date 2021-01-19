// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sorting_movies.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RadarrMoviesSortingAdapter extends TypeAdapter<RadarrMoviesSorting> {
  @override
  final int typeId = 18;

  @override
  RadarrMoviesSorting read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RadarrMoviesSorting.ALPHABETICAL;
      case 1:
        return RadarrMoviesSorting.DATE_ADDED;
      case 2:
        return RadarrMoviesSorting.QUALITY_PROFILE;
      case 3:
        return RadarrMoviesSorting.RUNTIME;
      case 4:
        return RadarrMoviesSorting.SIZE;
      case 5:
        return RadarrMoviesSorting.STUDIO;
      case 6:
        return RadarrMoviesSorting.YEAR;
      case 7:
        return RadarrMoviesSorting.MIN_AVAILABILITY;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, RadarrMoviesSorting obj) {
    switch (obj) {
      case RadarrMoviesSorting.ALPHABETICAL:
        writer.writeByte(0);
        break;
      case RadarrMoviesSorting.DATE_ADDED:
        writer.writeByte(1);
        break;
      case RadarrMoviesSorting.QUALITY_PROFILE:
        writer.writeByte(2);
        break;
      case RadarrMoviesSorting.RUNTIME:
        writer.writeByte(3);
        break;
      case RadarrMoviesSorting.SIZE:
        writer.writeByte(4);
        break;
      case RadarrMoviesSorting.STUDIO:
        writer.writeByte(5);
        break;
      case RadarrMoviesSorting.YEAR:
        writer.writeByte(6);
        break;
      case RadarrMoviesSorting.MIN_AVAILABILITY:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RadarrMoviesSortingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
