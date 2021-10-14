import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'episode_file_language.g.dart';

/// Model for an episode file's language from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrEpisodeFileLanguage {
    /// Identifier of the language profile
    @JsonKey(name: 'id')
    int? id;

    /// Name of the language profile
    @JsonKey(name: 'name')
    String? name;

    SonarrEpisodeFileLanguage({
        this.id,
        this.name,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrEpisodeFileLanguage] object.
    factory SonarrEpisodeFileLanguage.fromJson(Map<String, dynamic> json) => _$SonarrEpisodeFileLanguageFromJson(json);
    /// Serialize a [SonarrEpisodeFileLanguage] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrEpisodeFileLanguageToJson(this);
}
