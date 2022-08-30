import 'package:lunasea/core.dart';

part 'production_company.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrProductionCompany {
  @JsonKey()
  int? id;

  @JsonKey()
  String? logoPath;

  @JsonKey()
  String? originCountry;

  @JsonKey()
  String? name;

  @JsonKey()
  String? description;

  @JsonKey()
  String? headquarters;

  @JsonKey()
  String? homepage;

  OverseerrProductionCompany({
    this.id,
    this.logoPath,
    this.originCountry,
    this.name,
    this.description,
    this.headquarters,
    this.homepage,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$OverseerrProductionCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrProductionCompanyToJson(this);
}
