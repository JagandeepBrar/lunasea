// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indexer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndexerHiveObjectAdapter extends TypeAdapter<IndexerHiveObject> {
  @override
  final typeId = 1;

  @override
  IndexerHiveObject read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IndexerHiveObject(
      displayName: fields[0] as String,
      host: fields[1] as String,
      key: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, IndexerHiveObject obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.host)
      ..writeByte(2)
      ..write(obj.key);
  }
}
