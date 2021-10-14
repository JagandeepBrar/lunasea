// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliMediaInfo _$TautulliMediaInfoFromJson(Map<String, dynamic> json) {
  return TautulliMediaInfo(
    id: TautulliUtilities.ensureIntegerFromJson(json['id']),
    container: TautulliUtilities.ensureStringFromJson(json['container']),
    bitrate: TautulliUtilities.ensureIntegerFromJson(json['bitrate']),
    height: TautulliUtilities.ensureIntegerFromJson(json['height']),
    width: TautulliUtilities.ensureIntegerFromJson(json['width']),
    aspectRatio: TautulliUtilities.ensureDoubleFromJson(json['aspect_ratio']),
    videoCodec: TautulliUtilities.ensureStringFromJson(json['video_codec']),
    videoResolution:
        TautulliUtilities.ensureStringFromJson(json['video_resolution']),
    videoFullResolution:
        TautulliUtilities.ensureStringFromJson(json['video_full_resolution']),
    videoFramerate:
        TautulliUtilities.ensureStringFromJson(json['video_framerate']),
    videoProfile: TautulliUtilities.ensureStringFromJson(json['video_profile']),
    audioCodec: TautulliUtilities.ensureStringFromJson(json['audio_codec']),
    audioChannels:
        TautulliUtilities.ensureIntegerFromJson(json['audio_channels']),
    audioChannelLayout:
        TautulliUtilities.ensureStringFromJson(json['audio_channel_layout']),
    audioProfile: TautulliUtilities.ensureStringFromJson(json['audio_profile']),
    optimizedVersion:
        TautulliUtilities.ensureBooleanFromJson(json['optimized_version']),
    channelCallSign:
        TautulliUtilities.ensureStringFromJson(json['channel_call_sign']),
    channelIdentifier:
        TautulliUtilities.ensureStringFromJson(json['channel_identifier']),
    channelThumb: TautulliUtilities.ensureStringFromJson(json['channel_thumb']),
    parts: TautulliMediaInfo._partsFromJson(json['parts'] as List),
  );
}

Map<String, dynamic> _$TautulliMediaInfoToJson(TautulliMediaInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'container': instance.container,
      'bitrate': instance.bitrate,
      'height': instance.height,
      'width': instance.width,
      'aspect_ratio': instance.aspectRatio,
      'video_codec': instance.videoCodec,
      'video_resolution': instance.videoResolution,
      'video_full_resolution': instance.videoFullResolution,
      'video_framerate': instance.videoFramerate,
      'video_profile': instance.videoProfile,
      'audio_codec': instance.audioCodec,
      'audio_channels': instance.audioChannels,
      'audio_channel_layout': instance.audioChannelLayout,
      'audio_profile': instance.audioProfile,
      'optimized_version': instance.optimizedVersion,
      'channel_call_sign': instance.channelCallSign,
      'channel_identifier': instance.channelIdentifier,
      'channel_thumb': instance.channelThumb,
      'parts': TautulliMediaInfo._partsToJson(instance.parts),
    };
