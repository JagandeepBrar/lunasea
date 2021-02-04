// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_movies.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RadarrMoviesFilterAdapter extends TypeAdapter<RadarrMoviesFilter> {
  @override
  final int typeId = 19;

  @override
  RadarrMoviesFilter read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RadarrMoviesFilter.ALL;
      case 1:
        return RadarrMoviesFilter.MONITORED;
      case 2:
        return RadarrMoviesFilter.UNMONITORED;
      case 3:
        return RadarrMoviesFilter.MISSING;
      case 4:
        return RadarrMoviesFilter.WANTED;
      case 5:
        return RadarrMoviesFilter.CUTOFF_UNMET;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, RadarrMoviesFilter obj) {
    switch (obj) {
      case RadarrMoviesFilter.ALL:
        writer.writeByte(0);
        break;
      case RadarrMoviesFilter.MONITORED:
        writer.writeByte(1);
        break;
      case RadarrMoviesFilter.UNMONITORED:
        writer.writeByte(2);
        break;
      case RadarrMoviesFilter.MISSING:
        writer.writeByte(3);
        break;
      case RadarrMoviesFilter.WANTED:
        writer.writeByte(4);
        break;
      case RadarrMoviesFilter.CUTOFF_UNMET:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RadarrMoviesFilterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
