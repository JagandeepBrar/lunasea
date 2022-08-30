import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/sonarr/models/profile/quality_profile_item_quality.dart';

part 'quality_profile_item.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrQualityProfileItem {
  @JsonKey(name: 'allowed')
  bool? allowed;

  @JsonKey(name: 'quality')
  SonarrQualityProfileItemQuality? quality;

  SonarrQualityProfileItem({
    this.allowed,
    this.quality,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrQualityProfileItem.fromJson(Map<String, dynamic> json) =>
      _$SonarrQualityProfileItemFromJson(json);

  Map<String, dynamic> toJson() => _$SonarrQualityProfileItemToJson(this);
}
