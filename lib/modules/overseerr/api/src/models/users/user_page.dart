import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import '../page.dart';
import './user.dart';

part 'user_page.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrUserPage {
  @JsonKey(name: 'pageInfo')
  OverseerrPageInfo? pageInfo;

  @JsonKey(name: 'results')
  List<OverseerrUser>? results;

  OverseerrUserPage({
    this.pageInfo,
    this.results,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [OverseerrUserPage] object.
  factory OverseerrUserPage.fromJson(Map<String, dynamic> json) =>
      _$OverseerrUserPageFromJson(json);

  /// Serialize a [OverseerrUserPage] object to a JSON map.
  Map<String, dynamic> toJson() => _$OverseerrUserPageToJson(this);
}
