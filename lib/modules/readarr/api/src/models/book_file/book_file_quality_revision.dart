import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'book_file_quality_revision.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrBookFileQualityRevision {
  @JsonKey(name: 'version')
  int? version;

  @JsonKey(name: 'real')
  int? real;

  @JsonKey(name: 'isRepack')
  bool? isRepack;

  ReadarrBookFileQualityRevision({
    this.version,
    this.real,
    this.isRepack,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrBookFileQualityRevision.fromJson(Map<String, dynamic> json) =>
      _$ReadarrBookFileQualityRevisionFromJson(json);
  Map<String, dynamic> toJson() => _$ReadarrBookFileQualityRevisionToJson(this);
}
