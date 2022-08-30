import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'command_body.g.dart';

/// Model for the body for executing a command in Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrCommandBody {
  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'sendUpdatesToClient')
  bool? sendUpdatesToClient;

  @JsonKey(name: 'updateScheduledTask')
  bool? updateScheduledTask;

  @JsonKey(name: 'completionMessage')
  String? completionMessage;

  @JsonKey(name: 'requiresDiskAccess')
  bool? requiresDiskAccess;

  @JsonKey(name: 'isExclusive')
  bool? isExclusive;

  @JsonKey(name: 'isTypeExclusive')
  bool? isTypeExclusive;

  /// Name of the command
  @JsonKey(name: 'name')
  String? name;

  /// Method that triggered the command
  @JsonKey(name: 'trigger')
  String? trigger;

  /// Will messages for this command be suppressed?
  @JsonKey(name: 'suppressMessages')
  bool? suppressMessages;

  RadarrCommandBody({
    this.type,
    this.sendUpdatesToClient,
    this.updateScheduledTask,
    this.completionMessage,
    this.requiresDiskAccess,
    this.isExclusive,
    this.isTypeExclusive,
    this.name,
    this.trigger,
    this.suppressMessages,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrCommandBody] object.
  factory RadarrCommandBody.fromJson(Map<String, dynamic> json) =>
      _$RadarrCommandBodyFromJson(json);

  /// Serialize a [RadarrCommandBody] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrCommandBodyToJson(this);
}
