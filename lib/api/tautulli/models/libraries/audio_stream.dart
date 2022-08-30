import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'audio_stream.g.dart';

/// Model to store information about the audio stream for some content.
@JsonSerializable(explicitToJson: true)
class TautulliAudioStream {
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

  /// Codec of the audio stream.
  @JsonKey(
      name: 'audio_codec', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioCodec;

  /// Bitrate of the audio stream.
  @JsonKey(
      name: 'audio_bitrate', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? audioBitrate;

  /// Bitrate mode of the audio stream.
  @JsonKey(
      name: 'audio_bitrate_mode',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioBitrateMode;

  /// Number of channels in the audio stream.
  @JsonKey(
      name: 'audio_channels', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? audioChannels;

  /// The layout of the channels in the audio stream.
  @JsonKey(
      name: 'audio_channel_layout',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioChannelLayout;

  /// Sample rate of the audio stream.
  @JsonKey(
      name: 'audio_sample_rate',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? audioSampleRate;

  /// Language of the audio stream.
  @JsonKey(
      name: 'audio_language', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioLanguage;

  /// Language code of the audio stream.
  @JsonKey(
      name: 'audio_language_code',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioLanguageCode;

  /// Profile of the audio stream.
  @JsonKey(
      name: 'audio_profile', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? audioProfile;

  /// _Unknown_
  @JsonKey(name: 'selected', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? selected;

  TautulliAudioStream({
    this.id,
    this.type,
    this.audioCodec,
    this.audioBitrate,
    this.audioBitrateMode,
    this.audioChannelLayout,
    this.audioChannels,
    this.audioLanguage,
    this.audioLanguageCode,
    this.audioSampleRate,
    this.audioProfile,
    this.selected,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliAudioStream] object.
  factory TautulliAudioStream.fromJson(Map<String, dynamic> json) =>
      _$TautulliAudioStreamFromJson(json);

  /// Serialize a [TautulliAudioStream] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliAudioStreamToJson(this);
}
