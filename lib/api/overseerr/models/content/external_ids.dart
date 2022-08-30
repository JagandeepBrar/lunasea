import 'package:lunasea/core.dart';

part 'external_ids.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrExternalIds {
  @JsonKey()
  String? imdbId;

  @JsonKey()
  String? freebaseMid;

  @JsonKey()
  String? freebaseId;

  @JsonKey()
  int? tvdbId;

  @JsonKey()
  int? tvrageId;

  @JsonKey()
  String? facebookId;

  @JsonKey()
  String? instagramId;

  @JsonKey()
  String? twitterId;

  OverseerrExternalIds({
    this.imdbId,
    this.freebaseMid,
    this.freebaseId,
    this.tvdbId,
    this.tvrageId,
    this.facebookId,
    this.instagramId,
    this.twitterId,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrExternalIds.fromJson(Map<String, dynamic> json) =>
      _$OverseerrExternalIdsFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrExternalIdsToJson(this);
}
