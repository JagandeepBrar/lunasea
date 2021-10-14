// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_name.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliLibraryName _$TautulliLibraryNameFromJson(Map<String, dynamic> json) {
  return TautulliLibraryName(
    sectionId: TautulliUtilities.ensureIntegerFromJson(json['section_id']),
    sectionName: TautulliUtilities.ensureStringFromJson(json['section_name']),
    sectionType:
        TautulliUtilities.sectionTypeFromJson(json['section_type'] as String?),
    agent: TautulliUtilities.ensureStringFromJson(json['agent']),
  );
}

Map<String, dynamic> _$TautulliLibraryNameToJson(
        TautulliLibraryName instance) =>
    <String, dynamic>{
      'section_id': instance.sectionId,
      'section_name': instance.sectionName,
      'section_type': TautulliUtilities.sectionTypeToJson(instance.sectionType),
      'agent': instance.agent,
    };
