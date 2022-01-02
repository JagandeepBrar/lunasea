import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'library_media_info.g.dart';

/// Model to store the Tautulli media information table data records.
///
/// Each individual media information entry is stored in `mediaInfo`, with each log being a [TautulliLibraryMediaInfoRecord].
@JsonSerializable(explicitToJson: true)
class TautulliLibraryMediaInfo {
  /// Number of filtered records returned.
  @JsonKey(
      name: 'recordsFiltered',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? recordsFiltered;

  /// Total amount of records.
  @JsonKey(
      name: 'recordsTotal', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? recordsTotal;

  /// Total file size of the filtered returned results.
  @JsonKey(
      name: 'filtered_file_size',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? filteredFileSize;

  /// Total file size of the returned results.
  @JsonKey(
      name: 'total_file_size',
      fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? totalFileSize;

  /// _Unknown_
  @JsonKey(name: 'draw', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? draw;

  /// The individual media information records.
  @JsonKey(name: 'data', toJson: _infoToJson, fromJson: _infoFromJson)
  final List<TautulliLibraryMediaInfoRecord>? mediaInfo;

  TautulliLibraryMediaInfo({
    this.recordsFiltered,
    this.recordsTotal,
    this.filteredFileSize,
    this.totalFileSize,
    this.draw,
    this.mediaInfo,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliLibraryMediaInfo] object.
  factory TautulliLibraryMediaInfo.fromJson(Map<String, dynamic> json) =>
      _$TautulliLibraryMediaInfoFromJson(json);

  /// Serialize a [TautulliLibraryMediaInfo] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliLibraryMediaInfoToJson(this);

  static List<TautulliLibraryMediaInfoRecord> _infoFromJson(dynamic mediaInfo) {
    if (mediaInfo is List)
      return mediaInfo
          .map((info) => TautulliLibraryMediaInfoRecord.fromJson(
              (info as Map<String, dynamic>)))
          .toList();
    return [];
  }

  static List<Map<String, dynamic>>? _infoToJson(
          List<TautulliLibraryMediaInfoRecord>? mediaInfo) =>
      mediaInfo?.map((info) => info.toJson()).toList();
}
