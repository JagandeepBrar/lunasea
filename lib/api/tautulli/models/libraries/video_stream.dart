import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'video_stream.g.dart';

/// Model to store information about the video stream for some content.
@JsonSerializable(explicitToJson: true)
class TautulliVideoStream {
  /// The part ID.
  @JsonKey(name: 'id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? id;

  /// The type of content within this stream.
  ///
  /// - 1: Video
  /// - 2: Audio
  /// - 3: Subtitle
  @JsonKey(name: 'type', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? type;

  /// Codec of the video stream.
  @JsonKey(
      name: 'video_codec', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoCodec;

  /// Codec level of the video stream.
  @JsonKey(
      name: 'video_codec_level',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoCodecLevel;

  /// Bitrate of the video stream.
  @JsonKey(
      name: 'video_bitrate', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoBitrate;

  /// Bit depth of the video stream.
  @JsonKey(
      name: 'video_bit_depth',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoBitDepth;

  /// Chroma subsampling of the video stream.
  @JsonKey(
      name: 'video_chroma_subsampling',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoChromaSubsampling;

  /// Color primaries of the video stream.
  @JsonKey(
      name: 'video_color_primaries',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoColorPrimaries;

  /// Color range of the video stream.
  @JsonKey(
      name: 'video_color_range',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoColorRange;

  /// Color space of the video stream.
  @JsonKey(
      name: 'video_color_space',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoColorSpace;

  /// Color TRC of the video stream.
  @JsonKey(
      name: 'video_color_trc', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoColorTRC;

  /// Frame rate of the video stream.
  @JsonKey(
      name: 'video_frame_rate',
      fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? videoFrameRate;

  /// Reference frames in the video stream.
  @JsonKey(
      name: 'video_ref_frames',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoRefFrames;

  /// Height in pixels of the video stream.
  @JsonKey(
      name: 'video_height', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoHeight;

  /// Width in pixels of the video stream.
  @JsonKey(
      name: 'video_width', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? videoWidth;

  /// Language of the video stream.
  @JsonKey(
      name: 'video_language', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoLanguage;

  /// Language code of the video stream.
  @JsonKey(
      name: 'video_language_code',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoLanguageCode;

  /// Profile of the video stream.
  @JsonKey(
      name: 'video_profile', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoProfile;

  /// Scan type of the video stream.
  @JsonKey(
      name: 'video_scan_type', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? videoScanType;

  /// _Unknown_
  @JsonKey(name: 'selected', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? selected;

  TautulliVideoStream({
    this.id,
    this.type,
    this.videoCodec,
    this.videoCodecLevel,
    this.videoBitrate,
    this.videoBitDepth,
    this.videoChromaSubsampling,
    this.videoColorPrimaries,
    this.videoColorRange,
    this.videoColorSpace,
    this.videoColorTRC,
    this.videoFrameRate,
    this.videoRefFrames,
    this.videoHeight,
    this.videoWidth,
    this.videoLanguage,
    this.videoLanguageCode,
    this.videoProfile,
    this.videoScanType,
    this.selected,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliVideoStream] object.
  factory TautulliVideoStream.fromJson(Map<String, dynamic> json) =>
      _$TautulliVideoStreamFromJson(json);

  /// Serialize a [TautulliVideoStream] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliVideoStreamToJson(this);
}
