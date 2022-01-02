import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'user_logins.g.dart';

/// Model to store user login records from Tautulli.
///
/// Each individual login record is stored in `logins`, with each login record being a [TautulliUserLoginRecord].
@JsonSerializable(explicitToJson: true)
class TautulliUserLogins {
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
  @JsonKey(name: 'data', toJson: _loginsToJson, fromJson: _loginsFromJson)
  final List<TautulliUserLoginRecord>? logins;

  TautulliUserLogins({
    this.recordsFiltered,
    this.recordsTotal,
    this.draw,
    this.logins,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliUserLogins] object.
  factory TautulliUserLogins.fromJson(Map<String, dynamic> json) =>
      _$TautulliUserLoginsFromJson(json);

  /// Serialize a [TautulliUserLogins] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliUserLoginsToJson(this);

  static List<TautulliUserLoginRecord> _loginsFromJson(List<dynamic> logins) =>
      logins
          .map((login) =>
              TautulliUserLoginRecord.fromJson((login as Map<String, dynamic>)))
          .toList();
  static List<Map<String, dynamic>>? _loginsToJson(
          List<TautulliUserLoginRecord>? logins) =>
      logins?.map((login) => login.toJson()).toList();
}
