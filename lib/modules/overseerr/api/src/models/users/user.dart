import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import '../../../utilities.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrUser {
  @JsonKey(name: 'permissions')
  int? permissions;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'plexUsername')
  String? plexUsername;

  @JsonKey(name: 'username')
  String? username;

  @JsonKey(name: 'recoveryLinkExpirationDate')
  String? recoveryLinkExpirationDate;

  @JsonKey(name: 'userType')
  int? userType;

  @JsonKey(name: 'avatar')
  String? avatar;

  @JsonKey(name: 'movieQuotaLimit')
  int? movieQuotaLimit;

  @JsonKey(name: 'movieQuotaDays')
  int? movieQuotaDays;

  @JsonKey(name: 'tvQuotaLimit')
  int? tvQuotaLimit;

  @JsonKey(name: 'tvQuotaDays')
  int? tvQuotaDays;

  @JsonKey(
    name: 'createdAt',
    fromJson: OverseerrUtilities.dateTimeFromJson,
    toJson: OverseerrUtilities.dateTimeToJson,
  )
  DateTime? createdAt;

  @JsonKey(
    name: 'updatedAt',
    fromJson: OverseerrUtilities.dateTimeFromJson,
    toJson: OverseerrUtilities.dateTimeToJson,
  )
  DateTime? updatedAt;

  @JsonKey(name: 'requestCount')
  int? requestCount;

  @JsonKey(name: 'displayName')
  String? displayName;

  OverseerrUser({
    this.permissions,
    this.id,
    this.email,
    this.plexUsername,
    this.username,
    this.recoveryLinkExpirationDate,
    this.userType,
    this.avatar,
    this.movieQuotaLimit,
    this.movieQuotaDays,
    this.tvQuotaLimit,
    this.tvQuotaDays,
    this.createdAt,
    this.updatedAt,
    this.requestCount,
    this.displayName,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [OverseerrUser] object.
  factory OverseerrUser.fromJson(Map<String, dynamic> json) =>
      _$OverseerrUserFromJson(json);

  /// Serialize a [OverseerrUser] object to a JSON map.
  Map<String, dynamic> toJson() => _$OverseerrUserToJson(this);
}
