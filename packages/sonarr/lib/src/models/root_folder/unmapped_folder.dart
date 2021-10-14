import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'unmapped_folder.g.dart';

/// Model for unmapped folders within a root folder from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrUnmappedFolder {
    /// Folder name
    @JsonKey(name: 'name')
    String? name;

    /// Root folder's path
    @JsonKey(name: 'path')
    String? path;

    SonarrUnmappedFolder({
        this.name,
        this.path,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrUnmappedFolder] object.
    factory SonarrUnmappedFolder.fromJson(Map<String, dynamic> json) => _$SonarrUnmappedFolderFromJson(json);
    /// Serialize a [SonarrUnmappedFolder] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrUnmappedFolderToJson(this);
}
