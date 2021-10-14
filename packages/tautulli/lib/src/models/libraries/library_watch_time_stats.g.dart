// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_watch_time_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliLibraryWatchTimeStats _$TautulliLibraryWatchTimeStatsFromJson(
    Map<String, dynamic> json) {
  return TautulliLibraryWatchTimeStats(
    queryDays: TautulliUtilities.ensureIntegerFromJson(json['query_days']),
    totalPlays: TautulliUtilities.ensureIntegerFromJson(json['total_plays']),
    totalTime: TautulliUtilities.secondsDurationFromJson(json['total_time']),
  );
}

Map<String, dynamic> _$TautulliLibraryWatchTimeStatsToJson(
        TautulliLibraryWatchTimeStats instance) =>
    <String, dynamic>{
      'query_days': instance.queryDays,
      'total_plays': instance.totalPlays,
      'total_time': instance.totalTime?.inMicroseconds,
    };
