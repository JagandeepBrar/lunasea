import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import '../../../types.dart';
import '../../../utilities.dart';

part 'media.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrMedia {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(
    name: 'mediaType',
    fromJson: OverseerrUtilities.mediaTypeFromJson,
    toJson: OverseerrUtilities.mediaTypeToJson,
  )
  OverseerrMediaType? mediaType;

  @JsonKey(name: 'tmdbId')
  int? tmdbId;

  @JsonKey(name: 'tvdbId')
  int? tvdbId;

  @JsonKey(name: 'imdbId')
  String? imdbId;

  OverseerrMedia({
    this.id,
    this.mediaType,
    this.tmdbId,
    this.tvdbId,
    this.imdbId,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [OverseerrMedia] object.
  factory OverseerrMedia.fromJson(Map<String, dynamic> json) =>
      _$OverseerrMediaFromJson(json);

  /// Serialize a [OverseerrMedia] object to a JSON map.
  Map<String, dynamic> toJson() => _$OverseerrMediaToJson(this);
}
