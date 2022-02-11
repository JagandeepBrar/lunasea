import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'rating.g.dart';

/// Model for series' rating values.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ReadarrAuthorRating {
  /// Number of votes for the rating score
  @JsonKey(name: 'votes')
  int? votes;

  /// Final score/value of the rating
  @JsonKey(name: 'value')
  double? value;

  ReadarrAuthorRating({
    this.votes,
    this.value,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [ReadarrAuthorRating] object.
  factory ReadarrAuthorRating.fromJson(Map<String, dynamic> json) =>
      _$ReadarrAuthorRatingFromJson(json);

  /// Serialize a [ReadarrAuthorRating] object to a JSON map.
  Map<String, dynamic> toJson() => _$ReadarrAuthorRatingToJson(this);
}
