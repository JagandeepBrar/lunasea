import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import '../../../types.dart';
import '../../../utilities.dart';

part 'season.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrSeason {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'seasonNumber')
  int? seasonNumber;

  @JsonKey(
    name: 'status',
    fromJson: OverseerrUtilities.requestStatusFromJson,
    toJson: OverseerrUtilities.requestStatusToJson,
  )
  OverseerrRequestStatus? status;

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

  OverseerrSeason({
    this.id,
    this.seasonNumber,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [OverseerrSeason] object.
  factory OverseerrSeason.fromJson(Map<String, dynamic> json) =>
      _$OverseerrSeasonFromJson(json);

  /// Serialize a [OverseerrSeason] object to a JSON map.
  Map<String, dynamic> toJson() => _$OverseerrSeasonToJson(this);
}
