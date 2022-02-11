import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrImage {
  @JsonKey(name: 'coverType')
  String? coverType;

  @JsonKey(name: 'url')
  String? url;

  @JsonKey(name: 'remoteUrl')
  String? remoteUrl;

  ReadarrImage({
    this.coverType,
    this.url,
    this.remoteUrl,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory ReadarrImage.fromJson(Map<String, dynamic> json) =>
      _$ReadarrImageFromJson(json);

  Map<String, dynamic> toJson() => _$ReadarrImageToJson(this);
}
