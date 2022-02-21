import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

part 'season.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrMediaSeason {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'seasonNumber')
  int? seasonNumber;

  @JsonKey(name: 'status')
  OverseerrRequestStatus? status;

  @JsonKey(name: 'status4k')
  OverseerrRequestStatus? status4k;

  @JsonKey(
    name: 'createdAt',
    fromJson: LunaParser.dateTimeFromString,
    toJson: LunaParser.dateTimeToISO8601,
  )
  DateTime? createdAt;

  @JsonKey(
    name: 'updatedAt',
    fromJson: LunaParser.dateTimeFromString,
    toJson: LunaParser.dateTimeToISO8601,
  )
  DateTime? updatedAt;

  OverseerrMediaSeason({
    this.id,
    this.seasonNumber,
    this.status,
    this.status4k,
    this.createdAt,
    this.updatedAt,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [OverseerrMediaSeason] object.
  factory OverseerrMediaSeason.fromJson(Map<String, dynamic> json) =>
      _$OverseerrMediaSeasonFromJson(json);

  /// Serialize a [OverseerrMediaSeason] object to a JSON map.
  Map<String, dynamic> toJson() => _$OverseerrMediaSeasonToJson(this);
}
