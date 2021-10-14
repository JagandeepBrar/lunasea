// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_ip_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliUserIPRecord _$TautulliUserIPRecordFromJson(Map<String, dynamic> json) {
  return TautulliUserIPRecord(
    historyRowId:
        TautulliUtilities.ensureIntegerFromJson(json['history_row_id']),
    lastSeen: TautulliUtilities.millisecondsDateTimeFromJson(json['last_seen']),
    firstSeen:
        TautulliUtilities.millisecondsDateTimeFromJson(json['first_seen']),
    ipAddress: TautulliUtilities.ensureStringFromJson(json['ip_address']),
    playCount: TautulliUtilities.ensureIntegerFromJson(json['play_count']),
    platform: TautulliUtilities.ensureStringFromJson(json['platform']),
    player: TautulliUtilities.ensureStringFromJson(json['player']),
    lastPlayed: TautulliUtilities.ensureStringFromJson(json['last_played']),
    ratingKey: TautulliUtilities.ensureIntegerFromJson(json['rating_key']),
    thumb: TautulliUtilities.ensureStringFromJson(json['thumb']),
    mediaType:
        TautulliUtilities.mediaTypeFromJson(json['media_type'] as String?),
    parentTitle: TautulliUtilities.ensureStringFromJson(json['parent_title']),
    year: TautulliUtilities.ensureIntegerFromJson(json['year']),
    mediaIndex: TautulliUtilities.ensureIntegerFromJson(json['media_index']),
    parentMediaIndex:
        TautulliUtilities.ensureIntegerFromJson(json['parent_media_index']),
    live: TautulliUtilities.ensureBooleanFromJson(json['live']),
    originallyAvailableAt:
        TautulliUtilities.ensureStringFromJson(json['originally_available_at']),
    guid: TautulliUtilities.ensureStringFromJson(json['guid']),
    friendlyName: TautulliUtilities.ensureStringFromJson(json['friendly_name']),
    userId: TautulliUtilities.ensureIntegerFromJson(json['user_id']),
    transcodedecision: TautulliUtilities.transcodeDecisionFromJson(
        json['transcode_decision'] as String?),
  );
}

Map<String, dynamic> _$TautulliUserIPRecordToJson(
        TautulliUserIPRecord instance) =>
    <String, dynamic>{
      'history_row_id': instance.historyRowId,
      'last_seen': instance.lastSeen?.toIso8601String(),
      'first_seen': instance.firstSeen?.toIso8601String(),
      'ip_address': instance.ipAddress,
      'play_count': instance.playCount,
      'platform': instance.platform,
      'player': instance.player,
      'last_played': instance.lastPlayed,
      'rating_key': instance.ratingKey,
      'thumb': instance.thumb,
      'media_type': TautulliUtilities.mediaTypeToJson(instance.mediaType),
      'parent_title': instance.parentTitle,
      'year': instance.year,
      'media_index': instance.mediaIndex,
      'parent_media_index': instance.parentMediaIndex,
      'live': instance.live,
      'originally_available_at': instance.originallyAvailableAt,
      'guid': instance.guid,
      'friendly_name': instance.friendlyName,
      'user_id': instance.userId,
      'transcode_decision':
          TautulliUtilities.transcodeDecisionToJson(instance.transcodedecision),
    };
