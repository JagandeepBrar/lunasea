import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/readarr.dart';

part 'author.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrAuthor {
  @JsonKey(name: 'authorName')
  String? title;

  @JsonKey(name: 'sortName')
  String? sortTitle;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'ended')
  bool? ended;

  @JsonKey(name: 'overview')
  String? overview;

  @JsonKey(name: 'images')
  List<ReadarrImage>? images;

  @JsonKey(name: 'remotePoster')
  String? remotePoster;

  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'metadataProfileId')
  int? metadataProfileId;

  @JsonKey(name: 'qualityProfileId')
  int? qualityProfileId;

  @JsonKey(name: 'monitored')
  bool? monitored;

  @JsonKey(name: 'monitorNewItems')
  String? monitorNewItems;

  @JsonKey(name: 'foreignAuthorId')
  String? foreignAuthorId;

  @JsonKey(name: 'cleanName')
  String? cleanTitle;

  @JsonKey(name: 'titleSlug')
  String? titleSlug;

  @JsonKey(name: 'folder')
  String? folder;

  @JsonKey(name: 'rootFolderPath')
  String? rootFolderPath;

  @JsonKey(name: 'genres')
  List<String>? genres;

  @JsonKey(name: 'tags')
  List<int>? tags;

  @JsonKey(
    name: 'added',
    toJson: ReadarrUtilities.dateTimeToJson,
    fromJson: ReadarrUtilities.dateTimeFromJson,
  )
  DateTime? added;

  @JsonKey(name: 'ratings')
  ReadarrAuthorRating? ratings;

  @JsonKey(name: 'statistics')
  ReadarrAuthorStatistics? statistics;

  @JsonKey(name: 'id')
  int? id;

  ReadarrAuthor({
    this.title,
    this.sortTitle,
    this.status,
    this.ended,
    this.overview,
    this.images,
    this.remotePoster,
    this.path,
    this.qualityProfileId,
    this.monitored,
    this.cleanTitle,
    this.titleSlug,
    this.folder,
    this.rootFolderPath,
    this.genres,
    this.tags,
    this.added,
    this.ratings,
    this.statistics,
    this.id,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrAuthor.fromJson(Map<String, dynamic> json) =>
      _$ReadarrAuthorFromJson(json);

  Map<String, dynamic> toJson() => _$ReadarrAuthorToJson(this);
}
