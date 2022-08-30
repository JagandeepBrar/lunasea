import 'package:lunasea/core.dart';

part 'content_ratings.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrContentRatings {
  @JsonKey()
  List<OverseerrContentRating>? results;

  OverseerrContentRatings({
    this.results,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrContentRatings.fromJson(Map<String, dynamic> json) =>
      _$OverseerrContentRatingsFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrContentRatingsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrContentRating {
  @JsonKey(name: 'iso_3166_1')
  String? iso31661;

  @JsonKey()
  String? rating;

  OverseerrContentRating({
    this.iso31661,
    this.rating,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrContentRating.fromJson(Map<String, dynamic> json) =>
      _$OverseerrContentRatingFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrContentRatingToJson(this);
}
