// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliTableUser _$TautulliTableUserFromJson(Map<String, dynamic> json) {
  return TautulliTableUser(
    rowId: TautulliUtilities.ensureIntegerFromJson(json['row_id']),
    userId: TautulliUtilities.ensureIntegerFromJson(json['user_id']),
    friendlyName: TautulliUtilities.ensureStringFromJson(json['friendly_name']),
    userThumb: TautulliUtilities.ensureStringFromJson(json['user_thumb']),
    plays: TautulliUtilities.ensureIntegerFromJson(json['plays']),
    duration: TautulliUtilities.secondsDurationFromJson(json['duration']),
    lastSeen: TautulliUtilities.millisecondsDateTimeFromJson(json['last_seen']),
    lastPlayed: TautulliUtilities.ensureStringFromJson(json['last_played']),
    historyRowId:
        TautulliUtilities.ensureIntegerFromJson(json['history_row_id']),
    ipAddress: TautulliUtilities.ensureStringFromJson(json['ip_address']),
    platform: TautulliUtilities.ensureStringFromJson(json['platform']),
    player: TautulliUtilities.ensureStringFromJson(json['player']),
    ratingKey: TautulliUtilities.ensureIntegerFromJson(json['rating_key']),
    mediaType:
        TautulliUtilities.mediaTypeFromJson(json['media_type'] as String?),
    thumb: TautulliUtilities.ensureStringFromJson(json['thumb']),
    parentTitle: TautulliUtilities.ensureStringFromJson(json['parent_title']),
    year: TautulliUtilities.ensureIntegerFromJson(json['year']),
    mediaIndex: TautulliUtilities.ensureIntegerFromJson(json['media_index']),
    parentMediaIndex:
        TautulliUtilities.ensureIntegerFromJson(json['parent_media_index']),
    live: TautulliUtilities.ensureBooleanFromJson(json['live']),
    originallyAvailableAt:
        TautulliUtilities.ensureStringFromJson(json['originally_available_at']),
    guid: TautulliUtilities.ensureStringFromJson(json['guid']),
    transcodeDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['transcode_decision'] as String?),
    doNotify: TautulliUtilities.ensureBooleanFromJson(json['do_notify']),
    keepHistory: TautulliUtilities.ensureBooleanFromJson(json['keep_history']),
    allowGuest: TautulliUtilities.ensureBooleanFromJson(json['allow_guest']),
    isActive: TautulliUtilities.ensureBooleanFromJson(json['is_active']),
  );
}

Map<String, dynamic> _$TautulliTableUserToJson(TautulliTableUser instance) =>
    <String, dynamic>{
      'row_id': instance.rowId,
      'user_id': instance.userId,
      'friendly_name': instance.friendlyName,
      'user_thumb': instance.userThumb,
      'plays': instance.plays,
      'duration': instance.duration?.inMicroseconds,
      'last_seen': instance.lastSeen?.toIso8601String(),
      'last_played': instance.lastPlayed,
      'history_row_id': instance.historyRowId,
      'ip_address': instance.ipAddress,
      'platform': instance.platform,
      'player': instance.player,
      'rating_key': instance.ratingKey,
      'media_type': TautulliUtilities.mediaTypeToJson(instance.mediaType),
      'thumb': instance.thumb,
      'parent_title': instance.parentTitle,
      'year': instance.year,
      'media_index': instance.mediaIndex,
      'parent_media_index': instance.parentMediaIndex,
      'live': instance.live,
      'originally_available_at': instance.originallyAvailableAt,
      'guid': instance.guid,
      'transcode_decision':
          TautulliUtilities.transcodeDecisionToJson(instance.transcodeDecision),
      'do_notify': instance.doNotify,
      'keep_history': instance.keepHistory,
      'allow_guest': instance.allowGuest,
      'is_active': instance.isActive,
    };
