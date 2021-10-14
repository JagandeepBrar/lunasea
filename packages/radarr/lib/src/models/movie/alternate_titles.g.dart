// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alternate_titles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrMovieAlternateTitles _$RadarrMovieAlternateTitlesFromJson(
    Map<String, dynamic> json) {
  return RadarrMovieAlternateTitles(
    sourceType: json['sourceType'] as String?,
    movieId: json['movieId'] as int?,
    title: json['title'] as String?,
    sourceId: json['sourceId'] as int?,
    votes: json['votes'] as int?,
    voteCount: json['voteCount'] as int?,
    language: json['language'] == null
        ? null
        : RadarrLanguage.fromJson(json['language'] as Map<String, dynamic>),
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$RadarrMovieAlternateTitlesToJson(
    RadarrMovieAlternateTitles instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sourceType', instance.sourceType);
  writeNotNull('movieId', instance.movieId);
  writeNotNull('title', instance.title);
  writeNotNull('sourceId', instance.sourceId);
  writeNotNull('votes', instance.votes);
  writeNotNull('voteCount', instance.voteCount);
  writeNotNull('language', instance.language?.toJson());
  writeNotNull('id', instance.id);
  return val;
}
