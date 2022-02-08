import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

part 'media.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrMedia {
  @JsonKey()
  int? id;

  @JsonKey(
    fromJson: OverseerrUtilities.mediaTypeFromJson,
    toJson: OverseerrUtilities.mediaTypeToJson,
  )
  OverseerrMediaType? mediaType;

  @JsonKey()
  int? tmdbId;

  @JsonKey()
  int? tvdbId;

  @JsonKey()
  String? imdbId;

  @JsonKey(
    fromJson: OverseerrUtilities.mediaStatusFromJson,
    toJson: OverseerrUtilities.mediaStatusToJson,
  )
  OverseerrMediaStatus? status;

  @JsonKey(
    fromJson: OverseerrUtilities.mediaStatusFromJson,
    toJson: OverseerrUtilities.mediaStatusToJson,
  )
  OverseerrMediaStatus? status4k;

  @JsonKey(
    fromJson: OverseerrUtilities.dateTimeFromJson,
    toJson: OverseerrUtilities.dateTimeToJson,
  )
  DateTime? createdAt;

  @JsonKey(
    fromJson: OverseerrUtilities.dateTimeFromJson,
    toJson: OverseerrUtilities.dateTimeToJson,
  )
  DateTime? updatedAt;

  @JsonKey(
    fromJson: OverseerrUtilities.dateTimeFromJson,
    toJson: OverseerrUtilities.dateTimeToJson,
  )
  DateTime? lastSeasonChange;

  @JsonKey(
    fromJson: OverseerrUtilities.dateTimeFromJson,
    toJson: OverseerrUtilities.dateTimeToJson,
  )
  DateTime? mediaAddedAt;

  @JsonKey()
  int? serviceId;

  @JsonKey()
  int? serviceId4k;

  @JsonKey()
  int? externalServiceId;

  @JsonKey()
  int? externalServiceId4k;

  @JsonKey()
  String? externalServiceSlug;

  @JsonKey()
  String? externalServiceSlug4k;

  @JsonKey()
  String? ratingKey;

  @JsonKey()
  String? ratingKey4k;

  @JsonKey()
  List<OverseerrSeason>? seasons;

  @JsonKey()
  String? plexUrl;

  @JsonKey()
  String? serviceUrl;

  OverseerrMedia({
    this.id,
    this.mediaType,
    this.tmdbId,
    this.tvdbId,
    this.imdbId,
    this.status,
    this.status4k,
    this.createdAt,
    this.updatedAt,
    this.lastSeasonChange,
    this.mediaAddedAt,
    this.serviceId,
    this.serviceId4k,
    this.externalServiceId,
    this.externalServiceId4k,
    this.externalServiceSlug,
    this.externalServiceSlug4k,
    this.ratingKey,
    this.ratingKey4k,
    this.seasons,
    this.plexUrl,
    this.serviceUrl,
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
