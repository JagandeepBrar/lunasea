import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'notifier.g.dart';

/// Model to store information about a Tautulli notifier.
@JsonSerializable(explicitToJson: true)
class TautulliNotifier {
  /// Notifier ID.
  @JsonKey(name: 'id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? id;

  /// Notifier agent ID.
  @JsonKey(name: 'agent_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? agentId;

  /// Name of the notifier agent.
  @JsonKey(name: 'agent_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? agentName;

  /// Label of the notifier agent.
  @JsonKey(
      name: 'agent_label', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? agentLabel;

  /// Friendly name (description) of the notifier.
  @JsonKey(
      name: 'friendly_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? friendlyName;

  /// Is the notifier active/enabled?
  @JsonKey(name: 'active', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? active;

  TautulliNotifier({
    this.id,
    this.agentId,
    this.agentName,
    this.agentLabel,
    this.friendlyName,
    this.active,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliNotifier] object.
  factory TautulliNotifier.fromJson(Map<String, dynamic> json) =>
      _$TautulliNotifierFromJson(json);

  /// Serialize a [TautulliNotifier] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliNotifierToJson(this);
}
