import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/types.dart';
import 'package:lunasea/api/radarr/utilities.dart';

part 'health_check.g.dart';

/// Model for health check details from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrHealthCheck {
  @JsonKey(name: 'source')
  String? source;

  @JsonKey(
      name: 'type',
      toJson: RadarrUtilities.healthCheckTypeToJson,
      fromJson: RadarrUtilities.healthCheckTypeFromJson)
  RadarrHealthCheckType? type;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'wikiUrl')
  String? wikiUrl;

  RadarrHealthCheck({
    this.source,
    this.type,
    this.message,
    this.wikiUrl,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrHealthCheck] object.
  factory RadarrHealthCheck.fromJson(Map<String, dynamic> json) =>
      _$RadarrHealthCheckFromJson(json);

  /// Serialize a [RadarrHealthCheck] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrHealthCheckToJson(this);
}
