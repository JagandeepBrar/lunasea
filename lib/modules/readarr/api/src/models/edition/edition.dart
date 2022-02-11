import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/readarr.dart';

part 'edition.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrEdition {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'bookId')
  int? bookId;

  @JsonKey(name: 'foreignEditionId')
  String? foreignEditionId;

  @JsonKey(name: 'titleSlug')
  String? titleSlug;

  @JsonKey(name: 'isbn13')
  String? isbn13;

  @JsonKey(name: 'asin')
  String? asin;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'language')
  String? language;

  @JsonKey(name: 'overview')
  String? overview;

  @JsonKey(name: 'format')
  String? format;

  @JsonKey(name: 'isEbook')
  bool? isEbook;

  @JsonKey(name: 'disambiguation')
  String? disambiguation;

  @JsonKey(name: 'publisher')
  String? publisher;

  @JsonKey(name: 'pageCount')
  int? pageCount;

  @JsonKey(
    name: 'releaseDate',
    toJson: ReadarrUtilities.dateTimeToJson,
    fromJson: ReadarrUtilities.dateTimeFromJson,
  )
  DateTime? releaseDate;

  @JsonKey(name: 'images')
  List<ReadarrImage?>? images;

  @JsonKey(name: 'ratings')
  ReadarrAuthorRating? ratings;

  @JsonKey(name: 'monitored')
  bool? monitored;

  @JsonKey(name: 'manualAdd')
  bool? manualAdd;

  @JsonKey(name: 'remoteCover')
  String? remoteCover;

  ReadarrEdition(
      {this.id,
      this.bookId,
      this.foreignEditionId,
      this.titleSlug,
      this.isbn13,
      this.asin,
      this.title,
      this.language,
      this.overview,
      this.format,
      this.isEbook,
      this.disambiguation,
      this.publisher,
      this.pageCount,
      this.releaseDate,
      this.images,
      this.ratings,
      this.monitored,
      this.manualAdd,
      this.remoteCover});

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrEdition.fromJson(Map<String, dynamic> json) =>
      _$ReadarrEditionFromJson(json);
  Map<String, dynamic> toJson() => _$ReadarrEditionToJson(this);
}
