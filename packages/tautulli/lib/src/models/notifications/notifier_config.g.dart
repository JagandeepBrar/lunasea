// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifier_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliNotifierConfig _$TautulliNotifierConfigFromJson(
    Map<String, dynamic> json) {
  return TautulliNotifierConfig(
    id: TautulliUtilities.ensureIntegerFromJson(json['id']),
    agentId: TautulliUtilities.ensureIntegerFromJson(json['agent_id']),
    agentName: TautulliUtilities.ensureStringFromJson(json['agent_name']),
    agentLabel: TautulliUtilities.ensureStringFromJson(json['agent_label']),
    friendlyName: TautulliUtilities.ensureStringFromJson(json['friendly_name']),
    customConditions: (json['custom_conditions'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
    customConditionsLogic:
        TautulliUtilities.ensureStringFromJson(json['custom_conditions_logic']),
    config: json['config'] as Map<String, dynamic>?,
    configOptions: (json['config_options'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
    actions: TautulliNotifierConfig._optionsFromJson(
        json['actions'] as Map<String, dynamic>),
    notifyText: json['notify_text'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$TautulliNotifierConfigToJson(
        TautulliNotifierConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'agent_id': instance.agentId,
      'agent_name': instance.agentName,
      'agent_label': instance.agentLabel,
      'friendly_name': instance.friendlyName,
      'custom_conditions': instance.customConditions,
      'custom_conditions_logic': instance.customConditionsLogic,
      'config': instance.config,
      'config_options': instance.configOptions,
      'actions': TautulliNotifierConfig._optionsToJson(instance.actions),
      'notify_text': instance.notifyText,
    };
