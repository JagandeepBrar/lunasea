import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'author_statistics.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrAuthorStatistics {
  @JsonKey(name: 'seasonCount')
  int? seasonCount;

  @JsonKey(name: 'bookFileCount')
  int? episodeFileCount;

  @JsonKey(name: 'bookCount')
  int? episodeCount;

  @JsonKey(name: 'totalBookCount')
  int? totalEpisodeCount;

  @JsonKey(name: 'sizeOnDisk')
  int? sizeOnDisk;

  @JsonKey(name: 'percentOfBooks')
  double? percentOfEpisodes;

  ReadarrAuthorStatistics({
    this.episodeFileCount,
    this.episodeCount,
    this.totalEpisodeCount,
    this.sizeOnDisk,
    this.percentOfEpisodes,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrAuthorStatistics.fromJson(Map<String, dynamic> json) =>
      _$ReadarrAuthorStatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$ReadarrAuthorStatisticsToJson(this);
}
