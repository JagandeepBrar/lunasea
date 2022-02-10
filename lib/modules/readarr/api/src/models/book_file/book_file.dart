import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/readarr.dart';

part 'book_file.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrBookFile {
  @JsonKey(name: 'authorId')
  int? authorId;

  @JsonKey(name: 'bookId')
  int? bookId;

  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'size')
  int? size;

  @JsonKey(
    name: 'dateAdded',
    fromJson: ReadarrUtilities.dateTimeFromJson,
    toJson: ReadarrUtilities.dateTimeToJson,
  )
  DateTime? dateAdded;

  @JsonKey(name: 'quality')
  ReadarrBookFileQuality? quality;

  @JsonKey(name: 'qualityWeight')
  int? qualityWeight;

  @JsonKey(name: 'qualityCutoffNotMet')
  bool? qualityCutoffNotMet;

  @JsonKey(name: 'id')
  int? id;

  ReadarrBookFile({
    this.authorId,
    this.bookId,
    this.path,
    this.size,
    this.dateAdded,
    this.quality,
    this.qualityWeight,
    this.qualityCutoffNotMet,
    this.id,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrBookFile.fromJson(Map<String, dynamic> json) =>
      _$ReadarrBookFileFromJson(json);

  Map<String, dynamic> toJson() => _$ReadarrBookFileToJson(this);
}
