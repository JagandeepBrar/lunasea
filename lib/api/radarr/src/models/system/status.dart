import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

/// Model for the system status from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrSystemStatus {
  @JsonKey(name: 'version')
  String? version;

  @JsonKey(name: 'buildTime')
  String? buildTime;

  @JsonKey(name: 'isDebug')
  bool? isDebug;

  @JsonKey(name: 'isProduction')
  bool? isProduction;

  @JsonKey(name: 'isAdmin')
  bool? isAdmin;

  @JsonKey(name: 'isUserInteractive')
  bool? isUserInteractive;

  @JsonKey(name: 'startupPath')
  String? startupPath;

  @JsonKey(name: 'appData')
  String? appData;

  @JsonKey(name: 'osName')
  String? osName;

  @JsonKey(name: 'osVersion')
  String? osVersion;

  @JsonKey(name: 'isNetCore')
  bool? isNetCore;

  @JsonKey(name: 'isMono')
  bool? isMono;

  @JsonKey(name: 'isLinux')
  bool? isLinux;

  @JsonKey(name: 'isOsx')
  bool? isOsx;

  @JsonKey(name: 'isWindows')
  bool? isWindows;

  @JsonKey(name: 'isDocker')
  bool? isDocker;

  @JsonKey(name: 'mode')
  String? mode;

  @JsonKey(name: 'branch')
  String? branch;

  @JsonKey(name: 'authentication')
  String? authentication;

  @JsonKey(name: 'sqliteVersion')
  String? sqliteVersion;

  @JsonKey(name: 'migrationVersion')
  int? migrationVersion;

  @JsonKey(name: 'urlBase')
  String? urlBase;

  @JsonKey(name: 'runtimeVersion')
  String? runtimeVersion;

  @JsonKey(name: 'runtimeName')
  String? runtimeName;

  @JsonKey(name: 'startTime')
  String? startTime;

  @JsonKey(name: 'packageVersion')
  String? packageVersion;

  @JsonKey(name: 'packageAuthor')
  String? packageAuthor;

  @JsonKey(name: 'packageUpdateMechanism')
  String? packageUpdateMechanism;

  RadarrSystemStatus({
    this.version,
    this.buildTime,
    this.isDebug,
    this.isProduction,
    this.isAdmin,
    this.isUserInteractive,
    this.startupPath,
    this.appData,
    this.osName,
    this.osVersion,
    this.isNetCore,
    this.isMono,
    this.isLinux,
    this.isOsx,
    this.isWindows,
    this.isDocker,
    this.mode,
    this.branch,
    this.authentication,
    this.sqliteVersion,
    this.migrationVersion,
    this.urlBase,
    this.runtimeVersion,
    this.runtimeName,
    this.startTime,
    this.packageVersion,
    this.packageAuthor,
    this.packageUpdateMechanism,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrSystemStatus] object.
  factory RadarrSystemStatus.fromJson(Map<String, dynamic> json) =>
      _$RadarrSystemStatusFromJson(json);

  /// Serialize a [RadarrSystemStatus] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrSystemStatusToJson(this);
}
