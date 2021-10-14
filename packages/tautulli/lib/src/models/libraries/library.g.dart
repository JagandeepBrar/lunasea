// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliLibrary _$TautulliLibraryFromJson(Map<String, dynamic> json) {
  return TautulliLibrary(
    sectionId: TautulliUtilities.ensureIntegerFromJson(json['section_id']),
    sectionName: TautulliUtilities.ensureStringFromJson(json['section_name']),
    sectionType:
        TautulliUtilities.sectionTypeFromJson(json['section_type'] as String?),
    agent: TautulliUtilities.ensureStringFromJson(json['agent']),
    thumb: TautulliUtilities.ensureStringFromJson(json['thumb']),
    art: TautulliUtilities.ensureStringFromJson(json['art']),
    count: TautulliUtilities.ensureIntegerFromJson(json['count']),
    isActive: TautulliUtilities.ensureBooleanFromJson(json['is_active']),
    parentCount: TautulliUtilities.ensureIntegerFromJson(json['parent_count']),
    childCount: TautulliUtilities.ensureIntegerFromJson(json['child_count']),
  );
}

Map<String, dynamic> _$TautulliLibraryToJson(TautulliLibrary instance) =>
    <String, dynamic>{
      'section_id': instance.sectionId,
      'section_name': instance.sectionName,
      'section_type': TautulliUtilities.sectionTypeToJson(instance.sectionType),
      'agent': instance.agent,
      'thumb': instance.thumb,
      'art': instance.art,
      'count': instance.count,
      'is_active': instance.isActive,
      'parent_count': instance.parentCount,
      'child_count': instance.childCount,
    };
