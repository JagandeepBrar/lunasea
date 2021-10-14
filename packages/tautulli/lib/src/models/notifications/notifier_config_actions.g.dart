// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifier_config_actions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliNotifierConfigActions _$TautulliNotifierConfigActionsFromJson(
    Map<String, dynamic> json) {
  return TautulliNotifierConfigActions(
    onPlay: TautulliUtilities.ensureBooleanFromJson(json['on_play']),
    onBuffer: TautulliUtilities.ensureBooleanFromJson(json['on_buffer']),
    onChange: TautulliUtilities.ensureBooleanFromJson(json['on_change']),
    onConcurrent:
        TautulliUtilities.ensureBooleanFromJson(json['on_concurrent']),
    onCreated: TautulliUtilities.ensureBooleanFromJson(json['on_created']),
    onNewDevice: TautulliUtilities.ensureBooleanFromJson(json['on_newdevice']),
    onPause: TautulliUtilities.ensureBooleanFromJson(json['on_pause']),
    onPlexServerDown:
        TautulliUtilities.ensureBooleanFromJson(json['on_intdown']),
    onPlexServerRemoteAccessDown:
        TautulliUtilities.ensureBooleanFromJson(json['on_extdown']),
    onPlexServerRemoteAccessUp:
        TautulliUtilities.ensureBooleanFromJson(json['on_extup']),
    onPlexServerUp: TautulliUtilities.ensureBooleanFromJson(json['on_intup']),
    onPlexUpdate: TautulliUtilities.ensureBooleanFromJson(json['on_pmsupdate']),
    onResume: TautulliUtilities.ensureBooleanFromJson(json['on_resume']),
    onStop: TautulliUtilities.ensureBooleanFromJson(json['on_stop']),
    onTautulliDatabaseCorruption:
        TautulliUtilities.ensureBooleanFromJson(json['on_plexpydbcorrupt']),
    onTautulliUpdate:
        TautulliUtilities.ensureBooleanFromJson(json['on_plexpyupdate']),
    onWatched: TautulliUtilities.ensureBooleanFromJson(json['on_watched']),
  );
}

Map<String, dynamic> _$TautulliNotifierConfigActionsToJson(
        TautulliNotifierConfigActions instance) =>
    <String, dynamic>{
      'on_play': instance.onPlay,
      'on_stop': instance.onStop,
      'on_pause': instance.onPause,
      'on_resume': instance.onResume,
      'on_change': instance.onChange,
      'on_buffer': instance.onBuffer,
      'on_watched': instance.onWatched,
      'on_concurrent': instance.onConcurrent,
      'on_newdevice': instance.onNewDevice,
      'on_created': instance.onCreated,
      'on_intdown': instance.onPlexServerDown,
      'on_intup': instance.onPlexServerUp,
      'on_extdown': instance.onPlexServerRemoteAccessDown,
      'on_extup': instance.onPlexServerRemoteAccessUp,
      'on_pmsupdate': instance.onPlexUpdate,
      'on_plexpyupdate': instance.onTautulliUpdate,
      'on_plexpydbcorrupt': instance.onTautulliDatabaseCorruption,
    };
