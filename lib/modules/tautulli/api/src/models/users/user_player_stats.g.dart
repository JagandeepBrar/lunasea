// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_player_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliUserPlayerStats _$TautulliUserPlayerStatsFromJson(
    Map<String, dynamic> json) {
  return TautulliUserPlayerStats(
    resultId: TautulliUtilities.ensureIntegerFromJson(json['result_id']),
    totalPlays: TautulliUtilities.ensureIntegerFromJson(json['total_plays']),
    platform: TautulliUtilities.ensureStringFromJson(json['platform']),
    platformName: TautulliUtilities.ensureStringFromJson(json['platform_name']),
    playerName: TautulliUtilities.ensureStringFromJson(json['player_name']),
  );
}

Map<String, dynamic> _$TautulliUserPlayerStatsToJson(
        TautulliUserPlayerStats instance) =>
    <String, dynamic>{
      'result_id': instance.resultId,
      'total_plays': instance.totalPlays,
      'player_name': instance.playerName,
      'platform': instance.platform,
      'platform_name': instance.platformName,
    };
