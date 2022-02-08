import 'package:lunasea/core.dart';

part 'created_by.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrCreatedBy {
  @JsonKey()
  int? id;

  @JsonKey(name: 'credit_id')
  String? creditId;

  @JsonKey()
  String? name;

  @JsonKey()
  int? gender;

  @JsonKey(name: 'profile_path')
  String? profilePath;

  OverseerrCreatedBy({
    this.id,
    this.creditId,
    this.name,
    this.gender,
    this.profilePath,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrCreatedBy.fromJson(Map<String, dynamic> json) =>
      _$OverseerrCreatedByFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrCreatedByToJson(this);
}
