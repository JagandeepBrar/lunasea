import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SonarrImage {
  @JsonKey(name: 'coverType')
  String? coverType;

  @JsonKey(name: 'url')
  String? url;

  @JsonKey(name: 'remoteUrl')
  String? remoteUrl;

  SonarrImage({
    this.coverType,
    this.url,
    this.remoteUrl,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory SonarrImage.fromJson(Map<String, dynamic> json) =>
      _$SonarrImageFromJson(json);

  Map<String, dynamic> toJson() => _$SonarrImageToJson(this);
}
