import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'geolocation_info.g.dart';

/// Model to store the geolocation information for an IP address.
@JsonSerializable(explicitToJson: true)
class TautulliGeolocationInfo {
  /// Country code.
  @JsonKey(name: 'code', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? code;

  /// Country.
  @JsonKey(name: 'country', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? country;

  /// Region within the country.
  @JsonKey(name: 'region', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? region;

  /// City within the region.
  @JsonKey(name: 'city', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? city;

  /// Postal code.
  @JsonKey(
      name: 'postal_code', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? postalCode;

  /// Timezone.
  @JsonKey(name: 'timezone', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? timezone;

  /// Approximate latitude coordinate
  @JsonKey(name: 'latitude', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? latitude;

  /// Approximate longitude coordinate
  @JsonKey(name: 'longitude', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? longitude;

  /// Approximate accuracy
  @JsonKey(name: 'accuracy', fromJson: TautulliUtilities.ensureDoubleFromJson)
  final double? accuracy;

  /// Content of the IP address.
  @JsonKey(name: 'continent', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? continent;

  TautulliGeolocationInfo({
    this.code,
    this.country,
    this.region,
    this.city,
    this.postalCode,
    this.timezone,
    this.latitude,
    this.longitude,
    this.accuracy,
    this.continent,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliGeolocationInfo] object.
  factory TautulliGeolocationInfo.fromJson(Map<String, dynamic> json) =>
      _$TautulliGeolocationInfoFromJson(json);

  /// Serialize a [TautulliGeolocationInfo] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliGeolocationInfoToJson(this);
}
