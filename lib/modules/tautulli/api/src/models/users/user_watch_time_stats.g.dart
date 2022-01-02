// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_watch_time_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliUserWatchTimeStats _$TautulliUserWatchTimeStatsFromJson(
    Map<String, dynamic> json) {
  return TautulliUserWatchTimeStats(
    queryDays: TautulliUtilities.ensureIntegerFromJson(json['query_days']),
    totalPlays: TautulliUtilities.ensureIntegerFromJson(json['total_plays']),
    totalTime: TautulliUtilities.secondsDurationFromJson(json['total_time']),
  );
}

Map<String, dynamic> _$TautulliUserWatchTimeStatsToJson(
        TautulliUserWatchTimeStats instance) =>
    <String, dynamic>{
      'query_days': instance.queryDays,
      'total_plays': instance.totalPlays,
      'total_time': instance.totalTime?.inMicroseconds,
    };
