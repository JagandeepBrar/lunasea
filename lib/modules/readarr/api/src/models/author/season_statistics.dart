import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/readarr.dart';

part 'season_statistics.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrAuthorSeasonStatistics {
  @JsonKey(
    name: 'previousAiring',
    toJson: ReadarrUtilities.dateTimeToJson,
    fromJson: ReadarrUtilities.dateTimeFromJson,
  )
  DateTime? previousAiring;

  @JsonKey(
    name: 'nextAiring',
    toJson: ReadarrUtilities.dateTimeToJson,
    fromJson: ReadarrUtilities.dateTimeFromJson,
  )
  DateTime? nextAiring;

  @JsonKey(name: 'episodeFileCount')
  int? episodeFileCount;

  @JsonKey(name: 'episodeCount')
  int? episodeCount;

  @JsonKey(name: 'totalEpisodeCount')
  int? totalEpisodeCount;

  @JsonKey(name: 'sizeOnDisk')
  int? sizeOnDisk;

  @JsonKey(name: 'percentOfEpisodes')
  double? percentOfEpisodes;

  ReadarrAuthorSeasonStatistics({
    this.previousAiring,
    this.nextAiring,
    this.episodeFileCount,
    this.episodeCount,
    this.totalEpisodeCount,
    this.sizeOnDisk,
    this.percentOfEpisodes,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrAuthorSeasonStatistics.fromJson(Map<String, dynamic> json) =>
      _$ReadarrAuthorSeasonStatisticsFromJson(json);
  Map<String, dynamic> toJson() => _$ReadarrAuthorSeasonStatisticsToJson(this);
}
