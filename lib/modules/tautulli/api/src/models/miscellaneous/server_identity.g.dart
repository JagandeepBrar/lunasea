// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_identity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliServerIdentity _$TautulliServerIdentityFromJson(
    Map<String, dynamic> json) {
  return TautulliServerIdentity(
    machineIdentifier:
        TautulliUtilities.ensureStringFromJson(json['machine_identifier']),
    version: TautulliUtilities.ensureStringFromJson(json['version']),
  );
}

Map<String, dynamic> _$TautulliServerIdentityToJson(
        TautulliServerIdentity instance) =>
    <String, dynamic>{
      'machine_identifier': instance.machineIdentifier,
      'version': instance.version,
    };
