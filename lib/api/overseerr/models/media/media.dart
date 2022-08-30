import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';
import 'package:lunasea/utils/parser.dart';

part 'media.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrMedia {
  @JsonKey()
  int? id;

  @JsonKey()
  OverseerrMediaType? mediaType;

  @JsonKey()
  int? tmdbId;

  @JsonKey()
  int? tvdbId;

  @JsonKey()
  String? imdbId;

  @JsonKey()
  OverseerrMediaStatus? status;

  @JsonKey()
  OverseerrMediaStatus? status4k;

  @JsonKey(
    fromJson: LunaParser.dateTimeFromString,
    toJson: LunaParser.dateTimeToISO8601,
  )
  DateTime? createdAt;

  @JsonKey(
    fromJson: LunaParser.dateTimeFromString,
    toJson: LunaParser.dateTimeToISO8601,
  )
  DateTime? updatedAt;

  @JsonKey(
    fromJson: LunaParser.dateTimeFromString,
    toJson: LunaParser.dateTimeToISO8601,
  )
  DateTime? lastSeasonChange;

  @JsonKey(
    fromJson: LunaParser.dateTimeFromString,
    toJson: LunaParser.dateTimeToISO8601,
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
