// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disk_space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrDiskSpace _$RadarrDiskSpaceFromJson(Map<String, dynamic> json) {
  return RadarrDiskSpace(
    path: json['path'] as String?,
    label: json['label'] as String?,
    freeSpace: json['freeSpace'] as int?,
    totalSpace: json['totalSpace'] as int?,
  );
}

Map<String, dynamic> _$RadarrDiskSpaceToJson(RadarrDiskSpace instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('path', instance.path);
  writeNotNull('label', instance.label);
  writeNotNull('freeSpace', instance.freeSpace);
  writeNotNull('totalSpace', instance.totalSpace);
  return val;
}
