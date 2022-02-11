import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'book_file_quality_quality.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrBookFileQualityQuality {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'source')
  String? source;

  @JsonKey(name: 'resolution')
  int? resolution;

  ReadarrBookFileQualityQuality({
    this.id,
    this.name,
    this.source,
    this.resolution,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrBookFileQualityQuality.fromJson(Map<String, dynamic> json) =>
      _$ReadarrBookFileQualityQualityFromJson(json);
  Map<String, dynamic> toJson() => _$ReadarrBookFileQualityQualityToJson(this);
}
