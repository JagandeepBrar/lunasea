import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'libraries_table.g.dart';

/// Model for the Tautulli library table from Tautulli.
///
/// Each individual library is stored in `libraries`, with each Tautulli library being a [TautulliTableLibrary].
@JsonSerializable(explicitToJson: true)
class TautulliLibrariesTable {
  /// List of [TautulliTableLibrary], each storing a single Tautulli library data.
  @JsonKey(name: 'data', fromJson: _librariesFromJson, toJson: _librariesToJson)
  final List<TautulliTableLibrary>? libraries;

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

  TautulliLibrariesTable({
    this.libraries,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliLibrariesTable] object.
  factory TautulliLibrariesTable.fromJson(Map<String, dynamic> json) =>
      _$TautulliLibrariesTableFromJson(json);

  /// Serialize a [TautulliLibrariesTable] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliLibrariesTableToJson(this);

  static List<TautulliTableLibrary> _librariesFromJson(
          List<dynamic> libraries) =>
      libraries
          .map((library) =>
              TautulliTableLibrary.fromJson((library as Map<String, dynamic>)))
          .toList();
  static List<Map<String, dynamic>>? _librariesToJson(
          List<TautulliTableLibrary>? libraries) =>
      libraries?.map((library) => library.toJson()).toList();
}
