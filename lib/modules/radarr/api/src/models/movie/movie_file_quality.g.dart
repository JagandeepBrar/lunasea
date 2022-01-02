// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_file_quality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrMovieFileQuality _$RadarrMovieFileQualityFromJson(
    Map<String, dynamic> json) {
  return RadarrMovieFileQuality(
    quality: json['quality'] == null
        ? null
        : RadarrQuality.fromJson(json['quality'] as Map<String, dynamic>),
    revision: json['revision'] == null
        ? null
        : RadarrQualityRevision.fromJson(
            json['revision'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RadarrMovieFileQualityToJson(
    RadarrMovieFileQuality instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull('revision', instance.revision?.toJson());
  return val;
}
