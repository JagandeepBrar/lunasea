import 'package:lunasea/core.dart';

part 'network.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrNetwork {
  @JsonKey()
  int? id;

  @JsonKey()
  String? name;

  @JsonKey()
  String? originCountry;

  @JsonKey()
  String? logoPath;

  OverseerrNetwork({
    this.id,
    this.name,
    this.originCountry,
    this.logoPath,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrNetwork.fromJson(Map<String, dynamic> json) =>
      _$OverseerrNetworkFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrNetworkToJson(this);
}
