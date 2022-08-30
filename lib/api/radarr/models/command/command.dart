import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/utilities.dart';
import 'package:lunasea/api/radarr/models/command/command_body.dart';

part 'command.g.dart';

/// Model for the response for executing a command in Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrCommand {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'commandName')
  String? commandName;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'body')
  RadarrCommandBody? body;

  @JsonKey(name: 'priority')
  String? priority;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(
      name: 'queued',
      toJson: RadarrUtilities.dateTimeToJson,
      fromJson: RadarrUtilities.dateTimeFromJson)
  DateTime? queued;

  @JsonKey(
      name: 'started',
      toJson: RadarrUtilities.dateTimeToJson,
      fromJson: RadarrUtilities.dateTimeFromJson)
  DateTime? started;

  @JsonKey(
      name: 'ended',
      toJson: RadarrUtilities.dateTimeToJson,
      fromJson: RadarrUtilities.dateTimeFromJson)
  DateTime? ended;

  @JsonKey(name: 'trigger')
  String? trigger;

  @JsonKey(
      name: 'stateChangeTime',
      toJson: RadarrUtilities.dateTimeToJson,
      fromJson: RadarrUtilities.dateTimeFromJson)
  DateTime? stateChangeTime;

  @JsonKey(name: 'sendUpdatesToClient')
  bool? sendUpdatesToClient;

  @JsonKey(name: 'updateScheduledTask')
  bool? updateScheduledTask;

  @JsonKey(
      name: 'lastExecutionTime',
      toJson: RadarrUtilities.dateTimeToJson,
      fromJson: RadarrUtilities.dateTimeFromJson)
  DateTime? lastExecutionTime;

  @JsonKey(name: 'id')
  int? id;

  RadarrCommand({
    this.name,
    this.commandName,
    this.message,
    this.body,
    this.priority,
    this.status,
    this.queued,
    this.started,
    this.ended,
    this.trigger,
    this.stateChangeTime,
    this.sendUpdatesToClient,
    this.updateScheduledTask,
    this.lastExecutionTime,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrCommand] object.
  factory RadarrCommand.fromJson(Map<String, dynamic> json) =>
      _$RadarrCommandFromJson(json);

  /// Serialize a [RadarrCommand] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrCommandToJson(this);
}
