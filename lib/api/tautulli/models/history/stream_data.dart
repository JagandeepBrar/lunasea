import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'stream_data.g.dart';

/// Model to store information about an active or previous stream.
@JsonSerializable(explicitToJson: true)
class TautulliStreamData {
  /// Bitrate of the content.
  @JsonKey(name: 'bitrate', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? bitrate;

  /// Full resoltuion of the video stream.
  @JsonKey(
      name: 'video_full_resolution',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoFullResolution;

  /// Is this session an optimized version?
  @JsonKey(
      name: 'optimized_version',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? optimizedVersion;

  /// Optimized version title.
  @JsonKey(
      name: 'optimized_version_title',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? optimizedVersionTitle;

  /// Quality of the optimized version of the content.
  @JsonKey(
      name: 'optimized_version_profile',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? optimizedVersionProfile;

  /// Is the stream a synced version of the content?
  @JsonKey(
      name: 'synced_version', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? syncedVersion;

  /// Quality of the synced version of the content.
  @JsonKey(
      name: 'synced_version_profile',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? syncedVersionProfile;

  /// The media container type of the content.
  @JsonKey(name: 'container', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? container;

  /// Codec of the video stream.
  @JsonKey(
      name: 'video_codec', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoCodec;

  /// Bitrate of the video stream.
  @JsonKey(
      name: 'video_bitrate', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoBitrate;

  /// Height in pixels of the video stream.
  @JsonKey(
      name: 'video_height', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoHeight;

  /// Width in pixels of the video stream.
  @JsonKey(
      name: 'video_width', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoWidth;

  /// Framerate of the video stream.
  @JsonKey(
      name: 'video_framerate', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoFramerate;

  /// Dynamic range of the video stream.
  @JsonKey(
      name: 'video_dynamic_range',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoDynamicRange;

  /// Aspect ratio of the content.
  @JsonKey(
      name: 'aspect_ratio', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? aspectRatio;

  /// Codec of the audio stream.
  @JsonKey(
      name: 'audio_codec', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioCodec;

  /// Bitrate of the audio stream.
  @JsonKey(
      name: 'audio_bitrate', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? audioBitrate;

  /// Number of channels in the audio stream.
  @JsonKey(
      name: 'audio_channels', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? audioChannels;

  /// Codec of the subtitle stream.
  @JsonKey(
      name: 'subtitle_codec', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subtitleCodec;

  /// Bitrate of the final stream.
  @JsonKey(
      name: 'stream_bitrate', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamBitrate;

  /// Full resoltuion of the final video stream.
  @JsonKey(
      name: 'stream_video_full_resolution',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoFullResolution;

  /// Quality profile of the stream.
  @JsonKey(
      name: 'quality_profile', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? qualityProfile;

  /// What decision was made on how to handle the final container of the stream.
  @JsonKey(
      name: 'stream_container_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? streamContainerDecision;

  /// Container used for the final stream.
  @JsonKey(
      name: 'stream_container',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamContainer;

  /// What decision was made on how to handle the final video stream.
  @JsonKey(
      name: 'stream_video_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? streamVideoDecision;

  /// Codec of the final video stream.
  @JsonKey(
      name: 'stream_video_codec',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoCodec;

  /// Bitrate of the final video stream.
  @JsonKey(
      name: 'stream_video_bitrate',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamVideoBitrate;

  /// Height in pixels of the final video stream.
  @JsonKey(
      name: 'stream_video_height',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamVideoHeight;

  /// Width in pixels of the final video stream.
  @JsonKey(
      name: 'stream_video_width',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamVideoWidth;

  /// Framerate of the final video stream.
  @JsonKey(
      name: 'stream_video_framerate',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoFramerate;

  /// Dynamic range of the final video stream.
  @JsonKey(
      name: 'stream_video_dynamic_range',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamVideoDynamicRange;

  /// What decision was made on how to handle the final video stream.
  @JsonKey(
      name: 'stream_audio_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? streamAudioDecision;

  /// Codec of the final audio stream.
  @JsonKey(
      name: 'stream_audio_codec',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamAudioCodec;

  /// Bitrate of the final audio stream.
  @JsonKey(
      name: 'stream_audio_bitrate',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamAudioBitrate;

  /// Number of channels in the final audio stream.
  @JsonKey(
      name: 'stream_audio_channels',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? streamAudioChannels;

  /// Were/are subtitles used in this stream?
  @JsonKey(name: 'subtitles', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? subtitles;

  /// What decision was made on how to handle the final subtitle stream.
  @JsonKey(
      name: 'stream_subtitle_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? streamSubtitleDecision;

  /// Codec of the final subtitle stream.
  @JsonKey(
      name: 'stream_subtitle_codec',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? streamSubtitleCodec;

  /// Is the transcoder using hardware acceleration for decoding?
  @JsonKey(
      name: 'transcode_hw_decoding',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? transcodeHardwareDecoding;

  /// Is the transcoder using hardware acceleration for encoding?
  @JsonKey(
      name: 'transcode_hw_encoding',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? transcodeHardwareEncoding;

  /// What decision was made on how to handle the video stream.
  @JsonKey(
      name: 'video_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? audioDecision;

  /// What decision was made on how to handle the audio stream.
  @JsonKey(
      name: 'audio_decision',
      toJson: TautulliUtilities.transcodeDecisionToJson,
      fromJson: TautulliUtilities.transcodeDecisionFromJson)
  final TautulliTranscodeDecision? videoDecision;

  /// Type of media in this session.
  @JsonKey(
      name: 'media_type',
      toJson: TautulliUtilities.mediaTypeToJson,
      fromJson: TautulliUtilities.mediaTypeFromJson)
  final TautulliMediaType? mediaType;

  /// Title of the content.
  @JsonKey(name: 'title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? title;

  /// Title of the grandparent of the content.
  @JsonKey(
      name: 'grandparent_title',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? grandparentTitle;

  /// The original title of the content.
  @JsonKey(
      name: 'original_title', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? originalTitle;

  /// Is this an active/current session?
  @JsonKey(
      name: 'current_session',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? currentSession;

  /// _Unknown_
  @JsonKey(
      name: 'pre_tautulli', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? preTautulli;

  TautulliStreamData({
    this.bitrate,
    this.videoFullResolution,
    this.optimizedVersion,
    this.optimizedVersionProfile,
    this.optimizedVersionTitle,
    this.syncedVersion,
    this.syncedVersionProfile,
    this.container,
    this.videoBitrate,
    this.videoCodec,
    this.videoHeight,
    this.videoWidth,
    this.videoFramerate,
    this.videoDynamicRange,
    this.aspectRatio,
    this.audioCodec,
    this.audioBitrate,
    this.audioChannels,
    this.subtitleCodec,
    this.qualityProfile,
    this.streamBitrate,
    this.streamContainer,
    this.streamContainerDecision,
    this.streamVideoBitrate,
    this.streamVideoCodec,
    this.streamVideoDecision,
    this.streamVideoFullResolution,
    this.streamVideoHeight,
    this.streamVideoWidth,
    this.streamAudioBitrate,
    this.streamAudioChannels,
    this.streamAudioCodec,
    this.streamAudioDecision,
    this.streamVideoDynamicRange,
    this.streamVideoFramerate,
    this.subtitles,
    this.streamSubtitleDecision,
    this.streamSubtitleCodec,
    this.transcodeHardwareDecoding,
    this.transcodeHardwareEncoding,
    this.videoDecision,
    this.audioDecision,
    this.mediaType,
    this.title,
    this.originalTitle,
    this.grandparentTitle,
    this.currentSession,
    this.preTautulli,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliStreamData] object.
  factory TautulliStreamData.fromJson(Map<String, dynamic> json) =>
      _$TautulliStreamDataFromJson(json);

  /// Serialize a [TautulliStreamData] to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliStreamDataToJson(this);
}
