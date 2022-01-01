import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'server.g.dart';

/// Model to store the Plex Media Server details.
@JsonSerializable(explicitToJson: true)
class TautulliServer {
  /// Is SSL required for this server?
  @JsonKey(
      name: 'httpsRequired', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? httpsRequired;

  /// Is this a local server instance?
  @JsonKey(name: 'local', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? local;

  /// Client identifier key.
  @JsonKey(
      name: 'clientIdentifier',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? clientIdentifier;

  /// Plex Media Server label.
  @JsonKey(name: 'label', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? label;

  /// IP address of the Plex Media Server.
  @JsonKey(name: 'ip', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? ipAddress;

  /// Public port that the Plex Media Server is available on.
  @JsonKey(name: 'port', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? port;

  /// Direct URI to the Plex Media Server.
  @JsonKey(name: 'uri', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? uri;

  /// IP address + port, the value entered in Tautulli.
  @JsonKey(name: 'value', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? value;

  /// Is this a cloud instance of Plex Media Server?
  @JsonKey(name: 'is_cloud', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? isCloud;

  TautulliServer({
    this.httpsRequired,
    this.local,
    this.clientIdentifier,
    this.label,
    this.ipAddress,
    this.port,
    this.uri,
    this.value,
    this.isCloud,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliServer] object.
  factory TautulliServer.fromJson(Map<String, dynamic> json) =>
      _$TautulliServerFromJson(json);

  /// Serialize a [TautulliServer] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliServerToJson(this);
}
