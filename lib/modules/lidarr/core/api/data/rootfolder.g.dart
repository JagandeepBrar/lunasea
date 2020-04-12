// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rootfolder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LidarrRootFolderAdapter extends TypeAdapter<LidarrRootFolder> {
  @override
  final typeId = 8;

  @override
  LidarrRootFolder read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LidarrRootFolder(
      id: fields[0] as int,
      path: fields[1] as String,
      freeSpace: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LidarrRootFolder obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.freeSpace);
  }
}
