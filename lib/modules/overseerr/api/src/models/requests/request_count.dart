import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'request_count.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrRequestCount {
  @JsonKey(name: 'pending')
  int? pending;

  @JsonKey(name: 'approved')
  int? approved;

  @JsonKey(name: 'processing')
  int? processing;

  @JsonKey(name: 'available')
  int? available;

  OverseerrRequestCount({
    this.pending,
    this.approved,
    this.processing,
    this.available,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [OverseerrRequestCount] object.
  factory OverseerrRequestCount.fromJson(Map<String, dynamic> json) =>
      _$OverseerrRequestCountFromJson(json);

  /// Serialize a [OverseerrRequestCount] object to a JSON map.
  Map<String, dynamic> toJson() => _$OverseerrRequestCountToJson(this);
}
