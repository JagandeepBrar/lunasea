import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'exclusion.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrExclusion {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'foreignId')
  String? foreignId;

  @JsonKey(name: 'authorName')
  String? authorName;

  ReadarrExclusion({
    this.id,
    this.foreignId,
    this.authorName,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrExclusion.fromJson(Map<String, dynamic> json) =>
      _$ReadarrExclusionFromJson(json);
  Map<String, dynamic> toJson() => _$ReadarrExclusionToJson(this);
}
