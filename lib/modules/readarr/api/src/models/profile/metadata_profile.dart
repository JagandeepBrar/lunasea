import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'metadata_profile.g.dart';

/// Model for a language profile from Readarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrMetadataProfile {
  /// Name of the profile
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'allowedLanguages')
  String? allowedLanguages;

  @JsonKey(name: 'minPages')
  int? minPages;

  @JsonKey(name: 'minPopularity')
  int? minPopularity;

  @JsonKey(name: 'skipMissingDate')
  bool? skipMissingDate;

  @JsonKey(name: 'skipMissingIsbn')
  bool? skipMissingIsbn;

  @JsonKey(name: 'skipPartsAndSets')
  bool? skipPartsAndSets;

  @JsonKey(name: 'skipSeriesSecondary')
  bool? skipSeriesSecondary;

  @JsonKey(name: 'ignored')
  String? ignored;

  /// Identifier of the language profile
  @JsonKey(name: 'id')
  int? id;

  ReadarrMetadataProfile({
    this.name,
    this.allowedLanguages,
    this.minPages,
    this.minPopularity,
    this.skipMissingDate,
    this.skipMissingIsbn,
    this.skipPartsAndSets,
    this.skipSeriesSecondary,
    this.ignored,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [ReadarrMetadataProfile] object.
  factory ReadarrMetadataProfile.fromJson(Map<String, dynamic> json) =>
      _$ReadarrMetadataProfileFromJson(json);

  /// Serialize a [ReadarrMetadataProfile] object to a JSON map.
  Map<String, dynamic> toJson() => _$ReadarrMetadataProfileToJson(this);
}
