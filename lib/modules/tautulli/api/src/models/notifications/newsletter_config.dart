import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'newsletter_config.g.dart';

/// Model to store information about a Tautulli newsletter configuration.
@JsonSerializable(explicitToJson: true)
class TautulliNewsletterConfig {
  /// Newsletter ID.
  @JsonKey(name: 'id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? id;

  /// Newsletter ID name.
  @JsonKey(name: 'id_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? idName;

  /// Newsletter agent ID.
  @JsonKey(name: 'agent_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? agentId;

  /// Name of the newsletter agent.
  @JsonKey(name: 'agent_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? agentName;

  /// Label of the newsletter agent.
  @JsonKey(
      name: 'agent_label', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? agentLabel;

  /// Friendly name (description) of the newsletter.
  @JsonKey(
      name: 'friendly_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? friendlyName;

  /// Cron schedule.
  @JsonKey(name: 'cron', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? cron;

  /// Is the newsletter active?
  @JsonKey(name: 'active', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? active;

  /// Subject of the newsletter.
  @JsonKey(name: 'subject', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? subject;

  /// Body of the newsletter.
  @JsonKey(name: 'body', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? body;

  /// Message of the newsletter.
  @JsonKey(name: 'message', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? message;

  /// Configuration for the newsletter.
  @JsonKey(name: 'config')
  final Map<String, dynamic>? config;

  /// Configuration options for the newsletter.
  @JsonKey(name: 'config_options')
  final List<Map<String, dynamic>>? configOptions;

  /// Email configuration for the newsletter.
  @JsonKey(name: 'email_config')
  final Map<String, dynamic>? emailConfig;

  /// Email configuration options for the newsletter.
  @JsonKey(name: 'email_config_options')
  final List<Map<String, dynamic>>? emailConfigOptions;

  TautulliNewsletterConfig({
    this.id,
    this.idName,
    this.agentId,
    this.agentName,
    this.agentLabel,
    this.friendlyName,
    this.cron,
    this.active,
    this.body,
    this.subject,
    this.message,
    this.config,
    this.configOptions,
    this.emailConfig,
    this.emailConfigOptions,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliNewsletterConfig] object.
  factory TautulliNewsletterConfig.fromJson(Map<String, dynamic> json) =>
      _$TautulliNewsletterConfigFromJson(json);

  /// Serialize a [TautulliNewsletterConfig] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliNewsletterConfigToJson(this);
}
