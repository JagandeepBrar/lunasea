import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'users_table.g.dart';

/// Model for the Tautulli user table from Tautulli.
///
/// Each individual Tautulli user data is stored in `users`, with each Tautulli user being a [TautulliTableUser].
@JsonSerializable(explicitToJson: true)
class TautulliUsersTable {
  /// List of [TautulliUser], each storing a single Tautulli user data.
  @JsonKey(name: 'data', fromJson: _usersFromJson, toJson: _usersToJson)
  final List<TautulliTableUser>? users;

  /// _Unknown_
  @JsonKey(name: 'draw', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? draw;

  /// Total amount of records.
  @JsonKey(
      name: 'recordsTotal', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? recordsTotal;

  /// The amount of records (filtered).
  @JsonKey(
      name: 'recordsFiltered',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? recordsFiltered;

  TautulliUsersTable({
    this.users,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliUsersTable] object.
  factory TautulliUsersTable.fromJson(Map<String, dynamic> json) =>
      _$TautulliUsersTableFromJson(json);

  /// Serialize a [TautulliUsersTable] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliUsersTableToJson(this);

  static List<TautulliTableUser> _usersFromJson(List<dynamic> users) => users
      .map((user) => TautulliTableUser.fromJson((user as Map<String, dynamic>)))
      .toList();
  static List<Map<String, dynamic>>? _usersToJson(
          List<TautulliTableUser>? users) =>
      users?.map((user) => user.toJson()).toList();
}
