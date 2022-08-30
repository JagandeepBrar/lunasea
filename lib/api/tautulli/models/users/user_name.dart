import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'user_name.g.dart';

/// Model to store a user's name & ID.
@JsonSerializable(explicitToJson: true)
class TautulliUserName {
  /// The user's ID.
  @JsonKey(name: 'user_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? userId;

  /// The user's friendly name.
  @JsonKey(
      name: 'friendly_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? friendlyName;

  TautulliUserName({
    this.userId,
    this.friendlyName,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliUserName] object.
  factory TautulliUserName.fromJson(Map<String, dynamic> json) =>
      _$TautulliUserNameFromJson(json);

  /// Serialize a [TautulliUserName] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliUserNameToJson(this);
}
