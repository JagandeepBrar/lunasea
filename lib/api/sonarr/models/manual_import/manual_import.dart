import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/modules/sonarr.dart';

part 'manual_import.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrManualImport {

  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'seriesId')
  int? seriesId;

  @JsonKey(name: 'episodeIds')
  List<int>? episodeIds;

  @JsonKey(name: 'releaseGroup')
  String? releaseGroup;

  @JsonKey(name: 'quality')
  SonarrEpisodeFileQuality? quality;

  @JsonKey(name: 'language')
  SonarrEpisodeFileLanguage? language;

  @JsonKey(name: 'downloadId')
  String? downloadId;

  @JsonKey(name: 'id')
  int? id;

  SonarrManualImport({
    this.path,
    this.seriesId,
    this.episodeIds,
    this.releaseGroup,
    this.quality,
    this.language,
    this.downloadId,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [SonarrManualImport] object.
  factory SonarrManualImport.fromJson(Map<String, dynamic> json) =>
      _$SonarrManualImportFromJson(json);

  /// Serialize a [SonarrManualImport] object to a JSON map.
  Map<String, dynamic> toJson() => _$SonarrManualImportToJson(this);
}
