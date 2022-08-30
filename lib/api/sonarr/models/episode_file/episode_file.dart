import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'episode_file.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrEpisodeFile {
  @JsonKey(name: 'seriesId')
  int? seriesId;

  @JsonKey(name: 'seasonNumber')
  int? seasonNumber;

  @JsonKey(name: 'relativePath')
  String? relativePath;

  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'size')
  int? size;

  @JsonKey(
    name: 'dateAdded',
    fromJson: SonarrUtilities.dateTimeFromJson,
    toJson: SonarrUtilities.dateTimeToJson,
  )
  DateTime? dateAdded;

  @JsonKey(name: 'sceneName')
  String? sceneName;

  @JsonKey(name: 'releaseGroup')
  String? releaseGroup;

  @JsonKey(name: 'language')
  SonarrEpisodeFileLanguage? language;

  @JsonKey(name: 'quality')
  SonarrEpisodeFileQuality? quality;

  @JsonKey(name: 'mediaInfo')
  SonarrEpisodeFileMediaInfo? mediaInfo;

  @JsonKey(name: 'qualityCutoffNotMet')
  bool? qualityCutoffNotMet;

  @JsonKey(name: 'languageCutoffNotMet')
  bool? languageCutoffNotMet;

  @JsonKey(name: 'id')
  int? id;

  SonarrEpisodeFile({
    this.seriesId,
    this.seasonNumber,
    this.relativePath,
    this.path,
    this.size,
    this.dateAdded,
    this.sceneName,
    this.releaseGroup,
    this.language,
    this.quality,
    this.mediaInfo,
    this.qualityCutoffNotMet,
    this.languageCutoffNotMet,
    this.id,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrEpisodeFile.fromJson(Map<String, dynamic> json) =>
      _$SonarrEpisodeFileFromJson(json);

  Map<String, dynamic> toJson() => _$SonarrEpisodeFileToJson(this);
}
