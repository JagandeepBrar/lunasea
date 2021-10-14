// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrCommand _$SonarrCommandFromJson(Map<String, dynamic> json) =>
    SonarrCommand(
      name: json['name'] as String?,
      body: json['body'] == null
          ? null
          : SonarrCommandBody.fromJson(json['body'] as Map<String, dynamic>),
      priority: json['priority'] as String?,
      status: json['status'] as String?,
      queued: SonarrUtilities.dateTimeFromJson(json['queued'] as String?),
      trigger: json['trigger'] as String?,
      state: json['state'] as String?,
      manual: json['manual'] as bool?,
      startedOn: SonarrUtilities.dateTimeFromJson(json['startedOn'] as String?),
      sendUpdatesToClient: json['sendUpdatesToClient'] as bool?,
      updateScheduledTask: json['updateScheduledTask'] as bool?,
      id: json['id'] as int?,
    )
      ..message = json['message'] as String?
      ..started = SonarrUtilities.dateTimeFromJson(json['started'] as String?)
      ..stateChangeTime =
          SonarrUtilities.dateTimeFromJson(json['stateChangeTime'] as String?);

Map<String, dynamic> _$SonarrCommandToJson(SonarrCommand instance) =>
    <String, dynamic>{
      'name': instance.name,
      'message': instance.message,
      'body': instance.body?.toJson(),
      'priority': instance.priority,
      'status': instance.status,
      'queued': SonarrUtilities.dateTimeToJson(instance.queued),
      'started': SonarrUtilities.dateTimeToJson(instance.started),
      'trigger': instance.trigger,
      'state': instance.state,
      'manual': instance.manual,
      'startedOn': SonarrUtilities.dateTimeToJson(instance.startedOn),
      'stateChangeTime':
          SonarrUtilities.dateTimeToJson(instance.stateChangeTime),
      'sendUpdatesToClient': instance.sendUpdatesToClient,
      'updateScheduledTask': instance.updateScheduledTask,
      'id': instance.id,
    };
