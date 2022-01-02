// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_check.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliUpdateCheck _$TautulliUpdateCheckFromJson(Map<String, dynamic> json) {
  return TautulliUpdateCheck(
    update: TautulliUtilities.ensureBooleanFromJson(json['update']),
    release: TautulliUtilities.ensureBooleanFromJson(json['release']),
    currentRelease:
        TautulliUtilities.ensureStringFromJson(json['current_release']),
    latestRelease:
        TautulliUtilities.ensureStringFromJson(json['latest_release']),
    currentVersion:
        TautulliUtilities.ensureStringFromJson(json['current_version']),
    latestVersion:
        TautulliUtilities.ensureStringFromJson(json['latest_version']),
    commitsBehind:
        TautulliUtilities.ensureIntegerFromJson(json['commits_behind']),
    compareUrl: TautulliUtilities.ensureStringFromJson(json['compare_url']),
    releaseUrl: TautulliUtilities.ensureStringFromJson(json['release_url']),
    installType: TautulliUtilities.ensureStringFromJson(json['install_type']),
  );
}

Map<String, dynamic> _$TautulliUpdateCheckToJson(
        TautulliUpdateCheck instance) =>
    <String, dynamic>{
      'update': instance.update,
      'release': instance.release,
      'current_release': instance.currentRelease,
      'latest_release': instance.latestRelease,
      'current_version': instance.currentVersion,
      'latest_version': instance.latestVersion,
      'commits_behind': instance.commitsBehind,
      'compare_url': instance.compareUrl,
      'release_url': instance.releaseUrl,
      'install_type': instance.installType,
    };
