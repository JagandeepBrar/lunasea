import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:tautulli/utilities.dart';

part 'pms_update.g.dart';

/// Model to store update information for Plex Media Server.
@JsonSerializable(explicitToJson: true)
class TautulliPMSUpdate {
    /// Is there an update available?
    @JsonKey(name: 'update_available', fromJson: TautulliUtilities.ensureBooleanFromJson)
    final bool? updateAvailable;

    /// Machine's platform.
    @JsonKey(name: 'platform', fromJson: TautulliUtilities.ensureStringFromJson)
    final String? platform;

    /// The release date of the update.
    @JsonKey(name: 'release_date', fromJson: TautulliUtilities.millisecondsDateTimeFromJson)
    final DateTime? releaseDate;

    /// Full version code of the release.
    @JsonKey(name: 'version', fromJson: TautulliUtilities.ensureStringFromJson)
    final String? version;

    /// List of requirements.
    @JsonKey(name: 'requirements', fromJson: TautulliUtilities.ensureStringFromJson)
    final String? requirements;

    /// Any extra information.
    @JsonKey(name: 'extra_info', fromJson: TautulliUtilities.ensureStringFromJson)
    final String? extraInfo;

    /// List of changes that includes new/added content.
    @JsonKey(name: 'changelog_added', toJson: _releaseNotesToJson, fromJson: _releaseNotesFromJson)
    final List<String>? changelogAdded;

    /// List of changes that includes fixed bugs.
    @JsonKey(name: 'changelog_fixed', toJson: _releaseNotesToJson, fromJson: _releaseNotesFromJson)
    final List<String>? changelogFixed;

    /// Label for the release.
    @JsonKey(name: 'label', fromJson: TautulliUtilities.ensureStringFromJson)
    final String? label;

    /// Distribution for the release.
    @JsonKey(name: 'distro', fromJson: TautulliUtilities.ensureStringFromJson)
    final String? distro;

    /// Build information for the distribution release.
    @JsonKey(name: 'distro_build', fromJson: TautulliUtilities.ensureStringFromJson)
    final String? distroBuild;

    /// URL to download this release.
    @JsonKey(name: 'download_url', fromJson: TautulliUtilities.ensureStringFromJson)
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

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [TautulliPMSUpdate] object.
    factory TautulliPMSUpdate.fromJson(Map<String, dynamic> json) => _$TautulliPMSUpdateFromJson(json);
    /// Serialize a [TautulliPMSUpdate] object to a JSON map.
    Map<String, dynamic> toJson() => _$TautulliPMSUpdateToJson(this);

    static List<String> _releaseNotesFromJson(String notes) => notes.split("\n");
    static String? _releaseNotesToJson(List<String>? notes) => notes?.join("\n");
}
