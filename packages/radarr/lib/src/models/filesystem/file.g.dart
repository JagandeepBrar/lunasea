// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrFileSystemFile _$RadarrFileSystemFileFromJson(Map<String, dynamic> json) {
  return RadarrFileSystemFile(
    type: RadarrUtilities.fileSystemTypeFromJson(json['type'] as String?),
    name: json['name'] as String?,
    path: json['path'] as String?,
    extension: json['extension'] as String?,
    size: json['size'] as int?,
    lastModified:
        RadarrUtilities.dateTimeFromJson(json['lastModified'] as String?),
  );
}

Map<String, dynamic> _$RadarrFileSystemFileToJson(
    RadarrFileSystemFile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', RadarrUtilities.fileSystemTypeToJson(instance.type));
  writeNotNull('name', instance.name);
  writeNotNull('path', instance.path);
  writeNotNull('extension', instance.extension);
  writeNotNull('size', instance.size);
  writeNotNull(
      'lastModified', RadarrUtilities.dateTimeToJson(instance.lastModified));
  return val;
}
