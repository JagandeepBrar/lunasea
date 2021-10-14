// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unmapped_folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrUnmappedFolder _$RadarrUnmappedFolderFromJson(Map<String, dynamic> json) {
  return RadarrUnmappedFolder(
    name: json['name'] as String?,
    path: json['path'] as String?,
  );
}

Map<String, dynamic> _$RadarrUnmappedFolderToJson(
    RadarrUnmappedFolder instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('path', instance.path);
  return val;
}
