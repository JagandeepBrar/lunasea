import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

part 'issue.g.dart';

@JsonSerializable()
class OverseerrIssue {
  @JsonKey()
  int id;

  @JsonKey()
  OverseerrIssueType? issueType;

  @JsonKey()
  OverseerrIssueStatus? status;

  @JsonKey()
  int? problemSeason;

  @JsonKey()
  int? problemEpisode;

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

  @JsonKey()
  OverseerrMedia? media;

  @JsonKey()
  OverseerrUser? createdBy;

  @JsonKey()
  OverseerrUser? modifiedBy;

  @JsonKey()
  List<OverseerrIssueComment>? comments;

  OverseerrIssue({
    required this.id,
    this.issueType,
    this.status,
    this.problemSeason,
    this.problemEpisode,
    this.createdAt,
    this.updatedAt,
    this.media,
    this.createdBy,
    this.modifiedBy,
    this.comments,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [OverseerrIssue] object.
  factory OverseerrIssue.fromJson(Map<String, dynamic> json) =>
      _$OverseerrIssueFromJson(json);

  /// Serialize a [OverseerrIssue] object to a JSON map.
  Map<String, dynamic> toJson() => _$OverseerrIssueToJson(this);
}
