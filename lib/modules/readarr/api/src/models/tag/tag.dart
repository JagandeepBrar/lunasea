import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrTag {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'label')
  String? label;

  ReadarrTag({
    this.id,
    this.label,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrTag.fromJson(Map<String, dynamic> json) =>
      _$ReadarrTagFromJson(json);
  Map<String, dynamic> toJson() => _$ReadarrTagToJson(this);
}
