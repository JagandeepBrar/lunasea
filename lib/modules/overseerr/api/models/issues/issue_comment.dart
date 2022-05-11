import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';
import 'package:lunasea/utils/parser.dart';

part 'issue_comment.g.dart';

@JsonSerializable()
class OverseerrIssueComment {
  @JsonKey()
  int id;

  @JsonKey()
  String message;

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
  OverseerrUser? user;

  OverseerrIssueComment({
    required this.id,
    required this.message,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [OverseerrIssueComment] object.
  factory OverseerrIssueComment.fromJson(Map<String, dynamic> json) =>
      _$OverseerrIssueCommentFromJson(json);

  /// Serialize a [OverseerrIssueComment] object to a JSON map.
  Map<String, dynamic> toJson() => _$OverseerrIssueCommentToJson(this);
}
