// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitor_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SonarrMonitorStatusAdapter extends TypeAdapter<SonarrMonitorStatus> {
  @override
  final typeId = 14;

  @override
  SonarrMonitorStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SonarrMonitorStatus.ALL;
      case 1:
        return SonarrMonitorStatus.FUTURE;
      case 2:
        return SonarrMonitorStatus.MISSING;
      case 3:
        return SonarrMonitorStatus.EXISTING;
      case 4:
        return SonarrMonitorStatus.FIRST_SEASON;
      case 5:
        return SonarrMonitorStatus.LAST_SEASON;
      case 6:
        return SonarrMonitorStatus.NONE;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, SonarrMonitorStatus obj) {
    switch (obj) {
      case SonarrMonitorStatus.ALL:
        writer.writeByte(0);
        break;
      case SonarrMonitorStatus.FUTURE:
        writer.writeByte(1);
        break;
      case SonarrMonitorStatus.MISSING:
        writer.writeByte(2);
        break;
      case SonarrMonitorStatus.EXISTING:
        writer.writeByte(3);
        break;
      case SonarrMonitorStatus.FIRST_SEASON:
        writer.writeByte(4);
        break;
      case SonarrMonitorStatus.LAST_SEASON:
        writer.writeByte(5);
        break;
      case SonarrMonitorStatus.NONE:
        writer.writeByte(6);
        break;
    }
  }
}
