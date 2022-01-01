// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliHistoryRecord _$TautulliHistoryRecordFromJson(
    Map<String, dynamic> json) {
  return TautulliHistoryRecord(
    referenceId: TautulliUtilities.ensureIntegerFromJson(json['reference_id']),
    rowId: TautulliUtilities.ensureIntegerFromJson(json['row_id']),
    id: TautulliUtilities.ensureIntegerFromJson(json['id']),
    date: TautulliUtilities.millisecondsDateTimeFromJson(json['date']),
    started: TautulliUtilities.millisecondsDateTimeFromJson(json['started']),
    stopped: TautulliUtilities.millisecondsDateTimeFromJson(json['stopped']),
    duration: TautulliUtilities.secondsDurationFromJson(json['duration']),
    pausedCounter:
        TautulliUtilities.secondsDurationFromJson(json['paused_counter']),
    userId: TautulliUtilities.ensureIntegerFromJson(json['user_id']),
    user: TautulliUtilities.ensureStringFromJson(json['user']),
    friendlyName: TautulliUtilities.ensureStringFromJson(json['friendly_name']),
    platform: TautulliUtilities.ensureStringFromJson(json['platform']),
    player: TautulliUtilities.ensureStringFromJson(json['player']),
    product: TautulliUtilities.ensureStringFromJson(json['product']),
    ipAddress: TautulliUtilities.ensureStringFromJson(json['ip_address']),
    live: TautulliUtilities.ensureBooleanFromJson(json['live']),
    mediaType:
        TautulliUtilities.mediaTypeFromJson(json['media_type'] as String?),
    ratingKey: TautulliUtilities.ensureIntegerFromJson(json['rating_key']),
    parentRatingKey:
        TautulliUtilities.ensureIntegerFromJson(json['parent_rating_key']),
    grandparentRatingKey:
        TautulliUtilities.ensureIntegerFromJson(json['grandparent_rating_key']),
    fullTitle: TautulliUtilities.ensureStringFromJson(json['full_title']),
    title: TautulliUtilities.ensureStringFromJson(json['title']),
    parentTitle: TautulliUtilities.ensureStringFromJson(json['parent_title']),
    grandparentTitle:
        TautulliUtilities.ensureStringFromJson(json['grandparent_title']),
    originalTitle:
        TautulliUtilities.ensureStringFromJson(json['original_title']),
    year: TautulliUtilities.ensureIntegerFromJson(json['year']),
    mediaIndex: TautulliUtilities.ensureIntegerFromJson(json['media_index']),
    parentMediaIndex:
        TautulliUtilities.ensureIntegerFromJson(json['parent_media_index']),
    thumb: TautulliUtilities.ensureStringFromJson(json['thumb']),
    originallyAvailableAt:
        TautulliUtilities.ensureStringFromJson(json['originally_available_at']),
    guid: TautulliUtilities.ensureStringFromJson(json['guid']),
    transcodeDecision: TautulliUtilities.transcodeDecisionFromJson(
        json['transcode_decision'] as String?),
    percentComplete:
        TautulliUtilities.ensureIntegerFromJson(json['percent_complete']),
    watchedStatus:
        TautulliUtilities.watchedStatusFromJson(json['watched_status'] as num?),
    groupCount: TautulliUtilities.ensureIntegerFromJson(json['group_count']),
    groupIds: TautulliUtilities.stringToListStringFromJson(
        json['group_ids'] as String?),
    state: TautulliUtilities.sessionStateFromJson(json['state'] as String?),
    sessionKey: TautulliUtilities.ensureIntegerFromJson(json['session_key']),
  );
}

Map<String, dynamic> _$TautulliHistoryRecordToJson(
        TautulliHistoryRecord instance) =>
    <String, dynamic>{
      'reference_id': instance.referenceId,
      'row_id': instance.rowId,
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'started': instance.started?.toIso8601String(),
      'stopped': instance.stopped?.toIso8601String(),
      'duration': instance.duration?.inMicroseconds,
      'paused_counter': instance.pausedCounter?.inMicroseconds,
      'user_id': instance.userId,
      'user': instance.user,
      'friendly_name': instance.friendlyName,
      'platform': instance.platform,
      'product': instance.product,
      'player': instance.player,
      'ip_address': instance.ipAddress,
      'live': instance.live,
      'media_type': TautulliUtilities.mediaTypeToJson(instance.mediaType),
      'rating_key': instance.ratingKey,
      'parent_rating_key': instance.parentRatingKey,
      'grandparent_rating_key': instance.grandparentRatingKey,
      'full_title': instance.fullTitle,
      'title': instance.title,
      'parent_title': instance.parentTitle,
      'grandparent_title': instance.grandparentTitle,
      'original_title': instance.originalTitle,
      'year': instance.year,
      'media_index': instance.mediaIndex,
      'parent_media_index': instance.parentMediaIndex,
      'thumb': instance.thumb,
      'originally_available_at': instance.originallyAvailableAt,
      'guid': instance.guid,
      'transcode_decision':
          TautulliUtilities.transcodeDecisionToJson(instance.transcodeDecision),
      'percent_complete': instance.percentComplete,
      'watched_status':
          TautulliUtilities.watchedStatusToJson(instance.watchedStatus),
      'group_count': instance.groupCount,
      'group_ids': instance.groupIds,
      'state': TautulliUtilities.sessionStateToJson(instance.state),
      'session_key': instance.sessionKey,
    };
