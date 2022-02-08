import 'package:lunasea/core.dart';

part 'production_country.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrProductionCountry {
  @JsonKey(name: 'iso_3166_1')
  String? iso31661;

  @JsonKey()
  String? name;

  OverseerrProductionCountry({
    this.iso31661,
    this.name,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$OverseerrProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrProductionCountryToJson(this);
}
