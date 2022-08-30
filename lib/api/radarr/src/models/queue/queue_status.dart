import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'queue_status.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrQueueStatus {
  @JsonKey(name: 'totalCount')
  int? totalCount;

  @JsonKey(name: 'count')
  int? count;

  @JsonKey(name: 'unknownCount')
  int? unknownCount;

  @JsonKey(name: 'errors')
  bool? errors;

  @JsonKey(name: 'warnings')
  bool? warnings;

  @JsonKey(name: 'unknownErrors')
  bool? unknownErrors;

  @JsonKey(name: 'unknownWarnings')
  bool? unknownWarnings;

  RadarrQueueStatus({
    this.totalCount,
    this.count,
    this.unknownCount,
    this.errors,
    this.warnings,
    this.unknownErrors,
    this.unknownWarnings,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrQueueStatus] object.
  factory RadarrQueueStatus.fromJson(Map<String, dynamic> json) =>
      _$RadarrQueueStatusFromJson(json);

  /// Serialize a [RadarrQueueStatus] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrQueueStatusToJson(this);
}
