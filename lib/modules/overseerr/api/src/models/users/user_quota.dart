import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import '../quota.dart';

part 'user_quota.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrUserQuota {
  @JsonKey(name: 'movie')
  OverseerrQuota? movie;

  @JsonKey(name: 'tv')
  OverseerrQuota? tv;

  OverseerrUserQuota({
    this.movie,
    this.tv,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [OverseerrUserQuota] object.
  factory OverseerrUserQuota.fromJson(Map<String, dynamic> json) =>
      _$OverseerrUserQuotaFromJson(json);

  /// Serialize a [OverseerrUserQuota] object to a JSON map.
  Map<String, dynamic> toJson() => _$OverseerrUserQuotaToJson(this);
}
