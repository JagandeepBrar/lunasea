// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrMovieCredits _$RadarrMovieCreditsFromJson(Map<String, dynamic> json) {
  return RadarrMovieCredits(
    personName: json['personName'] as String?,
    creditTmdbId: json['creditTmdbId'] as String?,
    personTmdbId: json['personTmdbId'] as int?,
    movieId: json['movieId'] as int?,
    images: (json['images'] as List<dynamic>?)
        ?.map((e) => RadarrImage.fromJson(e as Map<String, dynamic>))
        .toList(),
    character: json['character'] as String?,
    department: json['department'] as String?,
    job: json['job'] as String?,
    order: json['order'] as int?,
    type: RadarrUtilities.creditTypeFromJson(json['type'] as String?),
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$RadarrMovieCreditsToJson(RadarrMovieCredits instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('personName', instance.personName);
  writeNotNull('creditTmdbId', instance.creditTmdbId);
  writeNotNull('personTmdbId', instance.personTmdbId);
  writeNotNull('movieId', instance.movieId);
  writeNotNull('images', instance.images?.map((e) => e.toJson()).toList());
  writeNotNull('character', instance.character);
  writeNotNull('department', instance.department);
  writeNotNull('job', instance.job);
  writeNotNull('order', instance.order);
  writeNotNull('type', RadarrUtilities.creditTypeToJson(instance.type));
  writeNotNull('id', instance.id);
  return val;
}
