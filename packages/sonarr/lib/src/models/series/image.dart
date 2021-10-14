import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrSeriesImage {
  @JsonKey(name: 'coverType')
  String? coverType;

  @JsonKey(name: 'url')
  String? url;

  @JsonKey(name: 'remoteUrl')
  String? remoteUrl;

  SonarrSeriesImage({
    this.coverType,
    this.url,
    this.remoteUrl,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrSeriesImage.fromJson(Map<String, dynamic> json) =>
      _$SonarrSeriesImageFromJson(json);

  Map<String, dynamic> toJson() => _$SonarrSeriesImageToJson(this);
}
