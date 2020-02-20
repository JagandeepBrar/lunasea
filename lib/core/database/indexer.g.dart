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
    );
  }

  @override
  void write(BinaryWriter writer, IndexerHiveObject obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.displayName);
  }
}
