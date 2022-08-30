import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'episode_file_quality_quality.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrEpisodeFileQualityQuality {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'source')
  String? source;

  @JsonKey(name: 'resolution')
  int? resolution;

  SonarrEpisodeFileQualityQuality({
    this.id,
    this.name,
    this.source,
    this.resolution,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrEpisodeFileQualityQuality.fromJson(Map<String, dynamic> json) =>
      _$SonarrEpisodeFileQualityQualityFromJson(json);
  Map<String, dynamic> toJson() =>
      _$SonarrEpisodeFileQualityQualityToJson(this);
}
