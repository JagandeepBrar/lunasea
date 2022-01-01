import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'server_identity.g.dart';

/// Model to store the Plex server identity used in Tautulli.
@JsonSerializable(explicitToJson: true)
class TautulliServerIdentity {
  /// The machine identifier key.
  @JsonKey(
      name: 'machine_identifier',
      fromJson: TautulliUtilities.ensureStringFromJson)
  final String? machineIdentifier;

  /// The Plex Media Server version currently installed.
  @JsonKey(name: 'version', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? version;

  TautulliServerIdentity({
    this.machineIdentifier,
    this.version,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliServerIdentity] object.
  factory TautulliServerIdentity.fromJson(Map<String, dynamic> json) =>
      _$TautulliServerIdentityFromJson(json);

  /// Serialize a [TautulliServerIdentity] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliServerIdentityToJson(this);
}
