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

  @JsonKey(
    name: 'status',
    fromJson: OverseerrUtilities.requestStatusFromJson,
    toJson: OverseerrUtilities.requestStatusToJson,
  )
  OverseerrRequestStatus? status;

  @JsonKey(
    name: 'status4k',
    fromJson: OverseerrUtilities.requestStatusFromJson,
    toJson: OverseerrUtilities.requestStatusToJson,
  )
  OverseerrRequestStatus? status4k;

  @JsonKey(
    name: 'createdAt',
    fromJson: OverseerrUtilities.dateTimeFromJson,
    toJson: OverseerrUtilities.dateTimeToJson,
  )
  DateTime? createdAt;

  @JsonKey(
    name: 'updatedAt',
    fromJson: OverseerrUtilities.dateTimeFromJson,
    toJson: OverseerrUtilities.dateTimeToJson,
  )
  DateTime? updatedAt;

  @JsonKey(
    name: 'lastSeasonChange',
    fromJson: OverseerrUtilities.dateTimeFromJson,
    toJson: OverseerrUtilities.dateTimeToJson,
  )
  DateTime? lastSeasonChange;

  @JsonKey(
    name: 'mediaAddedAt',
    fromJson: OverseerrUtilities.dateTimeFromJson,
    toJson: OverseerrUtilities.dateTimeToJson,
  )
  DateTime? mediaAddedAt;

  @JsonKey(name: 'serviceId')
  int? serviceId;

  @JsonKey(name: 'serviceId4k')
  int? serviceId4k;

  @JsonKey(name: 'externalServiceId')
  int? externalServiceId;

  @JsonKey(name: 'externalServiceId4k')
  int? externalServiceId4k;

  @JsonKey(name: 'externalServiceSlug')
  String? externalServiceSlug;

  @JsonKey(name: 'externalServiceSlug4k')
  String? externalServiceSlug4k;

  @JsonKey(name: 'ratingKey')
  String? ratingKey;

  @JsonKey(name: 'ratingKey4k')
  String? ratingKey4k;

  @JsonKey(name: 'plexUrl')
  String? plexUrl;

  @JsonKey(name: 'serviceUrl')
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
