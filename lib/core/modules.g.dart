// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modules.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LunaModuleAdapter extends TypeAdapter<LunaModule> {
  @override
  final int typeId = 25;

  @override
  LunaModule read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LunaModule.DASHBOARD;
      case 11:
        return LunaModule.EXTERNAL_MODULES;
      case 1:
        return LunaModule.LIDARR;
      case 2:
        return LunaModule.NZBGET;
      case 3:
        return LunaModule.OVERSEERR;
      case 4:
        return LunaModule.RADARR;
      case 5:
        return LunaModule.SABNZBD;
      case 6:
        return LunaModule.SEARCH;
      case 7:
        return LunaModule.SETTINGS;
      case 8:
        return LunaModule.SONARR;
      case 9:
        return LunaModule.TAUTULLI;
      case 10:
        return LunaModule.WAKE_ON_LAN;
      default:
        return LunaModule.DASHBOARD;
    }
  }

  @override
  void write(BinaryWriter writer, LunaModule obj) {
    switch (obj) {
      case LunaModule.DASHBOARD:
        writer.writeByte(0);
        break;
      case LunaModule.EXTERNAL_MODULES:
        writer.writeByte(11);
        break;
      case LunaModule.LIDARR:
        writer.writeByte(1);
        break;
      case LunaModule.NZBGET:
        writer.writeByte(2);
        break;
      case LunaModule.OVERSEERR:
        writer.writeByte(3);
        break;
      case LunaModule.RADARR:
        writer.writeByte(4);
        break;
      case LunaModule.SABNZBD:
        writer.writeByte(5);
        break;
      case LunaModule.SEARCH:
        writer.writeByte(6);
        break;
      case LunaModule.SETTINGS:
        writer.writeByte(7);
        break;
      case LunaModule.SONARR:
        writer.writeByte(8);
        break;
      case LunaModule.TAUTULLI:
        writer.writeByte(9);
        break;
      case LunaModule.WAKE_ON_LAN:
        writer.writeByte(10);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LunaModuleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
