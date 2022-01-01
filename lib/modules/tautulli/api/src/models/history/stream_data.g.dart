// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliStreamData _$TautulliStreamDataFromJson(Map<String, dynamic> json) {
  return TautulliStreamData(
    bitrate: TautulliUtilities.ensureIntegerFromJson(json['bitrate']),
    videoFullResolution:
        TautulliUtilities.ensureStringFromJson(json['video_full_resolution']),
    optimizedVersion:
        TautulliUtilities.ensureBooleanFromJson(json['optimized_version']),
    optimizedVersionProfile: TautulliUtilities.ensureStringFromJson(
        json['optimized_version_profile']),
    optimizedVersionTitle:
        TautulliUtilities.ensureStringFromJson(json['optimized_version_title']),
    syncedVersion:
        TautulliUtilities.ensureBooleanFromJson(json['synced_version']),
    syncedVersionProfile:
        TautulliUtilities.ensureStringFromJson(json['synced_version_profile']),
    container: TautulliUtilities.ensureStringFromJson(json['container']),
    videoBitrate:
        TautulliUtilities.ensureIntegerFromJson(json['video_bitrate']),
    videoCodec: TautulliUtilities.ensureStringFromJson(json['video_codec']),
    videoHeight: TautulliUtilities.ensureIntegerFromJson(json['video_height']),
    videoWidth: TautulliUtilities.ensureIntegerFromJson(json['video_width']),
    videoFramerate:
        TautulliUtilities.ensureStringFromJson(json['video_framerate']),
    videoDynamicRange:
        TautulliUtilities.ensureStringFromJson(json['video_dynamic_range']),
    aspectRatio: TautulliUtilities.ensureDoubleFromJson(json['aspect_ratio']),
    audioCodec: TautulliUtilities.ensureStringFromJson(json['audio_codec']),
    audioBitrate:
        TautulliUtilities.ensureIntegerFromJson(json['audio_bitrate']),
    audioChannels:
        TautulliUtilities.ensureIntegerFromJson(json['audio_channels']),
    subtitleCodec:
        TautulliUtilities.ensureStringFromJson(json['subtitle_codec']),
    qualityProfile:
        TautulliUtilities.ensureStringFromJson(json['quality_profile']),
    streamBitrate:
        TautulliUtilities.ensureIntegerFromJson(json['stream_bitrate']),
    streamContainer:
        TautulliUtilities.ensureStringFromJson(json['stream_container']),
    streamContainerDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['stream_container_decision'] as String?),
    streamVideoBitrate:
        TautulliUtilities.ensureIntegerFromJson(json['stream_video_bitrate']),
    streamVideoCodec:
        TautulliUtilities.ensureStringFromJson(json['stream_video_codec']),
    streamVideoDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['stream_video_decision'] as String?),
    streamVideoFullResolution: TautulliUtilities.ensureStringFromJson(
        json['stream_video_full_resolution']),
    streamVideoHeight:
        TautulliUtilities.ensureIntegerFromJson(json['stream_video_height']),
    streamVideoWidth:
        TautulliUtilities.ensureIntegerFromJson(json['stream_video_width']),
    streamAudioBitrate:
        TautulliUtilities.ensureIntegerFromJson(json['stream_audio_bitrate']),
    streamAudioChannels:
        TautulliUtilities.ensureIntegerFromJson(json['stream_audio_channels']),
    streamAudioCodec:
        TautulliUtilities.ensureStringFromJson(json['stream_audio_codec']),
    streamAudioDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['stream_audio_decision'] as String?),
    streamVideoDynamicRange: TautulliUtilities.ensureStringFromJson(
        json['stream_video_dynamic_range']),
    streamVideoFramerate:
        TautulliUtilities.ensureStringFromJson(json['stream_video_framerate']),
    subtitles: TautulliUtilities.ensureBooleanFromJson(json['subtitles']),
    streamSubtitleDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['stream_subtitle_decision'] as String?),
    streamSubtitleCodec:
        TautulliUtilities.ensureStringFromJson(json['stream_subtitle_codec']),
    transcodeHardwareDecoding:
        TautulliUtilities.ensureBooleanFromJson(json['transcode_hw_decoding']),
    transcodeHardwareEncoding:
        TautulliUtilities.ensureBooleanFromJson(json['transcode_hw_encoding']),
    videoDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['audio_decision'] as String?),
    audioDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['video_decision'] as String?),
    mediaType:
        TautulliUtilities.mediaTypeFromJson(json['media_type'] as String?),
    title: TautulliUtilities.ensureStringFromJson(json['title']),
    originalTitle:
        TautulliUtilities.ensureStringFromJson(json['original_title']),
    grandparentTitle:
        TautulliUtilities.ensureStringFromJson(json['grandparent_title']),
    currentSession:
        TautulliUtilities.ensureBooleanFromJson(json['current_session']),
    preTautulli: TautulliUtilities.ensureStringFromJson(json['pre_tautulli']),
  );
}

Map<String, dynamic> _$TautulliStreamDataToJson(TautulliStreamData instance) =>
    <String, dynamic>{
      'bitrate': instance.bitrate,
      'video_full_resolution': instance.videoFullResolution,
      'optimized_version': instance.optimizedVersion,
      'optimized_version_title': instance.optimizedVersionTitle,
      'optimized_version_profile': instance.optimizedVersionProfile,
      'synced_version': instance.syncedVersion,
      'synced_version_profile': instance.syncedVersionProfile,
      'container': instance.container,
      'video_codec': instance.videoCodec,
      'video_bitrate': instance.videoBitrate,
      'video_height': instance.videoHeight,
      'video_width': instance.videoWidth,
      'video_framerate': instance.videoFramerate,
      'video_dynamic_range': instance.videoDynamicRange,
      'aspect_ratio': instance.aspectRatio,
      'audio_codec': instance.audioCodec,
      'audio_bitrate': instance.audioBitrate,
      'audio_channels': instance.audioChannels,
      'subtitle_codec': instance.subtitleCodec,
      'stream_bitrate': instance.streamBitrate,
      'stream_video_full_resolution': instance.streamVideoFullResolution,
      'quality_profile': instance.qualityProfile,
      'stream_container_decision': TautulliUtilities.transcodeDecisionToJson(
          instance.streamContainerDecision),
      'stream_container': instance.streamContainer,
      'stream_video_decision': TautulliUtilities.transcodeDecisionToJson(
          instance.streamVideoDecision),
      'stream_video_codec': instance.streamVideoCodec,
      'stream_video_bitrate': instance.streamVideoBitrate,
      'stream_video_height': instance.streamVideoHeight,
      'stream_video_width': instance.streamVideoWidth,
      'stream_video_framerate': instance.streamVideoFramerate,
      'stream_video_dynamic_range': instance.streamVideoDynamicRange,
      'stream_audio_decision': TautulliUtilities.transcodeDecisionToJson(
          instance.streamAudioDecision),
      'stream_audio_codec': instance.streamAudioCodec,
      'stream_audio_bitrate': instance.streamAudioBitrate,
      'stream_audio_channels': instance.streamAudioChannels,
      'subtitles': instance.subtitles,
      'stream_subtitle_decision': TautulliUtilities.transcodeDecisionToJson(
          instance.streamSubtitleDecision),
      'stream_subtitle_codec': instance.streamSubtitleCodec,
      'transcode_hw_decoding': instance.transcodeHardwareDecoding,
      'transcode_hw_encoding': instance.transcodeHardwareEncoding,
      'video_decision':
          TautulliUtilities.transcodeDecisionToJson(instance.audioDecision),
      'audio_decision':
          TautulliUtilities.transcodeDecisionToJson(instance.videoDecision),
      'media_type': TautulliUtilities.mediaTypeToJson(instance.mediaType),
      'title': instance.title,
      'grandparent_title': instance.grandparentTitle,
      'original_title': instance.originalTitle,
      'current_session': instance.currentSession,
      'pre_tautulli': instance.preTautulli,
    };
