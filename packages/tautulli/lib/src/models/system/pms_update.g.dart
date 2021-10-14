// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pms_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliPMSUpdate _$TautulliPMSUpdateFromJson(Map<String, dynamic> json) {
  return TautulliPMSUpdate(
    updateAvailable:
        TautulliUtilities.ensureBooleanFromJson(json['update_available']),
    platform: TautulliUtilities.ensureStringFromJson(json['platform']),
    releaseDate:
        TautulliUtilities.millisecondsDateTimeFromJson(json['release_date']),
    version: TautulliUtilities.ensureStringFromJson(json['version']),
    requirements: TautulliUtilities.ensureStringFromJson(json['requirements']),
    extraInfo: TautulliUtilities.ensureStringFromJson(json['extra_info']),
    changelogAdded: TautulliPMSUpdate._releaseNotesFromJson(
        json['changelog_added'] as String),
    changelogFixed: TautulliPMSUpdate._releaseNotesFromJson(
        json['changelog_fixed'] as String),
    label: TautulliUtilities.ensureStringFromJson(json['label']),
    distro: TautulliUtilities.ensureStringFromJson(json['distro']),
    distroBuild: TautulliUtilities.ensureStringFromJson(json['distro_build']),
    downloadUrl: TautulliUtilities.ensureStringFromJson(json['download_url']),
  );
}

Map<String, dynamic> _$TautulliPMSUpdateToJson(TautulliPMSUpdate instance) =>
    <String, dynamic>{
      'update_available': instance.updateAvailable,
      'platform': instance.platform,
      'release_date': instance.releaseDate?.toIso8601String(),
      'version': instance.version,
      'requirements': instance.requirements,
      'extra_info': instance.extraInfo,
      'changelog_added':
          TautulliPMSUpdate._releaseNotesToJson(instance.changelogAdded),
      'changelog_fixed':
          TautulliPMSUpdate._releaseNotesToJson(instance.changelogFixed),
      'label': instance.label,
      'distro': instance.distro,
      'distro_build': instance.distroBuild,
      'download_url': instance.downloadUrl,
    };
