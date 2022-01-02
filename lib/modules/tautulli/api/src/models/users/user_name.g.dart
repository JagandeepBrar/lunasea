// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliUserName _$TautulliUserNameFromJson(Map<String, dynamic> json) {
  return TautulliUserName(
    userId: TautulliUtilities.ensureIntegerFromJson(json['user_id']),
    friendlyName: TautulliUtilities.ensureStringFromJson(json['friendly_name']),
  );
}

Map<String, dynamic> _$TautulliUserNameToJson(TautulliUserName instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'friendly_name': instance.friendlyName,
    };
