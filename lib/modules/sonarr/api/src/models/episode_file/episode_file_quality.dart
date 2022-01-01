import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'episode_file_quality.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrEpisodeFileQuality {
  @JsonKey(name: 'quality')
  SonarrEpisodeFileQualityQuality? quality;

  @JsonKey(name: 'revision')
  SonarrEpisodeFileQualityRevision? revision;

  SonarrEpisodeFileQuality({
    this.quality,
    this.revision,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrEpisodeFileQuality.fromJson(Map<String, dynamic> json) =>
      _$SonarrEpisodeFileQualityFromJson(json);
  Map<String, dynamic> toJson() => _$SonarrEpisodeFileQualityToJson(this);
}
