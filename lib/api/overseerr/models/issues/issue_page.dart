import 'package:lunasea/core.dart';
import 'package:lunasea/api/overseerr/models.dart';

part 'issue_page.g.dart';

@JsonSerializable()
class OverseerrIssuePage {
  @JsonKey()
  OverseerrPageInfo? pageInfo;

  @JsonKey()
  List<OverseerrIssue>? results;

  OverseerrIssuePage({
    this.pageInfo,
    this.results,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [OverseerrIssuePage] object.
  factory OverseerrIssuePage.fromJson(Map<String, dynamic> json) =>
      _$OverseerrIssuePageFromJson(json);

  /// Serialize a [OverseerrIssuePage] object to a JSON map.
  Map<String, dynamic> toJson() => _$OverseerrIssuePageToJson(this);
}
