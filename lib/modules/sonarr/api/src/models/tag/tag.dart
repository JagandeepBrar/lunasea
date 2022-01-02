import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrTag {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'label')
  String? label;

  SonarrTag({
    this.id,
    this.label,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrTag.fromJson(Map<String, dynamic> json) =>
      _$SonarrTagFromJson(json);
  Map<String, dynamic> toJson() => _$SonarrTagToJson(this);
}
