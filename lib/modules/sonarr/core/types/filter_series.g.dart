// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_series.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SonarrSeriesFilterAdapter extends TypeAdapter<SonarrSeriesFilter> {
  @override
  final int typeId = 27;

  @override
  SonarrSeriesFilter read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SonarrSeriesFilter.ALL;
      case 1:
        return SonarrSeriesFilter.MONITORED;
      case 2:
        return SonarrSeriesFilter.UNMONITORED;
      case 3:
        return SonarrSeriesFilter.CONTINUING;
      case 4:
        return SonarrSeriesFilter.ENDED;
      case 5:
        return SonarrSeriesFilter.MISSING;
      default:
        return SonarrSeriesFilter.ALL;
    }
  }

  @override
  void write(BinaryWriter writer, SonarrSeriesFilter obj) {
    switch (obj) {
      case SonarrSeriesFilter.ALL:
        writer.writeByte(0);
        break;
      case SonarrSeriesFilter.MONITORED:
        writer.writeByte(1);
        break;
      case SonarrSeriesFilter.UNMONITORED:
        writer.writeByte(2);
        break;
      case SonarrSeriesFilter.CONTINUING:
        writer.writeByte(3);
        break;
      case SonarrSeriesFilter.ENDED:
        writer.writeByte(4);
        break;
      case SonarrSeriesFilter.MISSING:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SonarrSeriesFilterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
