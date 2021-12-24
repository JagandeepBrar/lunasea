// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_view_option.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LunaListViewOptionAdapter extends TypeAdapter<LunaListViewOption> {
  @override
  final int typeId = 29;

  @override
  LunaListViewOption read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return LunaListViewOption.BLOCK_VIEW;
      case 1:
        return LunaListViewOption.GRID_VIEW;
      default:
        return LunaListViewOption.BLOCK_VIEW;
    }
  }

  @override
  void write(BinaryWriter writer, LunaListViewOption obj) {
    switch (obj) {
      case LunaListViewOption.BLOCK_VIEW:
        writer.writeByte(0);
        break;
      case LunaListViewOption.GRID_VIEW:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LunaListViewOptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
