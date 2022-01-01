// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_import_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrManualImportFile _$RadarrManualImportFileFromJson(
    Map<String, dynamic> json) {
  return RadarrManualImportFile(
    path: json['path'] as String?,
    movieId: json['movieId'] as int?,
    quality: json['quality'] == null
        ? null
        : RadarrMovieFileQuality.fromJson(
            json['quality'] as Map<String, dynamic>),
    languages: (json['languages'] as List<dynamic>?)
        ?.map((e) => RadarrLanguage.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$RadarrManualImportFileToJson(
    RadarrManualImportFile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('path', instance.path);
  writeNotNull('movieId', instance.movieId);
  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull(
      'languages', instance.languages?.map((e) => e.toJson()).toList());
  return val;
}
