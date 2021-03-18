// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indexer_icon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LunaIndexerIconAdapter extends TypeAdapter<LunaIndexerIcon> {
  @override
  final int typeId = 22;

  @override
  LunaIndexerIcon read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LunaIndexerIcon.GENERIC;
      case 1:
        return LunaIndexerIcon.DOGNZB;
      case 2:
        return LunaIndexerIcon.DRUNKENSLUG;
      case 3:
        return LunaIndexerIcon.NZBFINDER;
      case 4:
        return LunaIndexerIcon.NZBGEEK;
      case 5:
        return LunaIndexerIcon.NZBHYDRA;
      case 6:
        return LunaIndexerIcon.NZBSU;
      default:
        return LunaIndexerIcon.GENERIC;
    }
  }

  @override
  void write(BinaryWriter writer, LunaIndexerIcon obj) {
    switch (obj) {
      case LunaIndexerIcon.GENERIC:
        writer.writeByte(0);
        break;
      case LunaIndexerIcon.DOGNZB:
        writer.writeByte(1);
        break;
      case LunaIndexerIcon.DRUNKENSLUG:
        writer.writeByte(2);
        break;
      case LunaIndexerIcon.NZBFINDER:
        writer.writeByte(3);
        break;
      case LunaIndexerIcon.NZBGEEK:
        writer.writeByte(4);
        break;
      case LunaIndexerIcon.NZBHYDRA:
        writer.writeByte(5);
        break;
      case LunaIndexerIcon.NZBSU:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LunaIndexerIconAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
