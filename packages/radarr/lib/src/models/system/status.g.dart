// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrSystemStatus _$RadarrSystemStatusFromJson(Map<String, dynamic> json) {
  return RadarrSystemStatus(
    version: json['version'] as String?,
    buildTime: json['buildTime'] as String?,
    isDebug: json['isDebug'] as bool?,
    isProduction: json['isProduction'] as bool?,
    isAdmin: json['isAdmin'] as bool?,
    isUserInteractive: json['isUserInteractive'] as bool?,
    startupPath: json['startupPath'] as String?,
    appData: json['appData'] as String?,
    osName: json['osName'] as String?,
    osVersion: json['osVersion'] as String?,
    isNetCore: json['isNetCore'] as bool?,
    isMono: json['isMono'] as bool?,
    isLinux: json['isLinux'] as bool?,
    isOsx: json['isOsx'] as bool?,
    isWindows: json['isWindows'] as bool?,
    isDocker: json['isDocker'] as bool?,
    mode: json['mode'] as String?,
    branch: json['branch'] as String?,
    authentication: json['authentication'] as String?,
    sqliteVersion: json['sqliteVersion'] as String?,
    migrationVersion: json['migrationVersion'] as int?,
    urlBase: json['urlBase'] as String?,
    runtimeVersion: json['runtimeVersion'] as String?,
    runtimeName: json['runtimeName'] as String?,
    startTime: json['startTime'] as String?,
    packageVersion: json['packageVersion'] as String?,
    packageAuthor: json['packageAuthor'] as String?,
    packageUpdateMechanism: json['packageUpdateMechanism'] as String?,
  );
}

Map<String, dynamic> _$RadarrSystemStatusToJson(RadarrSystemStatus instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('version', instance.version);
  writeNotNull('buildTime', instance.buildTime);
  writeNotNull('isDebug', instance.isDebug);
  writeNotNull('isProduction', instance.isProduction);
  writeNotNull('isAdmin', instance.isAdmin);
  writeNotNull('isUserInteractive', instance.isUserInteractive);
  writeNotNull('startupPath', instance.startupPath);
  writeNotNull('appData', instance.appData);
  writeNotNull('osName', instance.osName);
  writeNotNull('osVersion', instance.osVersion);
  writeNotNull('isNetCore', instance.isNetCore);
  writeNotNull('isMono', instance.isMono);
  writeNotNull('isLinux', instance.isLinux);
  writeNotNull('isOsx', instance.isOsx);
  writeNotNull('isWindows', instance.isWindows);
  writeNotNull('isDocker', instance.isDocker);
  writeNotNull('mode', instance.mode);
  writeNotNull('branch', instance.branch);
  writeNotNull('authentication', instance.authentication);
  writeNotNull('sqliteVersion', instance.sqliteVersion);
  writeNotNull('migrationVersion', instance.migrationVersion);
  writeNotNull('urlBase', instance.urlBase);
  writeNotNull('runtimeVersion', instance.runtimeVersion);
  writeNotNull('runtimeName', instance.runtimeName);
  writeNotNull('startTime', instance.startTime);
  writeNotNull('packageVersion', instance.packageVersion);
  writeNotNull('packageAuthor', instance.packageAuthor);
  writeNotNull('packageUpdateMechanism', instance.packageUpdateMechanism);
  return val;
}
