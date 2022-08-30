import 'package:lunasea/core.dart';

part 'watch_provider.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrWatchProvider {
  @JsonKey(name: 'iso_3166_1')
  String? iso31661;

  @JsonKey()
  String? link;

  @JsonKey()
  List<OverseerrWatchProviderDetails>? buy;

  @JsonKey()
  List<OverseerrWatchProviderDetails>? flatrate;

  OverseerrWatchProvider({
    this.iso31661,
    this.link,
    this.buy,
    this.flatrate,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrWatchProvider.fromJson(Map<String, dynamic> json) =>
      _$OverseerrWatchProviderFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrWatchProviderToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class OverseerrWatchProviderDetails {
  @JsonKey()
  int? id;

  @JsonKey()
  String? name;

  @JsonKey()
  int? displayPriority;

  @JsonKey()
  String? logoPath;

  OverseerrWatchProviderDetails({
    this.id,
    this.name,
    this.displayPriority,
    this.logoPath,
  });

  @override
  String toString() => json.encode(this.toJson());

  factory OverseerrWatchProviderDetails.fromJson(Map<String, dynamic> json) =>
      _$OverseerrWatchProviderDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$OverseerrWatchProviderDetailsToJson(this);
}
