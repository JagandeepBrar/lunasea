import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/readarr.dart';

part 'command.g.dart';

/// Model for the response for executing a command in Readarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrCommand {
  /// Name of the command
  @JsonKey(name: 'name')
  String? name;

  /// Current message of the command
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'body')
  ReadarrCommandBody? body;

  /// Priority of the command
  @JsonKey(name: 'priority')
  String? priority;

  /// Current status of the command
  @JsonKey(name: 'status')
  String? status;

  /// [DateTime] that the command was queued
  @JsonKey(
      name: 'queued',
      toJson: ReadarrUtilities.dateTimeToJson,
      fromJson: ReadarrUtilities.dateTimeFromJson)
  DateTime? queued;

  /// [DateTime] that the command was started
  @JsonKey(
      name: 'started',
      toJson: ReadarrUtilities.dateTimeToJson,
      fromJson: ReadarrUtilities.dateTimeFromJson)
  DateTime? started;

  /// Method that triggered the command
  @JsonKey(name: 'trigger')
  String? trigger;

  /// Current state of the command
  @JsonKey(name: 'state')
  String? state;

  /// Was this command manually executed?
  @JsonKey(name: 'manual')
  bool? manual;

  /// [DateTime] that the command was started on
  @JsonKey(
      name: 'startedOn',
      toJson: ReadarrUtilities.dateTimeToJson,
      fromJson: ReadarrUtilities.dateTimeFromJson)
  DateTime? startedOn;

  /// [DateTime] that the command state was changed at
  @JsonKey(
      name: 'stateChangeTime',
      toJson: ReadarrUtilities.dateTimeToJson,
      fromJson: ReadarrUtilities.dateTimeFromJson)
  DateTime? stateChangeTime;

  /// Will updates be sent to the client for this command?
  @JsonKey(name: 'sendUpdatesToClient')
  bool? sendUpdatesToClient;

  /// Will this command update the scheduled tasks?
  @JsonKey(name: 'updateScheduledTask')
  bool? updateScheduledTask;

  /// Identifier of command instance
  @JsonKey(name: 'id')
  int? id;

  ReadarrCommand({
    this.name,
    this.body,
    this.priority,
    this.status,
    this.queued,
    this.trigger,
    this.state,
    this.manual,
    this.startedOn,
    this.sendUpdatesToClient,
    this.updateScheduledTask,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [ReadarrCommand] object.
  factory ReadarrCommand.fromJson(Map<String, dynamic> json) =>
      _$ReadarrCommandFromJson(json);

  /// Serialize a [ReadarrCommand] object to a JSON map.
  Map<String, dynamic> toJson() => _$ReadarrCommandToJson(this);
}
