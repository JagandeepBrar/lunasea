import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'alternate_title.g.dart';

/// Model for series' alternate title from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrSeriesAlternateTitle {
    /// Title of the alternate title
    @JsonKey(name: 'title')
    String? title;

    /// Scene season number associated with this title (Mainly used in anime series)
    @JsonKey(name: 'sceneSeasonNumber')
    int? sceneSeasonNumber;

    /// Season number associated with this title
    @JsonKey(name: 'seasonNumber')
    int? seasonNumber;

    SonarrSeriesAlternateTitle({
        this.title,
        this.sceneSeasonNumber,
        this.seasonNumber,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrSeriesAlternateTitle] object.
    factory SonarrSeriesAlternateTitle.fromJson(Map<String, dynamic> json) => _$SonarrSeriesAlternateTitleFromJson(json);
    /// Serialize a [SonarrSeriesAlternateTitle] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrSeriesAlternateTitleToJson(this);
}
