// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whois_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliWHOISInfo _$TautulliWHOISInfoFromJson(Map<String, dynamic> json) {
  return TautulliWHOISInfo(
    host: TautulliUtilities.ensureStringFromJson(json['host']),
    subnets: TautulliWHOISInfo._subnetsToObjectArray(json['nets'] as List),
  );
}

Map<String, dynamic> _$TautulliWHOISInfoToJson(TautulliWHOISInfo instance) =>
    <String, dynamic>{
      'host': instance.host,
      'nets': TautulliWHOISInfo._subnetsToMap(instance.subnets),
    };
