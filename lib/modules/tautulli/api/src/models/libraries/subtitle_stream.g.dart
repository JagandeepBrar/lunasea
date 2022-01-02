// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtitle_stream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliSubtitleStream _$TautulliSubtitleStreamFromJson(
    Map<String, dynamic> json) {
  return TautulliSubtitleStream(
    id: TautulliUtilities.ensureIntegerFromJson(json['id']),
    type: TautulliUtilities.ensureIntegerFromJson(json['type']),
    subtitleCodec:
        TautulliUtilities.ensureStringFromJson(json['subtitle_codec']),
    subtitleContainer:
        TautulliUtilities.ensureStringFromJson(json['subtitle_container']),
    subtitleForced:
        TautulliUtilities.ensureBooleanFromJson(json['subtitle_forced']),
    subtitleFormat:
        TautulliUtilities.ensureStringFromJson(json['subtitle_format']),
    subtitleLanguage:
        TautulliUtilities.ensureStringFromJson(json['subtitle_language']),
    subtitleLanguageCode:
        TautulliUtilities.ensureStringFromJson(json['subtitle_language_code']),
    subtitleLocation:
        TautulliUtilities.ensureStringFromJson(json['subtitle_location']),
    selected: TautulliUtilities.ensureBooleanFromJson(json['selected']),
  );
}

Map<String, dynamic> _$TautulliSubtitleStreamToJson(
        TautulliSubtitleStream instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'subtitle_codec': instance.subtitleCodec,
      'subtitle_container': instance.subtitleContainer,
      'subtitle_format': instance.subtitleFormat,
      'subtitle_forced': instance.subtitleForced,
      'subtitle_location': instance.subtitleLocation,
      'subtitle_language': instance.subtitleLanguage,
      'subtitle_language_code': instance.subtitleLanguageCode,
      'selected': instance.selected,
    };
