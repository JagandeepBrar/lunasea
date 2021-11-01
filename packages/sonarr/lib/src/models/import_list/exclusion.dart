import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'exclusion.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrExclusion {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'tvdbId')
  int? tvdbId;

  @JsonKey(name: 'title')
  String? title;

  SonarrExclusion({
    this.id,
    this.tvdbId,
    this.title,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrExclusion.fromJson(Map<String, dynamic> json) =>
      _$SonarrExclusionFromJson(json);
  Map<String, dynamic> toJson() => _$SonarrExclusionToJson(this);
}
