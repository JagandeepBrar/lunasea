// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrImportList _$RadarrImportListFromJson(Map<String, dynamic> json) {
  return RadarrImportList(
    enabled: json['enabled'] as bool?,
    enableAuto: json['enableAuto'] as bool?,
    shouldMonitor: json['shouldMonitor'] as bool?,
    rootFolderPath: json['rootFolderPath'] as String?,
    qualityProfileId: json['qualityProfileId'] as int?,
    searchOnAdd: json['searchOnAdd'] as bool?,
    minimumAvailability: RadarrUtilities.availabilityFromJson(
        json['minimumAvailability'] as String?),
    listType: json['listType'] as String?,
    listOrder: json['listOrder'] as int?,
    name: json['name'] as String?,
    fields: (json['fields'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
    implementationName: json['implementationName'] as String?,
    implementation: json['implementation'] as String?,
    configContract: json['configContract'] as String?,
    infoLink: json['infoLink'] as String?,
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e as int).toList(),
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$RadarrImportListToJson(RadarrImportList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('enabled', instance.enabled);
  writeNotNull('enableAuto', instance.enableAuto);
  writeNotNull('shouldMonitor', instance.shouldMonitor);
  writeNotNull('rootFolderPath', instance.rootFolderPath);
  writeNotNull('qualityProfileId', instance.qualityProfileId);
  writeNotNull('searchOnAdd', instance.searchOnAdd);
  writeNotNull('minimumAvailability',
      RadarrUtilities.availabilityToJson(instance.minimumAvailability));
  writeNotNull('listType', instance.listType);
  writeNotNull('listOrder', instance.listOrder);
  writeNotNull('name', instance.name);
  writeNotNull('fields', instance.fields);
  writeNotNull('implementationName', instance.implementationName);
  writeNotNull('implementation', instance.implementation);
  writeNotNull('configContract', instance.configContract);
  writeNotNull('infoLink', instance.infoLink);
  writeNotNull('tags', instance.tags);
  writeNotNull('id', instance.id);
  return val;
}
