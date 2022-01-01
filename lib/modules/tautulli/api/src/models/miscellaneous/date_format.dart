import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'date_format.g.dart';

/// Model to store the date and time formats.
@JsonSerializable(explicitToJson: true)
class TautulliDateFormat {
  /// Date format.
  @JsonKey(
      name: 'date_format', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? dateFormat;

  /// Time format.
  @JsonKey(
      name: 'time_format', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? timeFormat;

  TautulliDateFormat({
    this.dateFormat,
    this.timeFormat,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliDateFormat] object.
  factory TautulliDateFormat.fromJson(Map<String, dynamic> json) =>
      _$TautulliDateFormatFromJson(json);

  /// Serialize a [TautulliDateFormat] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliDateFormatToJson(this);
}
