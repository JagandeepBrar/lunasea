import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'user_ips.g.dart';

/// Model to store user IP address records from Tautulli.
///
/// Each individual login record is stored in `ips`, with each login record being a [TautulliUserIPRecord].
@JsonSerializable(explicitToJson: true)
class TautulliUserIPs {
  /// Number of filtered records returned.
  @JsonKey(
      name: 'recordsFiltered',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? recordsFiltered;

  /// Total amount of records.
  @JsonKey(
      name: 'recordsTotal', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? recordsTotal;

  /// _Unknown_
  @JsonKey(name: 'draw', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? draw;

  /// The individual notification logs.
  @JsonKey(name: 'data', toJson: _ipsToJson, fromJson: _ipsFromJson)
  final List<TautulliUserIPRecord>? ips;

  TautulliUserIPs({
    this.recordsFiltered,
    this.recordsTotal,
    this.draw,
    this.ips,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliUserIPs] object.
  factory TautulliUserIPs.fromJson(Map<String, dynamic> json) =>
      _$TautulliUserIPsFromJson(json);

  /// Serialize a [TautulliUserIPs] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliUserIPsToJson(this);

  static List<TautulliUserIPRecord> _ipsFromJson(List<dynamic> ips) => ips
      .map((ip) => TautulliUserIPRecord.fromJson((ip as Map<String, dynamic>)))
      .toList();
  static List<Map<String, dynamic>>? _ipsToJson(
          List<TautulliUserIPRecord>? ips) =>
      ips?.map((ip) => ip.toJson()).toList();
}
