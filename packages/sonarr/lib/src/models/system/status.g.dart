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

Map<String, dynamic> _$SonarrStatusToJson(SonarrStatus instance) =>
    <String, dynamic>{
      'version': instance.version,
      'buildTime': SonarrUtilities.dateTimeToJson(instance.buildTime),
      'isDebug': instance.isDebug,
      'isProduction': instance.isProduction,
      'isAdmin': instance.isAdmin,
      'isUserInteractive': instance.isUserInteractive,
      'startupPath': instance.startupPath,
      'appData': instance.appData,
      'osName': instance.osName,
      'osVersion': instance.osVersion,
      'isMonoRuntime': instance.isMonoRuntime,
      'isMono': instance.isMono,
      'isLinux': instance.isLinux,
      'isOsx': instance.isOsx,
      'isWindows': instance.isWindows,
      'branch': instance.branch,
      'authentication': instance.authentication,
      'sqliteVersion': instance.sqliteVersion,
      'urlBase': instance.urlBase,
      'runtimeVersion': instance.runtimeVersion,
      'runtimeName': instance.runtimeName,
    };
