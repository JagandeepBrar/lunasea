import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'media_info.g.dart';

/// Model to store the library content's media information.
@JsonSerializable(explicitToJson: true)
class TautulliMediaInfo {
  /// The file ID.
  @JsonKey(name: 'id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? id;

  /// The media container type of the content.
  @JsonKey(name: 'container', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? container;

  /// Bitrate of the content.
  @JsonKey(name: 'bitrate', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? bitrate;

  /// Height in pixels.
  @JsonKey(name: 'height', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? height;

  /// Width in pixels.
  @JsonKey(name: 'width', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? width;

  /// Aspect ratio of the content.
  @JsonKey(
      name: 'aspect_ratio', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? aspectRatio;

  /// Codec of the video stream.
  @JsonKey(
      name: 'video_codec', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoCodec;

  /// Resolution of the video stream.
  @JsonKey(
      name: 'video_resolution',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoResolution;

  /// Full resoltuion of the video stream.
  @JsonKey(
      name: 'video_full_resolution',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoFullResolution;

  /// Framerate of the video stream.
  @JsonKey(
      name: 'video_framerate', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoFramerate;

  /// Profile of the video stream.
  @JsonKey(
      name: 'video_profile', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoProfile;

  /// Codec of the audio stream.
  @JsonKey(
      name: 'audio_codec', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioCodec;

  /// Number of channels in the audio stream.
  @JsonKey(
      name: 'audio_channels', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? audioChannels;

  /// The layout of the channels in the audio stream.
  @JsonKey(
      name: 'audio_channel_layout',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioChannelLayout;

  /// Profile of the audio stream.
  @JsonKey(
      name: 'audio_profile', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioProfile;

  /// Is this session using an optimized version?
  @JsonKey(
      name: 'optimized_version',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? optimizedVersion;

  /// The channel's callsign for live content.
  @JsonKey(
      name: 'channel_call_sign',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? channelCallSign;

  /// The channel's identifier for live content.
  @JsonKey(
      name: 'channel_identifier',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? channelIdentifier;

  /// The channel's thumbnail for live content.
  @JsonKey(
      name: 'channel_thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? channelThumb;

  /// List of [TautulliMediaInfoParts] objects, each containing information on individual parts (files) of the content.
  @JsonKey(name: 'parts', toJson: _partsToJson, fromJson: _partsFromJson)
  final List<TautulliMediaInfoParts>? parts;

  TautulliMediaInfo({
    this.id,
    this.container,
    this.bitrate,
    this.height,
    this.width,
    this.aspectRatio,
    this.videoCodec,
    this.videoResolution,
    this.videoFullResolution,
    this.videoFramerate,
    this.videoProfile,
    this.audioCodec,
    this.audioChannels,
    this.audioChannelLayout,
    this.audioProfile,
    this.optimizedVersion,
    this.channelCallSign,
    this.channelIdentifier,
    this.channelThumb,
    this.parts,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliMediaInfo] object.
  factory TautulliMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$TautulliMediaInfoFromJson(json);

  /// Serialize a [TautulliMediaInfo] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliMediaInfoToJson(this);

  static List<TautulliMediaInfoParts> _partsFromJson(
          List<dynamic> mediaInfoParts) =>
      mediaInfoParts
          .map((parts) =>
              TautulliMediaInfoParts.fromJson((parts as Map<String, dynamic>)))
          .toList();
  static List<Map<String, dynamic>>? _partsToJson(
          List<TautulliMediaInfoParts>? mediaInfoParts) =>
      mediaInfoParts?.map((parts) => parts.toJson()).toList();
}
