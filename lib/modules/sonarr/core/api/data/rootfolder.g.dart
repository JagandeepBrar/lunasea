// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rootfolder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SonarrRootFolderAdapter extends TypeAdapter<SonarrRootFolder> {
  @override
  final int typeId = 3;

  @override
  SonarrRootFolder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SonarrRootFolder(
      id: fields[0] as int,
      path: fields[1] as String,
      freeSpace: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SonarrRootFolder obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.freeSpace);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SonarrRootFolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
