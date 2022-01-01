// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrFileSystemDirectory _$RadarrFileSystemDirectoryFromJson(
    Map<String, dynamic> json) {
  return RadarrFileSystemDirectory(
    type: RadarrUtilities.fileSystemTypeFromJson(json['type'] as String?),
    name: json['name'] as String?,
    path: json['path'] as String?,
    size: json['size'] as int?,
    lastModified:
        RadarrUtilities.dateTimeFromJson(json['lastModified'] as String?),
  );
}

Map<String, dynamic> _$RadarrFileSystemDirectoryToJson(
    RadarrFileSystemDirectory instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', RadarrUtilities.fileSystemTypeToJson(instance.type));
  writeNotNull('name', instance.name);
  writeNotNull('path', instance.path);
  writeNotNull('size', instance.size);
  writeNotNull(
      'lastModified', RadarrUtilities.dateTimeToJson(instance.lastModified));
  return val;
}
