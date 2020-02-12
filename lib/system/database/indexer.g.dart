// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indexer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndexerAdapter extends TypeAdapter<Indexer> {
  @override
  final typeId = 1;

  @override
  Indexer read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Indexer()
      ..id = fields[0] as int
      ..name = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, Indexer obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }
}
