import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'episode_file_language.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrEpisodeFileLanguage {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  SonarrEpisodeFileLanguage({
    this.id,
    this.name,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrEpisodeFileLanguage.fromJson(Map<String, dynamic> json) =>
      _$SonarrEpisodeFileLanguageFromJson(json);
  Map<String, dynamic> toJson() => _$SonarrEpisodeFileLanguageToJson(this);
}
