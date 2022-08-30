import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'notifier_config.g.dart';

/// Model to store information about a Tautulli notifier configuration.
@JsonSerializable(explicitToJson: true)
class TautulliNotifierConfig {
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

  /// Custom conditions for the notifier.
  @JsonKey(name: 'custom_conditions')
  final List<Map<String, dynamic>>? customConditions;

  /// Custom conditions logic when evaluating conditions.
  @JsonKey(
      name: 'custom_conditions_logic',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? customConditionsLogic;

  /// Configuration for the notifier.
  @JsonKey(name: 'config')
  final Map<String, dynamic>? config;

  /// Configuration options for the notifier.
  @JsonKey(name: 'config_options')
  final List<Map<String, dynamic>>? configOptions;

  /// List of actions for the notifier.
  @JsonKey(name: 'actions', toJson: _optionsToJson, fromJson: _optionsFromJson)
  final TautulliNotifierConfigActions? actions;

  /// Notifier text messages for each action.
  ///
  /// Each key in the map is an action, with each action containing:
  /// - `subject`: String text, the subject of the message.
  /// - `body`: String text, the body of the message.
  @JsonKey(name: 'notify_text')
  final Map<String, dynamic>? notifyText;

  TautulliNotifierConfig({
    this.id,
    this.agentId,
    this.agentName,
    this.agentLabel,
    this.friendlyName,
    this.customConditions,
    this.customConditionsLogic,
    this.config,
    this.configOptions,
    this.actions,
    this.notifyText,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliNotifierConfig] object.
  factory TautulliNotifierConfig.fromJson(Map<String, dynamic> json) =>
      _$TautulliNotifierConfigFromJson(json);

  /// Serialize a [TautulliNotifierConfig] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliNotifierConfigToJson(this);

  static TautulliNotifierConfigActions _optionsFromJson(
          Map<String, dynamic> json) =>
      TautulliNotifierConfigActions.fromJson(json);
  static Map<String, dynamic>? _optionsToJson(
          TautulliNotifierConfigActions? options) =>
      options?.toJson();
}
