// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_logins.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliUserLogins _$TautulliUserLoginsFromJson(Map<String, dynamic> json) {
  return TautulliUserLogins(
    recordsFiltered:
        TautulliUtilities.ensureIntegerFromJson(json['recordsFiltered']),
    recordsTotal: TautulliUtilities.ensureIntegerFromJson(json['recordsTotal']),
    draw: TautulliUtilities.ensureIntegerFromJson(json['draw']),
    logins: TautulliUserLogins._loginsFromJson(json['data'] as List),
  );
}

Map<String, dynamic> _$TautulliUserLoginsToJson(TautulliUserLogins instance) =>
    <String, dynamic>{
      'recordsFiltered': instance.recordsFiltered,
      'recordsTotal': instance.recordsTotal,
      'draw': instance.draw,
      'data': TautulliUserLogins._loginsToJson(instance.logins),
    };
