import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'user_login_record.g.dart';

/// Model to store a single user login information.
@JsonSerializable(explicitToJson: true)
class TautulliUserLoginRecord {
  /// Timestamp of the login.
  @JsonKey(
      name: 'timestamp',
      fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
  final DateTime? timestamp;

  /// The user's ID.
  @JsonKey(name: 'user_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? userId;

  /// What group the user is apart of.
  @JsonKey(
      name: 'user_group',
      toJson: TautulliUtilities.userGroupToJson,
      fromJson: TautulliUtilities.userGroupFromJson)
  final TautulliUserGroup? userGroup;

  /// Originating IP address of the login record.
  @JsonKey(name: 'ip_address', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? ipAddress;

  /// Host of the login record.
  @JsonKey(name: 'host', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? host;

  /// User agent of the device used to login.
  @JsonKey(name: 'user_agent', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? userAgent;

  /// Operating system of the login device.
  @JsonKey(name: 'os', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? os;

  /// Browser used on the login device.
  @JsonKey(name: 'browser', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? browser;

  /// Was the login successful?
  @JsonKey(name: 'success', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? success;

  /// Friendly name of the user.
  @JsonKey(
      name: 'friendly_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? friendlyName;

  TautulliUserLoginRecord({
    this.timestamp,
    this.userId,
    this.userGroup,
    this.ipAddress,
    this.host,
    this.userAgent,
    this.os,
    this.browser,
    this.success,
    this.friendlyName,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliUserLoginRecord] object.
  factory TautulliUserLoginRecord.fromJson(Map<String, dynamic> json) =>
      _$TautulliUserLoginRecordFromJson(json);

  /// Serialize a [TautulliUserLoginRecord] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliUserLoginRecordToJson(this);
}
