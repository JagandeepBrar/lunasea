import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'quality_profile_item_quality.dart';

part 'quality_profile_item.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrQualityProfileItem {
  @JsonKey(name: 'allowed')
  bool? allowed;

  @JsonKey(name: 'quality')
  ReadarrQualityProfileItemQuality? quality;

  ReadarrQualityProfileItem({
    this.allowed,
    this.quality,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrQualityProfileItem.fromJson(Map<String, dynamic> json) =>
      _$ReadarrQualityProfileItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReadarrQualityProfileItemToJson(this);
}
