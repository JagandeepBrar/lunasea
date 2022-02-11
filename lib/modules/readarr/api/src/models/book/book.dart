import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/readarr.dart';

part 'book.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrBook {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'authorTitle')
  String? authorTitle;

  @JsonKey(name: 'seriesTitle')
  String? seriesTitle;

  @JsonKey(name: 'disambiguation')
  String? disambiguation;

  @JsonKey(name: 'overview')
  String? overview;

  @JsonKey(name: 'authorId')
  int? authorId;

  @JsonKey(name: 'foreignBookId')
  String? foreignBookId;

  @JsonKey(name: 'titleSlug')
  String? titleSlug;

  @JsonKey(name: 'monitored')
  bool? monitored;

  @JsonKey(name: 'anyEditionOk')
  bool? anyEditionOk;

  @JsonKey(name: 'ratings')
  ReadarrAuthorRating? ratings;

  @JsonKey(
    name: 'releaseDate',
    toJson: ReadarrUtilities.dateTimeToJson,
    fromJson: ReadarrUtilities.dateTimeFromJson,
  )
  DateTime? releaseDate;

  @JsonKey(name: 'pageCount')
  int? pageCount;

  @JsonKey(name: 'genres')
  List<String>? genres;

  @JsonKey(name: 'author')
  ReadarrAuthor? series;

  @JsonKey(name: 'images')
  List<ReadarrImage?>? images;

  @JsonKey(name: 'statistics')
  ReadarrAuthorStatistics? statistics;

  @JsonKey(
    name: 'added',
    toJson: ReadarrUtilities.dateTimeToJson,
    fromJson: ReadarrUtilities.dateTimeFromJson,
  )
  DateTime? added;

  @JsonKey(name: 'remoteCover')
  String? remoteCover;

  ReadarrBook(
      {this.title,
      this.authorTitle,
      this.seriesTitle,
      this.disambiguation,
      this.overview,
      this.authorId,
      this.foreignBookId,
      this.titleSlug,
      this.monitored,
      this.anyEditionOk,
      this.ratings,
      this.releaseDate,
      this.pageCount,
      this.genres,
      this.series,
      this.images,
      this.statistics,
      this.added,
      this.remoteCover});

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrBook.fromJson(Map<String, dynamic> json) =>
      _$ReadarrBookFromJson(json);
  Map<String, dynamic> toJson() => _$ReadarrBookToJson(this);
}
