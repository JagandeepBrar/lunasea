// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_ips.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliUserIPs _$TautulliUserIPsFromJson(Map<String, dynamic> json) {
  return TautulliUserIPs(
    recordsFiltered:
        TautulliUtilities.ensureIntegerFromJson(json['recordsFiltered']),
    recordsTotal: TautulliUtilities.ensureIntegerFromJson(json['recordsTotal']),
    draw: TautulliUtilities.ensureIntegerFromJson(json['draw']),
    ips: TautulliUserIPs._ipsFromJson(json['data'] as List),
  );
}

Map<String, dynamic> _$TautulliUserIPsToJson(TautulliUserIPs instance) =>
    <String, dynamic>{
      'recordsFiltered': instance.recordsFiltered,
      'recordsTotal': instance.recordsTotal,
      'draw': instance.draw,
      'data': TautulliUserIPs._ipsToJson(instance.ips),
    };
