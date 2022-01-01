// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrStatus _$SonarrStatusFromJson(Map<String, dynamic> json) => SonarrStatus(
      version: json['version'] as String?,
      buildTime: SonarrUtilities.dateTimeFromJson(json['buildTime'] as String?),
      isDebug: json['isDebug'] as bool?,
      isProduction: json['isProduction'] as bool?,
      isAdmin: json['isAdmin'] as bool?,
      isUserInteractive: json['isUserInteractive'] as bool?,
      startupPath: json['startupPath'] as String?,
      appData: json['appData'] as String?,
      osName: json['osName'] as String?,
      osVersion: json['osVersion'] as String?,
      isMonoRuntime: json['isMonoRuntime'] as bool?,
      isMono: json['isMono'] as bool?,
      isLinux: json['isLinux'] as bool?,
      isOsx: json['isOsx'] as bool?,
      isWindows: json['isWindows'] as bool?,
      branch: json['branch'] as String?,
      authentication: json['authentication'] as String?,
      sqliteVersion: json['sqliteVersion'] as String?,
      urlBase: json['urlBase'] as String?,
      runtimeVersion: json['runtimeVersion'] as String?,
      runtimeName: json['runtimeName'] as String?,
    );

Map<String, dynamic> _$SonarrStatusToJson(SonarrStatus instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('version', instance.version);
  writeNotNull('buildTime', SonarrUtilities.dateTimeToJson(instance.buildTime));
  writeNotNull('isDebug', instance.isDebug);
  writeNotNull('isProduction', instance.isProduction);
  writeNotNull('isAdmin', instance.isAdmin);
  writeNotNull('isUserInteractive', instance.isUserInteractive);
  writeNotNull('startupPath', instance.startupPath);
  writeNotNull('appData', instance.appData);
  writeNotNull('osName', instance.osName);
  writeNotNull('osVersion', instance.osVersion);
  writeNotNull('isMonoRuntime', instance.isMonoRuntime);
  writeNotNull('isMono', instance.isMono);
  writeNotNull('isLinux', instance.isLinux);
  writeNotNull('isOsx', instance.isOsx);
  writeNotNull('isWindows', instance.isWindows);
  writeNotNull('branch', instance.branch);
  writeNotNull('authentication', instance.authentication);
  writeNotNull('sqliteVersion', instance.sqliteVersion);
  writeNotNull('urlBase', instance.urlBase);
  writeNotNull('runtimeVersion', instance.runtimeVersion);
  writeNotNull('runtimeName', instance.runtimeName);
  return val;
}
