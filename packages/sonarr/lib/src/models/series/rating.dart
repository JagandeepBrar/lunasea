import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'rating.g.dart';

/// Model for series' rating values.
@JsonSerializable(explicitToJson: true)
class SonarrSeriesRating {
    /// Number of votes for the rating score
    @JsonKey(name: 'votes')
    int? votes;

    /// Final score/value of the rating
    @JsonKey(name: 'value')
    double? value;

    SonarrSeriesRating({
        this.votes,
        this.value,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrSeriesRating] object.
    factory SonarrSeriesRating.fromJson(Map<String, dynamic> json) => _$SonarrSeriesRatingFromJson(json);
    /// Serialize a [SonarrSeriesRating] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrSeriesRatingToJson(this);
}
