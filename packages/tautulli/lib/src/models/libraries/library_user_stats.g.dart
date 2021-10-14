// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_user_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliLibraryUserStats _$TautulliLibraryUserStatsFromJson(
    Map<String, dynamic> json) {
  return TautulliLibraryUserStats(
    friendlyName: TautulliUtilities.ensureStringFromJson(json['friendly_name']),
    userId: TautulliUtilities.ensureIntegerFromJson(json['user_id']),
    userThumb: TautulliUtilities.ensureStringFromJson(json['user_thumb']),
    totalPlays: TautulliUtilities.ensureIntegerFromJson(json['total_plays']),
  );
}

Map<String, dynamic> _$TautulliLibraryUserStatsToJson(
        TautulliLibraryUserStats instance) =>
    <String, dynamic>{
      'friendly_name': instance.friendlyName,
      'user_thumb': instance.userThumb,
      'user_id': instance.userId,
      'total_plays': instance.totalPlays,
    };
