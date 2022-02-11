import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/readarr.dart';

part 'status.g.dart';

/// Model for the system status from Readarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrStatus {
  /// Readarr version
  @JsonKey(name: 'version')
  String? version;

  /// [DateTime] object representing the build time
  @JsonKey(
      name: 'buildTime',
      fromJson: ReadarrUtilities.dateTimeFromJson,
      toJson: ReadarrUtilities.dateTimeToJson)
  DateTime? buildTime;

  /// Is debug version?
  @JsonKey(name: 'isDebug')
  bool? isDebug;

  /// Is production version?
  @JsonKey(name: 'isProduction')
  bool? isProduction;

  /// Is admin?
  @JsonKey(name: 'isAdmin')
  bool? isAdmin;

  /// Is user interactive?
  @JsonKey(name: 'isUserInteractive')
  bool? isUserInteractive;

  /// Startup path on system
  @JsonKey(name: 'startupPath')
  String? startupPath;

  /// App data location
  @JsonKey(name: 'appData')
  String? appData;

  /// Name of the operating system
  @JsonKey(name: 'osName')
  String? osName;

  /// Version of the operating system
  @JsonKey(name: 'osVersion')
  String? osVersion;

  /// Is Readarr using the mono runtime?
  @JsonKey(name: 'isMonoRuntime')
  bool? isMonoRuntime;

  /// Is Readarr using mono?
  @JsonKey(name: 'isMono')
  bool? isMono;

  /// Is Readarr running on Linux?
  @JsonKey(name: 'isLinux')
  bool? isLinux;

  /// Is Readarr running on MacOS?
  @JsonKey(name: 'isOsx')
  bool? isOsx;

  /// Is Readarr running on Windows?
  @JsonKey(name: 'isWindows')
  bool? isWindows;

  /// GitHub branch of the version
  @JsonKey(name: 'branch')
  String? branch;

  /// Type of authentication enabled
  @JsonKey(name: 'authentication')
  String? authentication;

  /// Version of SQLite
  @JsonKey(name: 'sqliteVersion')
  String? sqliteVersion;

  /// URL-base of the instance
  @JsonKey(name: 'urlBase')
  String? urlBase;

  /// Version of the runtime
  @JsonKey(name: 'runtimeVersion')
  String? runtimeVersion;

  /// Name of the runtime
  @JsonKey(name: 'runtimeName')
  String? runtimeName;

  ReadarrStatus({
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
    this.isMonoRuntime,
    this.isMono,
    this.isLinux,
    this.isOsx,
    this.isWindows,
    this.branch,
    this.authentication,
    this.sqliteVersion,
    this.urlBase,
    this.runtimeVersion,
    this.runtimeName,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [ReadarrStatus] object.
  factory ReadarrStatus.fromJson(Map<String, dynamic> json) =>
      _$ReadarrStatusFromJson(json);

  /// Serialize a [ReadarrStatus] object to a JSON map.
  Map<String, dynamic> toJson() => _$ReadarrStatusToJson(this);
}
