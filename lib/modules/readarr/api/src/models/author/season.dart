import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/readarr.dart';

part 'season.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrAuthorSeason {
  @JsonKey(name: 'seasonNumber')
  int? seasonNumber;

  @JsonKey(name: 'monitored')
  bool? monitored;

  @JsonKey(name: 'statistics')
  ReadarrAuthorSeasonStatistics? statistics;

  @JsonKey(name: 'images')
  List<ReadarrImage>? images;

  ReadarrAuthorSeason({
    this.seasonNumber,
    this.monitored,
    this.statistics,
    this.images,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrAuthorSeason.fromJson(Map<String, dynamic> json) =>
      _$ReadarrAuthorSeasonFromJson(json);
  Map<String, dynamic> toJson() => _$ReadarrAuthorSeasonToJson(this);
}
