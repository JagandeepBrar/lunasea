import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'newsletter.g.dart';

/// Model to store information about a Tautulli newsletter.
@JsonSerializable(explicitToJson: true)
class TautulliNewsletter {
  /// newsletter ID.
  @JsonKey(name: 'id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? id;

  /// newsletter agent ID.
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

  /// The Crontab schedule.
  @JsonKey(name: 'cron', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? cron;

  /// Is the newsletter active/enabled?
  @JsonKey(name: 'active', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? active;

  TautulliNewsletter({
    this.id,
    this.agentId,
    this.agentName,
    this.agentLabel,
    this.friendlyName,
    this.cron,
    this.active,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliNewsletter] object.
  factory TautulliNewsletter.fromJson(Map<String, dynamic> json) =>
      _$TautulliNewsletterFromJson(json);

  /// Serialize a [TautulliNewsletter] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliNewsletterToJson(this);
}
