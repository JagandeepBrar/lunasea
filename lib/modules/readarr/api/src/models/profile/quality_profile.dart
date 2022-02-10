import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'quality_profile_item.dart';

part 'quality_profile.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrQualityProfile {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'upgradeAllowed')
  bool? upgradeAllowed;

  @JsonKey(name: 'cutoff')
  int? cutoff;

  @JsonKey(name: 'items')
  List<ReadarrQualityProfileItem>? items;

  @JsonKey(name: 'id')
  int? id;

  ReadarrQualityProfile({
    this.name,
    this.upgradeAllowed,
    this.cutoff,
    this.items,
    this.id,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrQualityProfile.fromJson(Map<String, dynamic> json) =>
      _$ReadarrQualityProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ReadarrQualityProfileToJson(this);
}
