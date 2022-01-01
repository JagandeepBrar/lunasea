// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliServer _$TautulliServerFromJson(Map<String, dynamic> json) {
  return TautulliServer(
    httpsRequired:
        TautulliUtilities.ensureBooleanFromJson(json['httpsRequired']),
    local: TautulliUtilities.ensureBooleanFromJson(json['local']),
    clientIdentifier:
        TautulliUtilities.ensureStringFromJson(json['clientIdentifier']),
    label: TautulliUtilities.ensureStringFromJson(json['label']),
    ipAddress: TautulliUtilities.ensureStringFromJson(json['ip']),
    port: TautulliUtilities.ensureIntegerFromJson(json['port']),
    uri: TautulliUtilities.ensureStringFromJson(json['uri']),
    value: TautulliUtilities.ensureStringFromJson(json['value']),
    isCloud: TautulliUtilities.ensureBooleanFromJson(json['is_cloud']),
  );
}

Map<String, dynamic> _$TautulliServerToJson(TautulliServer instance) =>
    <String, dynamic>{
      'httpsRequired': instance.httpsRequired,
      'local': instance.local,
      'clientIdentifier': instance.clientIdentifier,
      'label': instance.label,
      'ip': instance.ipAddress,
      'port': instance.port,
      'uri': instance.uri,
      'value': instance.value,
      'is_cloud': instance.isCloud,
    };
