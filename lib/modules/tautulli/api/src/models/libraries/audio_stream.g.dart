// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_stream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliAudioStream _$TautulliAudioStreamFromJson(Map<String, dynamic> json) {
  return TautulliAudioStream(
    id: TautulliUtilities.ensureIntegerFromJson(json['id']),
    type: TautulliUtilities.ensureIntegerFromJson(json['type']),
    audioCodec: TautulliUtilities.ensureStringFromJson(json['audio_codec']),
    audioBitrate:
        TautulliUtilities.ensureIntegerFromJson(json['audio_bitrate']),
    audioBitrateMode:
        TautulliUtilities.ensureStringFromJson(json['audio_bitrate_mode']),
    audioChannelLayout:
        TautulliUtilities.ensureStringFromJson(json['audio_channel_layout']),
    audioChannels:
        TautulliUtilities.ensureIntegerFromJson(json['audio_channels']),
    audioLanguage:
        TautulliUtilities.ensureStringFromJson(json['audio_language']),
    audioLanguageCode:
        TautulliUtilities.ensureStringFromJson(json['audio_language_code']),
    audioSampleRate:
        TautulliUtilities.ensureIntegerFromJson(json['audio_sample_rate']),
    audioProfile: TautulliUtilities.ensureStringFromJson(json['audio_profile']),
    selected: TautulliUtilities.ensureBooleanFromJson(json['selected']),
  );
}

Map<String, dynamic> _$TautulliAudioStreamToJson(
        TautulliAudioStream instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'audio_codec': instance.audioCodec,
      'audio_bitrate': instance.audioBitrate,
      'audio_bitrate_mode': instance.audioBitrateMode,
      'audio_channels': instance.audioChannels,
      'audio_channel_layout': instance.audioChannelLayout,
      'audio_sample_rate': instance.audioSampleRate,
      'audio_language': instance.audioLanguage,
      'audio_language_code': instance.audioLanguageCode,
      'audio_profile': instance.audioProfile,
      'selected': instance.selected,
    };
