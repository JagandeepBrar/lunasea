// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_import.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrManualImport _$RadarrManualImportFromJson(Map<String, dynamic> json) {
  return RadarrManualImport(
    path: json['path'] as String?,
    relativePath: json['relativePath'] as String?,
    folderName: json['folderName'] as String?,
    name: json['name'] as String?,
    size: json['size'] as int?,
    movie: json['movie'] == null
        ? null
        : RadarrMovie.fromJson(json['movie'] as Map<String, dynamic>),
    quality: json['quality'] == null
        ? null
        : RadarrMovieFileQuality.fromJson(
            json['quality'] as Map<String, dynamic>),
    languages: (json['languages'] as List<dynamic>?)
        ?.map((e) => RadarrLanguage.fromJson(e as Map<String, dynamic>))
        .toList(),
    qualityWeight: json['qualityWeight'] as int?,
    rejections: (json['rejections'] as List<dynamic>?)
        ?.map((e) =>
            RadarrManualImportRejection.fromJson(e as Map<String, dynamic>))
        .toList(),
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$RadarrManualImportToJson(RadarrManualImport instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('path', instance.path);
  writeNotNull('relativePath', instance.relativePath);
  writeNotNull('folderName', instance.folderName);
  writeNotNull('name', instance.name);
  writeNotNull('size', instance.size);
  writeNotNull('movie', instance.movie?.toJson());
  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull(
      'languages', instance.languages?.map((e) => e.toJson()).toList());
  writeNotNull('qualityWeight', instance.qualityWeight);
  writeNotNull(
      'rejections', instance.rejections?.map((e) => e.toJson()).toList());
  writeNotNull('id', instance.id);
  return val;
}
