// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indexer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndexerHiveObjectAdapter extends TypeAdapter<IndexerHiveObject> {
  @override
  final int typeId = 1;

  @override
  IndexerHiveObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
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

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndexerHiveObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
