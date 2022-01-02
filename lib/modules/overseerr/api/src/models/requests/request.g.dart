// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverseerrRequest _$OverseerrRequestFromJson(Map<String, dynamic> json) {
  return OverseerrRequest(
    id: json['id'] as int?,
    status: OverseerrUtilities.requestStatusFromJson(json['status'] as int?),
    createdAt:
        OverseerrUtilities.dateTimeFromJson(json['createdAt'] as String?),
    updatedAt:
        OverseerrUtilities.dateTimeFromJson(json['updatedAt'] as String?),
    type: OverseerrUtilities.mediaTypeFromJson(json['type'] as String?),
    is4k: json['is4k'] as bool?,
    serverId: json['serverId'] as int?,
    profileId: json['profileId'] as int?,
    rootFolder: json['rootFolder'] as String?,
    languageProfileId: json['languageProfileId'] as int?,
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e as int).toList(),
    media: json['media'] == null
        ? null
        : OverseerrMedia.fromJson(json['media'] as Map<String, dynamic>),
    requestedBy: json['requestedBy'] == null
        ? null
        : OverseerrUser.fromJson(json['requestedBy'] as Map<String, dynamic>),
    modifiedBy: json['modifiedBy'] == null
        ? null
        : OverseerrUser.fromJson(json['modifiedBy'] as Map<String, dynamic>),
    seasonCount: json['seasonCount'] as int?,
  );
}

Map<String, dynamic> _$OverseerrRequestToJson(OverseerrRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull(
      'status', OverseerrUtilities.requestStatusToJson(instance.status));
  writeNotNull(
      'createdAt', OverseerrUtilities.dateTimeToJson(instance.createdAt));
  writeNotNull(
      'updatedAt', OverseerrUtilities.dateTimeToJson(instance.updatedAt));
  writeNotNull('type', OverseerrUtilities.mediaTypeToJson(instance.type));
  writeNotNull('is4k', instance.is4k);
  writeNotNull('serverId', instance.serverId);
  writeNotNull('profileId', instance.profileId);
  writeNotNull('rootFolder', instance.rootFolder);
  writeNotNull('languageProfileId', instance.languageProfileId);
  writeNotNull('tags', instance.tags);
  writeNotNull('media', instance.media?.toJson());
  writeNotNull('requestedBy', instance.requestedBy?.toJson());
  writeNotNull('modifiedBy', instance.modifiedBy?.toJson());
  writeNotNull('seasonCount', instance.seasonCount);
  return val;
}
