import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'whois_subnet.g.dart';

/// Model to store the WHOIS information for a subnet contained within an IP address lookup.
@JsonSerializable(explicitToJson: true)
class TautulliWHOISSubnet {
  /// CIDR ([classless inter-domain routing](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing)) of the subnet.
  @JsonKey(name: 'cidr', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? cidr;

  /// Name of the subnet.
  @JsonKey(name: 'name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? name;

  /// Handle of the subnet.
  @JsonKey(name: 'handle', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? handle;

  /// The IP range of the subnet.
  @JsonKey(name: 'range', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? range;

  /// A description of the subnet.
  @JsonKey(
      name: 'description', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? description;

  /// The originating country of the subnet.
  @JsonKey(name: 'country', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? country;

  /// The state (or privince, territory, etc.) within the country.
  @JsonKey(name: 'state', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? state;

  /// The city within the state.
  @JsonKey(name: 'city', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? city;

  /// The address within the city.
  @JsonKey(name: 'address', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? address;

  /// The postal/zip code.
  @JsonKey(
      name: 'postal_code', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? postalCode;

  /// List of emails attached to the subnet.
  @JsonKey(name: 'emails', fromJson: TautulliUtilities.ensureStringListFromJson)
  final List<String?>? emails;

  /// Date that the subnet was created.
  @JsonKey(name: 'created', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? created;

  /// Date that the subnet was updated.
  @JsonKey(name: 'updated', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? updated;

  TautulliWHOISSubnet({
    this.cidr,
    this.name,
    this.handle,
    this.range,
    this.description,
    this.country,
    this.state,
    this.city,
    this.address,
    this.postalCode,
    this.emails,
    this.created,
    this.updated,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliWHOISSubnet] object.
  factory TautulliWHOISSubnet.fromJson(Map<String, dynamic> json) =>
      _$TautulliWHOISSubnetFromJson(json);

  /// Serialize a [TautulliWHOISSubnet] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliWHOISSubnetToJson(this);
}
