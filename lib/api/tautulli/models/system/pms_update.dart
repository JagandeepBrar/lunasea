import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'pms_update.g.dart';

@JsonSerializable(explicitToJson: true)
class TautulliPMSUpdate {
  @JsonKey(
    name: 'update_available',
    fromJson: TautulliUtilities.ensureBooleanFromJson,
  )
  final bool? updateAvailable;

  @JsonKey(
    name: 'platform',
    fromJson: TautulliUtilities.ensureStringFromJson,
  )
  final String? platform;

  @JsonKey(
    name: 'release_date',
    fromJson: TautulliUtilities.millisecondsDateTimeFromJson,
  )
  final DateTime? releaseDate;

  @JsonKey(
    name: 'version',
    fromJson: TautulliUtilities.ensureStringFromJson,
  )
  final String? version;

  @JsonKey(
    name: 'requirements',
    fromJson: TautulliUtilities.ensureStringFromJson,
  )
  final String? requirements;

  @JsonKey(
    name: 'extra_info',
    fromJson: TautulliUtilities.ensureStringFromJson,
  )
  final String? extraInfo;

  @JsonKey(
    name: 'changelog_added',
    toJson: _releaseNotesToJson,
    fromJson: _releaseNotesFromJson,
  )
  final List<String>? changelogAdded;

  @JsonKey(
    name: 'changelog_fixed',
    toJson: _releaseNotesToJson,
    fromJson: _releaseNotesFromJson,
  )
  final List<String>? changelogFixed;

  @JsonKey(
    name: 'label',
    fromJson: TautulliUtilities.ensureStringFromJson,
  )
  final String? label;

  @JsonKey(
    name: 'distro',
    fromJson: TautulliUtilities.ensureStringFromJson,
  )
  final String? distro;

  @JsonKey(
    name: 'distro_build',
    fromJson: TautulliUtilities.ensureStringFromJson,
  )
  final String? distroBuild;

  @JsonKey(
    name: 'download_url',
    fromJson: TautulliUtilities.ensureStringFromJson,
  )
  final String? downloadUrl;

  TautulliPMSUpdate({
    this.updateAvailable,
    this.platform,
    this.releaseDate,
    this.version,
    this.requirements,
    this.extraInfo,
    this.changelogAdded,
    this.changelogFixed,
    this.label,
    this.distro,
    this.distroBuild,
    this.downloadUrl,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory TautulliPMSUpdate.fromJson(Map<String, dynamic> json) =>
      _$TautulliPMSUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$TautulliPMSUpdateToJson(this);

  static List<String>? _releaseNotesFromJson(String? notes) =>
      notes?.split("\n") ?? [];
  static String? _releaseNotesToJson(List<String>? notes) =>
      notes?.join("\n") ?? '';
}
