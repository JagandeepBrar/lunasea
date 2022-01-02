// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliNotifier _$TautulliNotifierFromJson(Map<String, dynamic> json) {
  return TautulliNotifier(
    id: TautulliUtilities.ensureIntegerFromJson(json['id']),
    agentId: TautulliUtilities.ensureIntegerFromJson(json['agent_id']),
    agentName: TautulliUtilities.ensureStringFromJson(json['agent_name']),
    agentLabel: TautulliUtilities.ensureStringFromJson(json['agent_label']),
    friendlyName: TautulliUtilities.ensureStringFromJson(json['friendly_name']),
    active: TautulliUtilities.ensureBooleanFromJson(json['active']),
  );
}

Map<String, dynamic> _$TautulliNotifierToJson(TautulliNotifier instance) =>
    <String, dynamic>{
      'id': instance.id,
      'agent_id': instance.agentId,
      'agent_name': instance.agentName,
      'agent_label': instance.agentLabel,
      'friendly_name': instance.friendlyName,
      'active': instance.active,
    };
