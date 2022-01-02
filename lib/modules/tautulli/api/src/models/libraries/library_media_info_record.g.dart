// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_media_info_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliLibraryMediaInfoRecord _$TautulliLibraryMediaInfoRecordFromJson(
    Map<String, dynamic> json) {
  return TautulliLibraryMediaInfoRecord(
    sectionId: TautulliUtilities.ensureIntegerFromJson(json['section_id']),
    sectionType:
        TautulliUtilities.sectionTypeFromJson(json['section_type'] as String?),
    addedAt: TautulliUtilities.millisecondsDateTimeFromJson(json['added_at']),
    mediaType:
        TautulliUtilities.mediaTypeFromJson(json['media_type'] as String?),
    ratingKey: TautulliUtilities.ensureIntegerFromJson(json['rating_key']),
    parentRatingKey:
        TautulliUtilities.ensureIntegerFromJson(json['parent_rating_key']),
    grandparentRatingKey:
        TautulliUtilities.ensureIntegerFromJson(json['grandparent_rating_key']),
    title: TautulliUtilities.ensureStringFromJson(json['title']),
    sortTitle: TautulliUtilities.ensureStringFromJson(json['sort_title']),
    year: TautulliUtilities.ensureIntegerFromJson(json['year']),
    mediaIndex: TautulliUtilities.ensureIntegerFromJson(json['media_index']),
    parentMediaIndex:
        TautulliUtilities.ensureIntegerFromJson(json['parent_media_index']),
    thumb: TautulliUtilities.ensureStringFromJson(json['thumb']),
    container: TautulliUtilities.ensureStringFromJson(json['container']),
    bitrate: TautulliUtilities.ensureIntegerFromJson(json['bitrate']),
    videoCodec: TautulliUtilities.ensureStringFromJson(json['video_codec']),
    videoResolution:
        TautulliUtilities.ensureStringFromJson(json['video_resolution']),
    videoFramerate:
        TautulliUtilities.ensureStringFromJson(json['video_framerate']),
    audioCodec: TautulliUtilities.ensureStringFromJson(json['audio_codec']),
    audioChannels:
        TautulliUtilities.ensureIntegerFromJson(json['audio_channels']),
    fileSize: TautulliUtilities.ensureIntegerFromJson(json['file_size']),
    lastPlayed:
        TautulliUtilities.millisecondsDateTimeFromJson(json['last_played']),
    playCount: TautulliUtilities.ensureIntegerFromJson(json['play_count']),
  );
}

Map<String, dynamic> _$TautulliLibraryMediaInfoRecordToJson(
        TautulliLibraryMediaInfoRecord instance) =>
    <String, dynamic>{
      'section_id': instance.sectionId,
      'section_type': TautulliUtilities.sectionTypeToJson(instance.sectionType),
      'added_at': instance.addedAt?.toIso8601String(),
      'media_type': TautulliUtilities.mediaTypeToJson(instance.mediaType),
      'rating_key': instance.ratingKey,
      'parent_rating_key': instance.parentRatingKey,
      'grandparent_rating_key': instance.grandparentRatingKey,
      'title': instance.title,
      'sort_title': instance.sortTitle,
      'year': instance.year,
      'media_index': instance.mediaIndex,
      'parent_media_index': instance.parentMediaIndex,
      'thumb': instance.thumb,
      'container': instance.container,
      'bitrate': instance.bitrate,
      'video_codec': instance.videoCodec,
      'video_resolution': instance.videoResolution,
      'video_framerate': instance.videoFramerate,
      'audio_codec': instance.audioCodec,
      'audio_channels': instance.audioChannels,
      'file_size': instance.fileSize,
      'last_played': instance.lastPlayed?.toIso8601String(),
      'play_count': instance.playCount,
    };
