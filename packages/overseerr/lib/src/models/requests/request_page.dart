import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import '../page.dart';
import './request.dart';

part 'request_page.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrRequestPage {
  @JsonKey(name: 'pageInfo')
  OverseerrPageInfo? pageInfo;

  @JsonKey(name: 'results')
  List<OverseerrRequest>? results;

  OverseerrRequestPage({
    this.pageInfo,
    this.results,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [OverseerrRequestPage] object.
  factory OverseerrRequestPage.fromJson(Map<String, dynamic> json) =>
      _$OverseerrRequestPageFromJson(json);

  /// Serialize a [OverseerrRequestPage] object to a JSON map.
  Map<String, dynamic> toJson() => _$OverseerrRequestPageToJson(this);
}
