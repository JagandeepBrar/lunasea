import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'command_body.g.dart';

/// Model for the body for executing a command in Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrCommandBody {
    /// Series ID attached to the command (if applicable, else null).
    @JsonKey(name: 'seriesId')
    int? seriesId;

    /// Is this command handling a new series?
    @JsonKey(name: 'isNewSeries')
    bool? isNewSeries;

    /// Type of the command
    @JsonKey(name: 'type')
    String? type;

    /// Will updates be sent to the client for this command?
    @JsonKey(name: 'sendUpdatesToClient')
    bool? sendUpdatesToClient;

    /// Will this command update the scheduled tasks?
    @JsonKey(name: 'updateScheduledTask')
    bool? updateScheduledTask;

    /// Message for completion
    @JsonKey(name: 'completionMessage')
    String? completionMessage;

    /// Does this command require disk access?
    @JsonKey(name: 'requiresDiskAccess')
    bool? requiresDiskAccess;

    /// Does this command need to execute exclusively?
    @JsonKey(name: 'isExclusive')
    bool? isExclusive;

    /// Name of the command
    @JsonKey(name: 'name')
    String? name;

    /// Method that triggered the command
    @JsonKey(name: 'trigger')
    String? trigger;

    /// Will messages for this command be suppressed?
    @JsonKey(name: 'suppressMessages')
    bool? suppressMessages;

    SonarrCommandBody({
        this.seriesId,
        this.isNewSeries,
        this.sendUpdatesToClient,
        this.updateScheduledTask,
        this.completionMessage,
        this.requiresDiskAccess,
        this.isExclusive,
        this.name,
        this.trigger,
        this.suppressMessages,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrCommandBody] object.
    factory SonarrCommandBody.fromJson(Map<String, dynamic> json) => _$SonarrCommandBodyFromJson(json);
    /// Serialize a [SonarrCommandBody] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrCommandBodyToJson(this);
}
