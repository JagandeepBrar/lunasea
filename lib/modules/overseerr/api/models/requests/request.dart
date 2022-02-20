import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

part 'request.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrRequest {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(
    name: 'status',
    fromJson: OverseerrUtilities.requestStatusFromJson,
    toJson: OverseerrUtilities.requestStatusToJson,
  )
  OverseerrRequestStatus? status;

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

  @JsonKey(
    name: 'type',
    fromJson: OverseerrUtilities.mediaTypeFromJson,
    toJson: OverseerrUtilities.mediaTypeToJson,
  )
  OverseerrMediaType? type;

  @JsonKey(name: 'is4k')
  bool? is4k;

  @JsonKey(name: 'serverId')
  int? serverId;

  @JsonKey(name: 'profileId')
  int? profileId;

  @JsonKey(name: 'rootFolder')
  String? rootFolder;

  @JsonKey(name: 'languageProfileId')
  int? languageProfileId;

  @JsonKey(name: 'tags')
  List<int>? tags;

  @JsonKey(name: 'media')
  OverseerrMedia? media;

  @JsonKey(name: 'requestedBy')
  OverseerrUser? requestedBy;

  @JsonKey(name: 'modifiedBy')
  OverseerrUser? modifiedBy;

  @JsonKey(name: 'seasons')
  List<OverseerrSeason>? seasons;

  @JsonKey(name: 'seasonCount')
  int? seasonCount;

  OverseerrRequest({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.is4k,
    this.serverId,
    this.profileId,
    this.rootFolder,
    this.languageProfileId,
    this.tags,
    this.media,
    this.requestedBy,
    this.modifiedBy,
    this.seasons,
    this.seasonCount,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [OverseerrRequest] object.
  factory OverseerrRequest.fromJson(Map<String, dynamic> json) =>
      _$OverseerrRequestFromJson(json);

  /// Serialize a [OverseerrRequest] object to a JSON map.
  Map<String, dynamic> toJson() => _$OverseerrRequestToJson(this);
}
