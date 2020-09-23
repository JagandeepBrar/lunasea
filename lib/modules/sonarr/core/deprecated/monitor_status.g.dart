// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitor_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeprecatedSonarrMonitorStatusAdapter extends TypeAdapter<DeprecatedSonarrMonitorStatus> {
  @override
  final int typeId = 14;

  @override
  DeprecatedSonarrMonitorStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DeprecatedSonarrMonitorStatus.ALL;
      case 1:
        return DeprecatedSonarrMonitorStatus.FUTURE;
      case 2:
        return DeprecatedSonarrMonitorStatus.MISSING;
      case 3:
        return DeprecatedSonarrMonitorStatus.EXISTING;
      case 4:
        return DeprecatedSonarrMonitorStatus.FIRST_SEASON;
      case 5:
        return DeprecatedSonarrMonitorStatus.LAST_SEASON;
      case 6:
        return DeprecatedSonarrMonitorStatus.NONE;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, DeprecatedSonarrMonitorStatus obj) {
    switch (obj) {
      case DeprecatedSonarrMonitorStatus.ALL:
        writer.writeByte(0);
        break;
      case DeprecatedSonarrMonitorStatus.FUTURE:
        writer.writeByte(1);
        break;
      case DeprecatedSonarrMonitorStatus.MISSING:
        writer.writeByte(2);
        break;
      case DeprecatedSonarrMonitorStatus.EXISTING:
        writer.writeByte(3);
        break;
      case DeprecatedSonarrMonitorStatus.FIRST_SEASON:
        writer.writeByte(4);
        break;
      case DeprecatedSonarrMonitorStatus.LAST_SEASON:
        writer.writeByte(5);
        break;
      case DeprecatedSonarrMonitorStatus.NONE:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeprecatedSonarrMonitorStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
