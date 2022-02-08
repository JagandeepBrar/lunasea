import 'package:lunasea/core.dart';

part 'credits.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrCredits {
  @JsonKey()
  List<OverseerrCast>? cast;

  @JsonKey()
  List<OverseerrCrew>? crew;

  OverseerrCredits({
    this.cast,
    this.crew,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrCredits.fromJson(Map<String, dynamic> json) =>
      _$OverseerrCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrCreditsToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrCast {
  @JsonKey()
  int? id;

  @JsonKey()
  int? castId;

  @JsonKey()
  String? character;

  @JsonKey()
  String? creditId;

  @JsonKey()
  int? gender;

  @JsonKey()
  String? name;

  @JsonKey()
  int? order;

  @JsonKey()
  String? profilePath;

  OverseerrCast({
    this.id,
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.name,
    this.order,
    this.profilePath,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrCast.fromJson(Map<String, dynamic> json) =>
      _$OverseerrCastFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrCastToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrCrew {
  @JsonKey()
  int? id;

  @JsonKey()
  String? creditId;

  @JsonKey()
  String? department;

  @JsonKey()
  int? gender;

  @JsonKey()
  String? job;

  @JsonKey()
  String? name;

  @JsonKey()
  String? profilePath;

  OverseerrCrew({
    this.id,
    this.creditId,
    this.department,
    this.gender,
    this.job,
    this.name,
    this.profilePath,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrCrew.fromJson(Map<String, dynamic> json) =>
      _$OverseerrCrewFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrCrewToJson(this);
}
