import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'notifier_parameter.g.dart';

/// Model to store information about a Tautulli notifier parameters.
@JsonSerializable(explicitToJson: true)
class TautulliNotifierParameter {
  /// Name of the notifier parameter.
  @JsonKey(name: 'name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? name;

  /// The type of data stored in this parameter.
  @JsonKey(name: 'type', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? type;

  /// The key to the notifier parameter.
  @JsonKey(name: 'value', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? value;

  TautulliNotifierParameter({
    this.name,
    this.type,
    this.value,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliNotifierParameter] objecParametert.
  factory TautulliNotifierParameter.fromJson(Map<String, dynamic> json) =>
      _$TautulliNotifierParameterFromJson(json);

  /// Serialize a [TautulliNotifierParameter] object to a JSON maParameterp.
  Map<String, dynamic> toJson() => _$TautulliNotifierParameterToJson(this);
}
