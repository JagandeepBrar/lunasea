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
