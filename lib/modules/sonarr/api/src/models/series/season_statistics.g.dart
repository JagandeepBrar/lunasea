// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrSeriesSeasonStatistics _$SonarrSeriesSeasonStatisticsFromJson(
        Map<String, dynamic> json) =>
    SonarrSeriesSeasonStatistics(
      previousAiring:
          SonarrUtilities.dateTimeFromJson(json['previousAiring'] as String?),
      nextAiring:
          SonarrUtilities.dateTimeFromJson(json['nextAiring'] as String?),
      episodeFileCount: json['episodeFileCount'] as int?,
      episodeCount: json['episodeCount'] as int?,
      totalEpisodeCount: json['totalEpisodeCount'] as int?,
      sizeOnDisk: json['sizeOnDisk'] as int?,
      percentOfEpisodes: (json['percentOfEpisodes'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SonarrSeriesSeasonStatisticsToJson(
    SonarrSeriesSeasonStatistics instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('previousAiring',
      SonarrUtilities.dateTimeToJson(instance.previousAiring));
  writeNotNull(
      'nextAiring', SonarrUtilities.dateTimeToJson(instance.nextAiring));
  writeNotNull('episodeFileCount', instance.episodeFileCount);
  writeNotNull('episodeCount', instance.episodeCount);
  writeNotNull('totalEpisodeCount', instance.totalEpisodeCount);
  writeNotNull('sizeOnDisk', instance.sizeOnDisk);
  writeNotNull('percentOfEpisodes', instance.percentOfEpisodes);
  return val;
}
