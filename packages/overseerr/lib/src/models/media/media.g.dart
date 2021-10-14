// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverseerrMedia _$OverseerrMediaFromJson(Map<String, dynamic> json) {
  return OverseerrMedia(
    id: json['id'] as int?,
    mediaType:
        OverseerrUtilities.mediaTypeFromJson(json['mediaType'] as String?),
    tmdbId: json['tmdbId'] as int?,
    tvdbId: json['tvdbId'] as int?,
    imdbId: json['imdbId'] as String?,
  );
}

Map<String, dynamic> _$OverseerrMediaToJson(OverseerrMedia instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull(
      'mediaType', OverseerrUtilities.mediaTypeToJson(instance.mediaType));
  writeNotNull('tmdbId', instance.tmdbId);
  writeNotNull('tvdbId', instance.tvdbId);
  writeNotNull('imdbId', instance.imdbId);
  return val;
}
