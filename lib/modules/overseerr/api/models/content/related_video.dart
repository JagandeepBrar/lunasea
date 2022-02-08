import 'package:lunasea/core.dart';

part 'related_video.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrRelatedVideo {
  @JsonKey()
  String? site;

  @JsonKey()
  String? key;

  @JsonKey()
  String? name;

  @JsonKey()
  int? size;

  @JsonKey()
  String? type;

  @JsonKey()
  String? url;

  OverseerrRelatedVideo({
    this.site,
    this.key,
    this.name,
    this.size,
    this.type,
    this.url,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrRelatedVideo.fromJson(Map<String, dynamic> json) =>
      _$OverseerrRelatedVideoFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrRelatedVideoToJson(this);
}
