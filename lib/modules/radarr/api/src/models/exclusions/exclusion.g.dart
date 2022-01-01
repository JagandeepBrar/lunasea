// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exclusion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrExclusion _$RadarrExclusionFromJson(Map<String, dynamic> json) {
  return RadarrExclusion(
    tmdbId: json['tmdbId'] as int?,
    movieTitle: json['movieTitle'] as String?,
    movieYear: json['movieYear'] as int?,
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$RadarrExclusionToJson(RadarrExclusion instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('tmdbId', instance.tmdbId);
  writeNotNull('movieTitle', instance.movieTitle);
  writeNotNull('movieYear', instance.movieYear);
  writeNotNull('id', instance.id);
  return val;
}
