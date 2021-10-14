// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrCommand _$RadarrCommandFromJson(Map<String, dynamic> json) {
  return RadarrCommand(
    name: json['name'] as String?,
    commandName: json['commandName'] as String?,
    message: json['message'] as String?,
    body: json['body'] == null
        ? null
        : RadarrCommandBody.fromJson(json['body'] as Map<String, dynamic>),
    priority: json['priority'] as String?,
    status: json['status'] as String?,
    queued: RadarrUtilities.dateTimeFromJson(json['queued'] as String?),
    started: RadarrUtilities.dateTimeFromJson(json['started'] as String?),
    ended: RadarrUtilities.dateTimeFromJson(json['ended'] as String?),
    trigger: json['trigger'] as String?,
    stateChangeTime:
        RadarrUtilities.dateTimeFromJson(json['stateChangeTime'] as String?),
    sendUpdatesToClient: json['sendUpdatesToClient'] as bool?,
    updateScheduledTask: json['updateScheduledTask'] as bool?,
    lastExecutionTime:
        RadarrUtilities.dateTimeFromJson(json['lastExecutionTime'] as String?),
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$RadarrCommandToJson(RadarrCommand instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('commandName', instance.commandName);
  writeNotNull('message', instance.message);
  writeNotNull('body', instance.body?.toJson());
  writeNotNull('priority', instance.priority);
  writeNotNull('status', instance.status);
  writeNotNull('queued', RadarrUtilities.dateTimeToJson(instance.queued));
  writeNotNull('started', RadarrUtilities.dateTimeToJson(instance.started));
  writeNotNull('ended', RadarrUtilities.dateTimeToJson(instance.ended));
  writeNotNull('trigger', instance.trigger);
  writeNotNull('stateChangeTime',
      RadarrUtilities.dateTimeToJson(instance.stateChangeTime));
  writeNotNull('sendUpdatesToClient', instance.sendUpdatesToClient);
  writeNotNull('updateScheduledTask', instance.updateScheduledTask);
  writeNotNull('lastExecutionTime',
      RadarrUtilities.dateTimeToJson(instance.lastExecutionTime));
  writeNotNull('id', instance.id);
  return val;
}
