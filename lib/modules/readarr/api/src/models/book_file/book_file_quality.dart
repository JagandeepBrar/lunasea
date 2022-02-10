import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/readarr.dart';

part 'book_file_quality.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrBookFileQuality {
  @JsonKey(name: 'quality')
  ReadarrBookFileQualityQuality? quality;

  @JsonKey(name: 'revision')
  ReadarrBookFileQualityRevision? revision;

  ReadarrBookFileQuality({
    this.quality,
    this.revision,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrBookFileQuality.fromJson(Map<String, dynamic> json) =>
      _$ReadarrBookFileQualityFromJson(json);
  Map<String, dynamic> toJson() => _$ReadarrBookFileQualityToJson(this);
}
