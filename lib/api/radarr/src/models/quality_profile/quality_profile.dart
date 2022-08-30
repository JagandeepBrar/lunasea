import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/models.dart';

part 'quality_profile.g.dart';

/// Store details about a quality profile in Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrQualityProfile {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'upgradeAllowed')
  bool? upgradeAllowed;

  @JsonKey(name: 'cutoff')
  int? cutoff;

  @JsonKey(name: 'items')
  List<RadarrQualityProfileItem>? items;

  @JsonKey(name: 'minFormatScore')
  int? minFormatScore;

  @JsonKey(name: 'cutoffFormatScore')
  int? cutoffFormatScore;

  @JsonKey(name: 'formatItems')
  List<RadarrQualityProfileFormatItem>? formatItems;

  @JsonKey(name: 'language')
  RadarrLanguage? language;

  @JsonKey(name: 'id')
  int? id;

  RadarrQualityProfile({
    this.name,
    this.upgradeAllowed,
    this.cutoff,
    this.items,
    this.minFormatScore,
    this.cutoffFormatScore,
    this.formatItems,
    this.language,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrQualityProfile] object.
  factory RadarrQualityProfile.fromJson(Map<String, dynamic> json) =>
      _$RadarrQualityProfileFromJson(json);

  /// Serialize a [RadarrQualityProfile] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrQualityProfileToJson(this);
}
