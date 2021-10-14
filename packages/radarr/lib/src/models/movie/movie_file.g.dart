// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrMovieFile _$RadarrMovieFileFromJson(Map<String, dynamic> json) {
  return RadarrMovieFile(
    movieId: json['movieId'] as int?,
    relativePath: json['relativePath'] as String?,
    path: json['path'] as String?,
    size: json['size'] as int?,
    dateAdded: RadarrUtilities.dateTimeFromJson(json['dateAdded'] as String?),
    quality: json['quality'] == null
        ? null
        : RadarrMovieFileQuality.fromJson(
            json['quality'] as Map<String, dynamic>),
    customFormats: (json['customFormats'] as List<dynamic>?)
        ?.map((e) => RadarrCustomFormat.fromJson(e as Map<String, dynamic>))
        .toList(),
    mediaInfo: json['mediaInfo'] == null
        ? null
        : RadarrMovieFileMediaInfo.fromJson(
            json['mediaInfo'] as Map<String, dynamic>),
    qualityCutoffNotMet: json['qualityCutoffNotMet'] as bool?,
    languages: (json['languages'] as List<dynamic>?)
        ?.map((e) => RadarrLanguage.fromJson(e as Map<String, dynamic>))
        .toList(),
    edition: json['edition'] as String?,
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$RadarrMovieFileToJson(RadarrMovieFile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('movieId', instance.movieId);
  writeNotNull('relativePath', instance.relativePath);
  writeNotNull('path', instance.path);
  writeNotNull('size', instance.size);
  writeNotNull('dateAdded', RadarrUtilities.dateTimeToJson(instance.dateAdded));
  writeNotNull('quality', instance.quality?.toJson());
  writeNotNull(
      'customFormats', instance.customFormats?.map((e) => e.toJson()).toList());
  writeNotNull('mediaInfo', instance.mediaInfo?.toJson());
  writeNotNull('qualityCutoffNotMet', instance.qualityCutoffNotMet);
  writeNotNull(
      'languages', instance.languages?.map((e) => e.toJson()).toList());
  writeNotNull('edition', instance.edition);
  writeNotNull('id', instance.id);
  return val;
}
