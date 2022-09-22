import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'version.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class NZBGetVersion {
  @JsonKey(name: 'result')
  String version;

  NZBGetVersion({
    required this.version,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory NZBGetVersion.fromJson(Map<String, dynamic> json) {
    return _$NZBGetVersionFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NZBGetVersionToJson(this);
  }
}
