import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'manual_import_rejection.g.dart';

/// Model for an manual import rejection reason.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrManualImportRejection {
  @JsonKey(name: 'reason')
  String? reason;

  @JsonKey(name: 'type')
  String? type;

  RadarrManualImportRejection({
    this.reason,
    this.type,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrManualImportRejection] object.
  factory RadarrManualImportRejection.fromJson(Map<String, dynamic> json) =>
      _$RadarrManualImportRejectionFromJson(json);

  /// Serialize a [RadarrManualImportRejection] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrManualImportRejectionToJson(this);
}
