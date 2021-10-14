// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_stream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliVideoStream _$TautulliVideoStreamFromJson(Map<String, dynamic> json) {
  return TautulliVideoStream(
    id: TautulliUtilities.ensureIntegerFromJson(json['id']),
    type: TautulliUtilities.ensureIntegerFromJson(json['type']),
    videoCodec: TautulliUtilities.ensureStringFromJson(json['video_codec']),
    videoCodecLevel:
        TautulliUtilities.ensureStringFromJson(json['video_codec_level']),
    videoBitrate:
        TautulliUtilities.ensureIntegerFromJson(json['video_bitrate']),
    videoBitDepth:
        TautulliUtilities.ensureIntegerFromJson(json['video_bit_depth']),
    videoChromaSubsampling: TautulliUtilities.ensureStringFromJson(
        json['video_chroma_subsampling']),
    videoColorPrimaries:
        TautulliUtilities.ensureStringFromJson(json['video_color_primaries']),
    videoColorRange:
        TautulliUtilities.ensureStringFromJson(json['video_color_range']),
    videoColorSpace:
        TautulliUtilities.ensureStringFromJson(json['video_color_space']),
    videoColorTRC:
        TautulliUtilities.ensureStringFromJson(json['video_color_trc']),
    videoFrameRate:
        TautulliUtilities.ensureDoubleFromJson(json['video_frame_rate']),
    videoRefFrames:
        TautulliUtilities.ensureIntegerFromJson(json['video_ref_frames']),
    videoHeight: TautulliUtilities.ensureIntegerFromJson(json['video_height']),
    videoWidth: TautulliUtilities.ensureIntegerFromJson(json['video_width']),
    videoLanguage:
        TautulliUtilities.ensureStringFromJson(json['video_language']),
    videoLanguageCode:
        TautulliUtilities.ensureStringFromJson(json['video_language_code']),
    videoProfile: TautulliUtilities.ensureStringFromJson(json['video_profile']),
    videoScanType:
        TautulliUtilities.ensureStringFromJson(json['video_scan_type']),
    selected: TautulliUtilities.ensureBooleanFromJson(json['selected']),
  );
}

Map<String, dynamic> _$TautulliVideoStreamToJson(
        TautulliVideoStream instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'video_codec': instance.videoCodec,
      'video_codec_level': instance.videoCodecLevel,
      'video_bitrate': instance.videoBitrate,
      'video_bit_depth': instance.videoBitDepth,
      'video_chroma_subsampling': instance.videoChromaSubsampling,
      'video_color_primaries': instance.videoColorPrimaries,
      'video_color_range': instance.videoColorRange,
      'video_color_space': instance.videoColorSpace,
      'video_color_trc': instance.videoColorTRC,
      'video_frame_rate': instance.videoFrameRate,
      'video_ref_frames': instance.videoRefFrames,
      'video_height': instance.videoHeight,
      'video_width': instance.videoWidth,
      'video_language': instance.videoLanguage,
      'video_language_code': instance.videoLanguageCode,
      'video_profile': instance.videoProfile,
      'video_scan_type': instance.videoScanType,
      'selected': instance.selected,
    };
