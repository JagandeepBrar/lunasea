import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'episode_file_quality_revision.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrEpisodeFileQualityRevision {
  @JsonKey(name: 'version')
  int? version;

  @JsonKey(name: 'real')
  int? real;

  @JsonKey(name: 'isRepack')
  bool? isRepack;

  SonarrEpisodeFileQualityRevision({
    this.version,
    this.real,
    this.isRepack,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrEpisodeFileQualityRevision.fromJson(
          Map<String, dynamic> json) =>
      _$SonarrEpisodeFileQualityRevisionFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SonarrEpisodeFileQualityRevisionToJson(this);
}
