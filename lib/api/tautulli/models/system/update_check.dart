import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'update_check.g.dart';

/// Model to store update information for Tautulli.
@JsonSerializable(explicitToJson: true)
class TautulliUpdateCheck {
  /// Is there an update available?
  @JsonKey(name: 'update', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? update;

  /// If there is an update, is it a release version?
  @JsonKey(name: 'release', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? release;

  /// The current installed release.
  @JsonKey(
      name: 'current_release', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? currentRelease;

  /// The latest release available.
  @JsonKey(
      name: 'latest_release', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? latestRelease;

  /// The current installed version.
  @JsonKey(
      name: 'current_version', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? currentVersion;

  /// The latest version available.
  @JsonKey(
      name: 'latest_version', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? latestVersion;

  /// (git track only) How many commits the current version is behind the latest.
  @JsonKey(
      name: 'commits_behind', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? commitsBehind;

  /// (git track only) URL to compare changes between versions.
  @JsonKey(
      name: 'compare_url', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? compareUrl;

  /// URL for the latest release.
  @JsonKey(
      name: 'release_url', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? releaseUrl;

  /// The type of installation (git, docker, etc.)
  @JsonKey(
      name: 'install_type', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? installType;

  TautulliUpdateCheck({
    this.update,
    this.release,
    this.currentRelease,
    this.latestRelease,
    this.currentVersion,
    this.latestVersion,
    this.commitsBehind,
    this.compareUrl,
    this.releaseUrl,
    this.installType,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliUpdateCheck] object.
  factory TautulliUpdateCheck.fromJson(Map<String, dynamic> json) =>
      _$TautulliUpdateCheckFromJson(json);

  /// Serialize a [TautulliUpdateCheck] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliUpdateCheckToJson(this);
}
