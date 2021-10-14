import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'status_appdata.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrStatusAppData {
  @JsonKey(name: 'appData')
  bool? appData;

  @JsonKey(name: 'appDataPath')
  String? appDataPath;

  OverseerrStatusAppData({
    this.appData,
    this.appDataPath,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [OverseerrStatusAppData] object.
  factory OverseerrStatusAppData.fromJson(Map<String, dynamic> json) =>
      _$OverseerrStatusAppDataFromJson(json);

  /// Serialize a [OverseerrStatusAppData] object to a JSON map.
  Map<String, dynamic> toJson() => _$OverseerrStatusAppDataToJson(this);
}
