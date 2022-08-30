import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:lunasea/api/radarr/types.dart';
import 'package:lunasea/api/radarr/utilities.dart';

part 'import_list.g.dart';

/// Model for an import list from Radarr.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RadarrImportList {
  @JsonKey(name: 'enabled')
  bool? enabled;

  @JsonKey(name: 'enableAuto')
  bool? enableAuto;

  @JsonKey(name: 'shouldMonitor')
  bool? shouldMonitor;

  @JsonKey(name: 'rootFolderPath')
  String? rootFolderPath;

  @JsonKey(name: 'qualityProfileId')
  int? qualityProfileId;

  @JsonKey(name: 'searchOnAdd')
  bool? searchOnAdd;

  @JsonKey(
      name: 'minimumAvailability',
      toJson: RadarrUtilities.availabilityToJson,
      fromJson: RadarrUtilities.availabilityFromJson)
  RadarrAvailability? minimumAvailability;

  @JsonKey(name: 'listType')
  String? listType;

  @JsonKey(name: 'listOrder')
  int? listOrder;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'fields')
  List<Map>? fields;

  @JsonKey(name: 'implementationName')
  String? implementationName;

  @JsonKey(name: 'implementation')
  String? implementation;

  @JsonKey(name: 'configContract')
  String? configContract;

  @JsonKey(name: 'infoLink')
  String? infoLink;

  @JsonKey(name: 'tags')
  List<int>? tags;

  @JsonKey(name: 'id')
  int? id;

  RadarrImportList({
    this.enabled,
    this.enableAuto,
    this.shouldMonitor,
    this.rootFolderPath,
    this.qualityProfileId,
    this.searchOnAdd,
    this.minimumAvailability,
    this.listType,
    this.listOrder,
    this.name,
    this.fields,
    this.implementationName,
    this.implementation,
    this.configContract,
    this.infoLink,
    this.tags,
    this.id,
  });

  /// Returns a JSON-encoded string version of this object.
  @override
  String toString() => json.encode(this.toJson());

  /// Deserialize a JSON map to a [RadarrImportList] object.
  factory RadarrImportList.fromJson(Map<String, dynamic> json) =>
      _$RadarrImportListFromJson(json);

  /// Serialize a [RadarrImportList] object to a JSON map.
  Map<String, dynamic> toJson() => _$RadarrImportListToJson(this);
}
