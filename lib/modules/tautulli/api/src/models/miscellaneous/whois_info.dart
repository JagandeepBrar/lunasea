import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'whois_info.g.dart';

/// Model to store the WHOIS information for an IP address.
///
/// Each individual subnet is stored in `subnets`, with each subnet being a [TautulliWHOISSubnet].
@JsonSerializable(explicitToJson: true)
class TautulliWHOISInfo {
  /// Host of the IP address.
  @JsonKey(name: 'host', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? host;

  /// List of [TautulliWHOISSubnet] containing information about each individual subnet.
  @JsonKey(name: 'nets', toJson: _subnetsToMap, fromJson: _subnetsToObjectArray)
  final List<TautulliWHOISSubnet>? subnets;

  TautulliWHOISInfo({
    this.host,
    this.subnets,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliWHOISInfo] object.
  factory TautulliWHOISInfo.fromJson(Map<String, dynamic> json) =>
      _$TautulliWHOISInfoFromJson(json);

  /// Serialize a [TautulliWHOISInfo] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliWHOISInfoToJson(this);

  static List<TautulliWHOISSubnet> _subnetsToObjectArray(
          List<dynamic> subnets) =>
      subnets
          .map((subnet) =>
              TautulliWHOISSubnet.fromJson((subnet as Map<String, dynamic>)))
          .toList();
  static List<Map<String, dynamic>>? _subnetsToMap(
          List<TautulliWHOISSubnet>? subnets) =>
      subnets?.map((subnet) => subnet.toJson()).toList();
}
