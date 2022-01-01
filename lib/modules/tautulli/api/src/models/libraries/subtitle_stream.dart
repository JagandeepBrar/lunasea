import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'subtitle_stream.g.dart';

/// Model to store information about the subtitle stream for some content.
@JsonSerializable(explicitToJson: true)
class TautulliSubtitleStream {
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

  /// Codec of the subtitle stream.
  @JsonKey(
      name: 'subtitle_codec', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subtitleCodec;

  /// Container of the subtitle stream.
  @JsonKey(
      name: 'subtitle_container',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subtitleContainer;

  /// Format of the subtitle stream.
  @JsonKey(
      name: 'subtitle_format', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subtitleFormat;

  /// Is the subtitle stream forced?
  @JsonKey(
      name: 'subtitle_forced',
      fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? subtitleForced;

  /// Location of the subtitle stream.
  @JsonKey(
      name: 'subtitle_location',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subtitleLocation;

  /// Language of the subtitle stream.
  @JsonKey(
      name: 'subtitle_language',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subtitleLanguage;

  /// Language code of the subtitle stream.
  @JsonKey(
      name: 'subtitle_language_code',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subtitleLanguageCode;

  /// _Unknown_
  @JsonKey(name: 'selected', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? selected;

  TautulliSubtitleStream({
    this.id,
    this.type,
    this.subtitleCodec,
    this.subtitleContainer,
    this.subtitleForced,
    this.subtitleFormat,
    this.subtitleLanguage,
    this.subtitleLanguageCode,
    this.subtitleLocation,
    this.selected,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliSubtitleStream] object.
  factory TautulliSubtitleStream.fromJson(Map<String, dynamic> json) =>
      _$TautulliSubtitleStreamFromJson(json);

  /// Serialize a [TautulliSubtitleStream] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliSubtitleStreamToJson(this);
}
