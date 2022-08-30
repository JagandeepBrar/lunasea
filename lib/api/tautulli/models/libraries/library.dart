import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'library.g.dart';

/// Model to store data about a library from Plex.
///
/// This model is typically fetched using `getLibraries()`, and retrieves slightly different data than `getLibrary()`.
/// A single library through `getLibrary()` will return a [TautulliSingleLibrary] object.
@JsonSerializable(explicitToJson: true)
class TautulliLibrary {
  /// The library's section ID.
  @JsonKey(
      name: 'section_id', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? sectionId;

  /// THe name of the library section in Plex.
  @JsonKey(
      name: 'section_name', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? sectionName;

  /// The type of content stored in this library.
  @JsonKey(
      name: 'section_type',
      toJson: TautulliUtilities.sectionTypeToJson,
      fromJson: TautulliUtilities.sectionTypeFromJson)
  final TautulliSectionType? sectionType;

  /// The metadata agent being used for the library.
  @JsonKey(name: 'agent', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? agent;

  /// The library's thumbnail in Tautulli.
  @JsonKey(name: 'thumb', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? thumb;

  /// The library's artwork in Tautulli.
  @JsonKey(name: 'art', fromJson: TautulliUtilities.ensureStringFromJson)
  final String? art;

  /// The amount of content in this library.
  @JsonKey(name: 'count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? count;

  /// Is the library active?
  @JsonKey(name: 'is_active', fromJson: TautulliUtilities.ensureBooleanFromJson)
  final bool? isActive;

  /// The amount of parent content in this library (e.g., seasons, albums).
  @JsonKey(
      name: 'parent_count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? parentCount;

  /// The amount of child content in this library (e.g., songs, episodes).
  @JsonKey(
      name: 'child_count', fromJson: TautulliUtilities.ensureIntegerFromJson)
  final int? childCount;

  TautulliLibrary({
    this.sectionId,
    this.sectionName,
    this.sectionType,
    this.agent,
    this.thumb,
    this.art,
    this.count,
    this.isActive,
    this.parentCount,
    this.childCount,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliLibrary] object.
  factory TautulliLibrary.fromJson(Map<String, dynamic> json) =>
      _$TautulliLibraryFromJson(json);

  /// Serialize a [TautulliLibrary] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliLibraryToJson(this);
}
