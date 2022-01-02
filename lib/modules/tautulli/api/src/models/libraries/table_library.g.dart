// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliTableLibrary _$TautulliTableLibraryFromJson(Map<String, dynamic> json) {
  return TautulliTableLibrary(
    rowId: TautulliUtilities.ensureIntegerFromJson(json['row_id']),
    serverId: TautulliUtilities.ensureStringFromJson(json['server_id']),
    sectionId: TautulliUtilities.ensureIntegerFromJson(json['section_id']),
    sectionName: TautulliUtilities.ensureStringFromJson(json['section_name']),
    sectionType:
        TautulliUtilities.sectionTypeFromJson(json['section_type'] as String?),
    count: TautulliUtilities.ensureIntegerFromJson(json['count']),
    parentCount: TautulliUtilities.ensureIntegerFromJson(json['parent_count']),
    childCount: TautulliUtilities.ensureIntegerFromJson(json['child_count']),
    libraryArt: TautulliUtilities.ensureStringFromJson(json['library_art']),
    libraryThumb: TautulliUtilities.ensureStringFromJson(json['library_thumb']),
    plays: TautulliUtilities.ensureIntegerFromJson(json['plays']),
    duration: TautulliUtilities.secondsDurationFromJson(json['duration']),
    lastAccessed:
        TautulliUtilities.millisecondsDateTimeFromJson(json['last_accessed']),
    historyRowId:
        TautulliUtilities.ensureIntegerFromJson(json['history_row_id']),
    lastPlayed: TautulliUtilities.ensureStringFromJson(json['last_played']),
    ratingKey: TautulliUtilities.ensureIntegerFromJson(json['rating_key']),
    mediaType:
        TautulliUtilities.mediaTypeFromJson(json['media_type'] as String?),
    thumb: TautulliUtilities.ensureStringFromJson(json['thumb']),
    parentTitle: TautulliUtilities.ensureStringFromJson(json['parent_title']),
    year: TautulliUtilities.ensureIntegerFromJson(json['year']),
    mediaIndex: TautulliUtilities.ensureIntegerFromJson(json['media_index']),
    parentMediaIndex:
        TautulliUtilities.ensureIntegerFromJson(json['parent_media_index']),
    contentRating:
        TautulliUtilities.ensureStringFromJson(json['content_rating']),
    labels: TautulliUtilities.ensureStringListFromJson(json['labels']),
    live: TautulliUtilities.ensureBooleanFromJson(json['live']),
    originallyAvailableAt:
        TautulliUtilities.ensureStringFromJson(json['originally_available_at']),
    guid: TautulliUtilities.ensureStringFromJson(json['guid']),
    doNotify: TautulliUtilities.ensureBooleanFromJson(json['do_notify']),
    doNotifyCreated:
        TautulliUtilities.ensureBooleanFromJson(json['do_notify_created']),
    isActive: TautulliUtilities.ensureBooleanFromJson(json['is_active']),
    keepHistory: TautulliUtilities.ensureBooleanFromJson(json['keep_history']),
  );
}

Map<String, dynamic> _$TautulliTableLibraryToJson(
        TautulliTableLibrary instance) =>
    <String, dynamic>{
      'row_id': instance.rowId,
      'server_id': instance.serverId,
      'section_id': instance.sectionId,
      'section_name': instance.sectionName,
      'section_type': TautulliUtilities.sectionTypeToJson(instance.sectionType),
      'count': instance.count,
      'parent_count': instance.parentCount,
      'child_count': instance.childCount,
      'library_thumb': instance.libraryThumb,
      'library_art': instance.libraryArt,
      'plays': instance.plays,
      'duration': instance.duration?.inMicroseconds,
      'last_accessed': instance.lastAccessed?.toIso8601String(),
      'history_row_id': instance.historyRowId,
      'last_played': instance.lastPlayed,
      'rating_key': instance.ratingKey,
      'media_type': TautulliUtilities.mediaTypeToJson(instance.mediaType),
      'thumb': instance.thumb,
      'parent_title': instance.parentTitle,
      'year': instance.year,
      'media_index': instance.mediaIndex,
      'parent_media_index': instance.parentMediaIndex,
      'content_rating': instance.contentRating,
      'labels': instance.labels,
      'live': instance.live,
      'originally_available_at': instance.originallyAvailableAt,
      'guid': instance.guid,
      'do_notify': instance.doNotify,
      'do_notify_created': instance.doNotifyCreated,
      'keep_history': instance.keepHistory,
      'is_active': instance.isActive,
    };
