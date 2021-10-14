// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsletter_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliNewsletterConfig _$TautulliNewsletterConfigFromJson(
    Map<String, dynamic> json) {
  return TautulliNewsletterConfig(
    id: TautulliUtilities.ensureIntegerFromJson(json['id']),
    idName: TautulliUtilities.ensureStringFromJson(json['id_name']),
    agentId: TautulliUtilities.ensureIntegerFromJson(json['agent_id']),
    agentName: TautulliUtilities.ensureStringFromJson(json['agent_name']),
    agentLabel: TautulliUtilities.ensureStringFromJson(json['agent_label']),
    friendlyName: TautulliUtilities.ensureStringFromJson(json['friendly_name']),
    cron: TautulliUtilities.ensureStringFromJson(json['cron']),
    active: TautulliUtilities.ensureBooleanFromJson(json['active']),
    body: TautulliUtilities.ensureStringFromJson(json['body']),
    subject: TautulliUtilities.ensureStringFromJson(json['subject']),
    message: TautulliUtilities.ensureStringFromJson(json['message']),
    config: json['config'] as Map<String, dynamic>?,
    configOptions: (json['config_options'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
    emailConfig: json['email_config'] as Map<String, dynamic>?,
    emailConfigOptions: (json['email_config_options'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
  );
}

Map<String, dynamic> _$TautulliNewsletterConfigToJson(
        TautulliNewsletterConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_name': instance.idName,
      'agent_id': instance.agentId,
      'agent_name': instance.agentName,
      'agent_label': instance.agentLabel,
      'friendly_name': instance.friendlyName,
      'cron': instance.cron,
      'active': instance.active,
      'subject': instance.subject,
      'body': instance.body,
      'message': instance.message,
      'config': instance.config,
      'config_options': instance.configOptions,
      'email_config': instance.emailConfig,
      'email_config_options': instance.emailConfigOptions,
    };
