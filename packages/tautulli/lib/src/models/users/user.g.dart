// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliUser _$TautulliUserFromJson(Map<String, dynamic> json) {
  return TautulliUser(
    rowId: TautulliUtilities.ensureIntegerFromJson(json['row_id']),
    userId: TautulliUtilities.ensureIntegerFromJson(json['user_id']),
    friendlyName: TautulliUtilities.ensureStringFromJson(json['friendly_name']),
    thumb: TautulliUtilities.ensureStringFromJson(json['thumb']),
    userThumb: TautulliUtilities.ensureStringFromJson(json['user_thumb']),
    email: TautulliUtilities.ensureStringFromJson(json['email']),
    isActive: TautulliUtilities.ensureBooleanFromJson(json['is_active']),
    isAdmin: TautulliUtilities.ensureBooleanFromJson(json['is_admin']),
    isHomeUser: TautulliUtilities.ensureBooleanFromJson(json['is_home_user']),
    isAllowSync: TautulliUtilities.ensureBooleanFromJson(json['is_allow_sync']),
    isRestricted:
        TautulliUtilities.ensureBooleanFromJson(json['is_restricted']),
    doNotify: TautulliUtilities.ensureBooleanFromJson(json['do_notify']),
    keepHistory: TautulliUtilities.ensureBooleanFromJson(json['keep_history']),
    allowGuest: TautulliUtilities.ensureBooleanFromJson(json['allow_guest']),
    serverToken: TautulliUtilities.ensureStringFromJson(json['server_token']),
    sharedLibraries:
        TautulliUtilities.ensureStringListFromJson(json['shared_libraries']),
    filterAll: TautulliUtilities.ensureStringFromJson(json['filter_all']),
    filterMovies: TautulliUtilities.ensureStringFromJson(json['filter_movies']),
    filterTv: TautulliUtilities.ensureStringFromJson(json['filter_tv']),
    filterMusic: TautulliUtilities.ensureStringFromJson(json['filter_music']),
    filterPhotos: TautulliUtilities.ensureStringFromJson(json['filter_photos']),
  );
}

Map<String, dynamic> _$TautulliUserToJson(TautulliUser instance) =>
    <String, dynamic>{
      'row_id': instance.rowId,
      'user_id': instance.userId,
      'friendly_name': instance.friendlyName,
      'thumb': instance.thumb,
      'user_thumb': instance.userThumb,
      'email': instance.email,
      'is_active': instance.isActive,
      'is_admin': instance.isAdmin,
      'is_home_user': instance.isHomeUser,
      'is_allow_sync': instance.isAllowSync,
      'is_restricted': instance.isRestricted,
      'do_notify': instance.doNotify,
      'keep_history': instance.keepHistory,
      'allow_guest': instance.allowGuest,
      'server_token': instance.serverToken,
      'shared_libraries': instance.sharedLibraries,
      'filter_all': instance.filterAll,
      'filter_movies': instance.filterMovies,
      'filter_tv': instance.filterTv,
      'filter_music': instance.filterMusic,
      'filter_photos': instance.filterPhotos,
    };
