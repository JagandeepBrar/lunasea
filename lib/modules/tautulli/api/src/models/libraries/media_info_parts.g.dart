// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_info_parts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliMediaInfoParts _$TautulliMediaInfoPartsFromJson(
    Map<String, dynamic> json) {
  return TautulliMediaInfoParts(
    id: TautulliUtilities.ensureIntegerFromJson(json['id']),
    file: TautulliUtilities.ensureStringFromJson(json['file']),
    fileSize: TautulliUtilities.ensureIntegerFromJson(json['file_size']),
    indexes: TautulliUtilities.ensureBooleanFromJson(json['indexes']),
    selected: TautulliUtilities.ensureBooleanFromJson(json['selected']),
    videoStreams: TautulliMediaInfoParts._videoStreamToObjectArray(
        json['video_streams'] as List),
    audioStreams: TautulliMediaInfoParts._audioStreamToObjectArray(
        json['audio_streams'] as List),
    subtitleStreams: TautulliMediaInfoParts._subtitleStreamToObjectArray(
        json['subtitle_streams'] as List),
  );
}

Map<String, dynamic> _$TautulliMediaInfoPartsToJson(
        TautulliMediaInfoParts instance) =>
    <String, dynamic>{
      'id': instance.id,
      'file': instance.file,
      'file_size': instance.fileSize,
      'indexes': instance.indexes,
      'selected': instance.selected,
      'video_streams':
          TautulliMediaInfoParts._videoStreamToMap(instance.videoStreams),
      'audio_streams':
          TautulliMediaInfoParts._audioStreamToMap(instance.audioStreams),
      'subtitle_streams':
          TautulliMediaInfoParts._subtitleStreamToMap(instance.subtitleStreams),
    };
