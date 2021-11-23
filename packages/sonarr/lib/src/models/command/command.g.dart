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

Map<String, dynamic> _$SonarrCommandToJson(SonarrCommand instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('message', instance.message);
  writeNotNull('body', instance.body?.toJson());
  writeNotNull('priority', instance.priority);
  writeNotNull('status', instance.status);
  writeNotNull('queued', SonarrUtilities.dateTimeToJson(instance.queued));
  writeNotNull('started', SonarrUtilities.dateTimeToJson(instance.started));
  writeNotNull('trigger', instance.trigger);
  writeNotNull('state', instance.state);
  writeNotNull('manual', instance.manual);
  writeNotNull('startedOn', SonarrUtilities.dateTimeToJson(instance.startedOn));
  writeNotNull('stateChangeTime',
      SonarrUtilities.dateTimeToJson(instance.stateChangeTime));
  writeNotNull('sendUpdatesToClient', instance.sendUpdatesToClient);
  writeNotNull('updateScheduledTask', instance.updateScheduledTask);
  writeNotNull('id', instance.id);
  return val;
}
