// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsletter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliNewsletter _$TautulliNewsletterFromJson(Map<String, dynamic> json) {
  return TautulliNewsletter(
    id: TautulliUtilities.ensureIntegerFromJson(json['id']),
    agentId: TautulliUtilities.ensureIntegerFromJson(json['agent_id']),
    agentName: TautulliUtilities.ensureStringFromJson(json['agent_name']),
    agentLabel: TautulliUtilities.ensureStringFromJson(json['agent_label']),
    friendlyName: TautulliUtilities.ensureStringFromJson(json['friendly_name']),
    cron: TautulliUtilities.ensureStringFromJson(json['cron']),
    active: TautulliUtilities.ensureBooleanFromJson(json['active']),
  );
}

Map<String, dynamic> _$TautulliNewsletterToJson(TautulliNewsletter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'agent_id': instance.agentId,
      'agent_name': instance.agentName,
      'agent_label': instance.agentLabel,
      'friendly_name': instance.friendlyName,
      'cron': instance.cron,
      'active': instance.active,
    };
