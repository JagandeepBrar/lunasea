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
      displayName: fields[0] as String?,
      host: fields[1] as String?,
      apiKey: fields[2] as String?,
      headers: (fields[3] as Map?)?.cast<dynamic, dynamic>(),
      icon: fields[4] as LunaIndexerIcon?,
    );
  }

  @override
  void write(BinaryWriter writer, IndexerHiveObject obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.host)
      ..writeByte(2)
      ..write(obj.apiKey)
      ..writeByte(3)
      ..write(obj.headers)
      ..writeByte(4)
      ..write(obj.icon);
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
