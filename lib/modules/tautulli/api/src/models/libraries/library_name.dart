import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

part 'library_name.g.dart';

/// Model to store basic name and data about a library from Plex.
@JsonSerializable(explicitToJson: true)
class TautulliLibraryName {
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

  TautulliLibraryName({
    this.sectionId,
    this.sectionName,
    this.sectionType,
    this.agent,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [TautulliLibraryName] object.
  factory TautulliLibraryName.fromJson(Map<String, dynamic> json) =>
      _$TautulliLibraryNameFromJson(json);

  /// Serialize a [TautulliLibraryName] object to a JSON map.
  Map<String, dynamic> toJson() => _$TautulliLibraryNameToJson(this);
}
