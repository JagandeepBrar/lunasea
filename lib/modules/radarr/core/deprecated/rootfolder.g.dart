// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rootfolder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeprecatedRadarrRootFolderAdapter
    extends TypeAdapter<DeprecatedRadarrRootFolder> {
  @override
  final int typeId = 5;

  @override
  DeprecatedRadarrRootFolder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeprecatedRadarrRootFolder(
      id: fields[0] as int?,
      path: fields[1] as String?,
      freeSpace: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, DeprecatedRadarrRootFolder obj) {
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
      other is DeprecatedRadarrRootFolderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
