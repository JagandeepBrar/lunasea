// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'root_folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrRootFolder _$RadarrRootFolderFromJson(Map<String, dynamic> json) {
  return RadarrRootFolder(
    path: json['path'] as String?,
    accessible: json['accessible'] as bool?,
    freeSpace: json['freeSpace'] as int?,
    unmappedFolders: (json['unmappedFolders'] as List<dynamic>?)
        ?.map((e) => RadarrUnmappedFolder.fromJson(e as Map<String, dynamic>))
        .toList(),
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$RadarrRootFolderToJson(RadarrRootFolder instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('path', instance.path);
  writeNotNull('accessible', instance.accessible);
  writeNotNull('freeSpace', instance.freeSpace);
  writeNotNull('unmappedFolders',
      instance.unmappedFolders?.map((e) => e.toJson()).toList());
  writeNotNull('id', instance.id);
  return val;
}
