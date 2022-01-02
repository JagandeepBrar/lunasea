// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'synced_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliSyncedItem _$TautulliSyncedItemFromJson(Map<String, dynamic> json) {
  return TautulliSyncedItem(
    deviceName: TautulliUtilities.ensureStringFromJson(json['device_name']),
    platform: TautulliUtilities.ensureStringFromJson(json['platform']),
    userId: TautulliUtilities.ensureIntegerFromJson(json['user_id']),
    user: TautulliUtilities.ensureStringFromJson(json['user']),
    username: TautulliUtilities.ensureStringFromJson(json['username']),
    rootTitle: TautulliUtilities.ensureStringFromJson(json['root_title']),
    syncTitle: TautulliUtilities.ensureStringFromJson(json['sync_title']),
    metadataType: TautulliUtilities.ensureStringFromJson(json['metadata_type']),
    contentType: TautulliUtilities.ensureStringFromJson(json['content_type']),
    ratingKey: TautulliUtilities.ensureIntegerFromJson(json['rating_key']),
    state: TautulliUtilities.ensureStringFromJson(json['state']),
    itemCount: TautulliUtilities.ensureIntegerFromJson(json['item_count']),
    itemCompleteCount:
        TautulliUtilities.ensureIntegerFromJson(json['item_complete_count']),
    itemDownloadedCount:
        TautulliUtilities.ensureIntegerFromJson(json['item_downloaded_count']),
    itemDownloadedPercentComplete: TautulliUtilities.ensureIntegerFromJson(
        json['item_downloaded_percent_complete']),
    videoBitrate:
        TautulliUtilities.ensureIntegerFromJson(json['video_bitrate']),
    audioBitrate:
        TautulliUtilities.ensureIntegerFromJson(json['audio_bitrate']),
    photoQuality:
        TautulliUtilities.ensureIntegerFromJson(json['photo_quality']),
    videoQuality:
        TautulliUtilities.ensureIntegerFromJson(json['video_quality']),
    totalSize: TautulliUtilities.ensureIntegerFromJson(json['total_size']),
    failure: TautulliUtilities.ensureStringFromJson(json['failure']),
    clientId: TautulliUtilities.ensureStringFromJson(json['client_id']),
    syncId: TautulliUtilities.ensureStringFromJson(json['sync_id']),
  );
}

Map<String, dynamic> _$TautulliSyncedItemToJson(TautulliSyncedItem instance) =>
    <String, dynamic>{
      'device_name': instance.deviceName,
      'platform': instance.platform,
      'user_id': instance.userId,
      'user': instance.user,
      'username': instance.username,
      'root_title': instance.rootTitle,
      'sync_title': instance.syncTitle,
      'metadata_type': instance.metadataType,
      'content_type': instance.contentType,
      'rating_key': instance.ratingKey,
      'state': instance.state,
      'item_count': instance.itemCount,
      'item_complete_count': instance.itemCompleteCount,
      'item_downloaded_count': instance.itemDownloadedCount,
      'item_downloaded_percent_complete':
          instance.itemDownloadedPercentComplete,
      'video_bitrate': instance.videoBitrate,
      'audio_bitrate': instance.audioBitrate,
      'photo_quality': instance.photoQuality,
      'video_quality': instance.videoQuality,
      'total_size': instance.totalSize,
      'failure': instance.failure,
      'client_id': instance.clientId,
      'sync_id': instance.syncId,
    };
