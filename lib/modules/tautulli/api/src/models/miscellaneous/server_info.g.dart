// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliServerInfo _$TautulliServerInfoFromJson(Map<String, dynamic> json) {
  return TautulliServerInfo(
    name: TautulliUtilities.ensureStringFromJson(json['name']),
    machineIdentifier:
        TautulliUtilities.ensureStringFromJson(json['machine_identifier']),
    host: TautulliUtilities.ensureStringFromJson(json['host']),
    port: TautulliUtilities.ensureIntegerFromJson(json['port']),
    version: TautulliUtilities.ensureStringFromJson(json['version']),
  );
}

Map<String, dynamic> _$TautulliServerInfoToJson(TautulliServerInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'machine_identifier': instance.machineIdentifier,
      'version': instance.version,
      'host': instance.host,
      'port': instance.port,
    };
