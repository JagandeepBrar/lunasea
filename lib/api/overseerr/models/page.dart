import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'page.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrPageInfo {
  @JsonKey(name: 'pages')
  int? pages;

  @JsonKey(name: 'pageSize')
  int? pageSize;

  @JsonKey(name: 'results')
  int? results;

  @JsonKey(name: 'page')
  int? page;

  OverseerrPageInfo({
    this.pages,
    this.pageSize,
    this.results,
    this.page,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [OverseerrPageInfo] object.
  factory OverseerrPageInfo.fromJson(Map<String, dynamic> json) =>
      _$OverseerrPageInfoFromJson(json);

  /// Serialize a [OverseerrPageInfo] object to a JSON map.
  Map<String, dynamic> toJson() => _$OverseerrPageInfoToJson(this);
}
