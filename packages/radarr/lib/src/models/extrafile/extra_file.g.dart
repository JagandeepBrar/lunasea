// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extra_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrExtraFile _$RadarrExtraFileFromJson(Map<String, dynamic> json) {
  return RadarrExtraFile(
    movieId: json['movieId'] as int?,
    movieFileId: json['movieFileId'] as int?,
    relativePath: json['relativePath'] as String?,
    extension: json['extension'] as String?,
    type: json['type'] as String?,
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$RadarrExtraFileToJson(RadarrExtraFile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('movieId', instance.movieId);
  writeNotNull('movieFileId', instance.movieFileId);
  writeNotNull('relativePath', instance.relativePath);
  writeNotNull('extension', instance.extension);
  writeNotNull('type', instance.type);
  writeNotNull('id', instance.id);
  return val;
}
