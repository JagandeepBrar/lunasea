import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'server_info.g.dart';

/// Model to store the Plex server information used in Tautulli.
@JsonSerializable(explicitToJson: true)
class TautulliServerInfo {
  /// The server name.
  @JsonKey(name: 'name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? name;

  /// The machine identifier key.
  @JsonKey(
      name: 'machine_identifier',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? machineIdentifier;

  /// The Plex Media Server version currently installed.
  @JsonKey(name: 'version', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? version;

  /// The host/IP address of the Plex Media Server.
  @JsonKey(name: 'host', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? host;

  /// The public port that the Plex Media Server is available on.
  @JsonKey(name: 'port', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? port;

  TautulliServerInfo({
    this.name,
    this.machineIdentifier,
    this.host,
    this.port,
    this.version,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliServerInfo] object.
  factory TautulliServerInfo.fromJson(Map<String, dynamic> json) =>
      _$TautulliServerInfoFromJson(json);

  /// Serialize a [TautulliServerInfo] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliServerInfoToJson(this);
}
