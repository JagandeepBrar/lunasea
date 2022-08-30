import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/sonarr/models/profile/quality_profile_item.dart';

part 'quality_profile.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrQualityProfile {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'upgradeAllowed')
  bool? upgradeAllowed;

  @JsonKey(name: 'cutoff')
  int? cutoff;

  @JsonKey(name: 'items')
  List<SonarrQualityProfileItem>? items;

  @JsonKey(name: 'id')
  int? id;

  SonarrQualityProfile({
    this.name,
    this.upgradeAllowed,
    this.cutoff,
    this.items,
    this.id,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrQualityProfile.fromJson(Map<String, dynamic> json) =>
      _$SonarrQualityProfileFromJson(json);

  Map<String, dynamic> toJson() => _$SonarrQualityProfileToJson(this);
}
