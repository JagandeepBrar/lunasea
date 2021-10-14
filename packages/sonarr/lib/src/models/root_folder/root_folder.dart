import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:sonarr/models.dart';

part 'root_folder.g.dart';

/// Model for root folders from Sonarr.
@JsonSerializable(explicitToJson: true)
class SonarrRootFolder {
    /// Root folder's path
    @JsonKey(name: 'path')
    String? path;

    /// Free space at the root folder
    @JsonKey(name: 'freeSpace')
    int? freeSpace;

    /// Total space at the root folder
    @JsonKey(name: 'totalSpace')
    int? totalSpace;

    /// List of unmapped folders within this root folder
    @JsonKey(name: 'unmappedFolders')
    List<SonarrUnmappedFolder>? unmappedFolders;

    /// Identifier of the root folder
    @JsonKey(name: 'id')
    int? id;

    SonarrRootFolder({
        this.path,
        this.freeSpace,
        this.totalSpace,
        this.unmappedFolders,
        this.id,
    });

    /// Returns a JSON-encoded string version of this object.
    @override
    String toString() => json.encode(this.toJson());

    /// Deserialize a JSON map to a [SonarrRootFolder] object.
    factory SonarrRootFolder.fromJson(Map<String, dynamic> json) => _$SonarrRootFolderFromJson(json);
    /// Serialize a [SonarrRootFolder] object to a JSON map.
    Map<String, dynamic> toJson() => _$SonarrRootFolderToJson(this);
}
