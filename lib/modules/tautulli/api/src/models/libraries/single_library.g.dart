// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_library.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliSingleLibrary _$TautulliSingleLibraryFromJson(
    Map<String, dynamic> json) {
  return TautulliSingleLibrary(
    rowId: TautulliUtilities.ensureIntegerFromJson(json['row_id']),
    serverId: TautulliUtilities.ensureStringFromJson(json['server_id']),
    sectionId: TautulliUtilities.ensureIntegerFromJson(json['section_id']),
    sectionName: TautulliUtilities.ensureStringFromJson(json['section_name']),
    sectionType:
        TautulliUtilities.sectionTypeFromJson(json['section_type'] as String?),
    libraryThumb: TautulliUtilities.ensureStringFromJson(json['library_thumb']),
    libraryArt: TautulliUtilities.ensureStringFromJson(json['library_art']),
    count: TautulliUtilities.ensureIntegerFromJson(json['count']),
    childCount: TautulliUtilities.ensureIntegerFromJson(json['child_count']),
    parentCount: TautulliUtilities.ensureIntegerFromJson(json['parent_count']),
    isActive: TautulliUtilities.ensureBooleanFromJson(json['is_active']),
    doNotify: TautulliUtilities.ensureBooleanFromJson(json['do_notify']),
    doNotifyCreated:
        TautulliUtilities.ensureBooleanFromJson(json['do_notify_created']),
    keepSection: TautulliUtilities.ensureBooleanFromJson(json['keep_history']),
    deletedSection:
        TautulliUtilities.ensureBooleanFromJson(json['deleted_section']),
  );
}

Map<String, dynamic> _$TautulliSingleLibraryToJson(
        TautulliSingleLibrary instance) =>
    <String, dynamic>{
      'row_id': instance.rowId,
      'server_id': instance.serverId,
      'section_id': instance.sectionId,
      'section_name': instance.sectionName,
      'section_type': TautulliUtilities.sectionTypeToJson(instance.sectionType),
      'library_thumb': instance.libraryThumb,
      'library_art': instance.libraryArt,
      'count': instance.count,
      'parent_count': instance.parentCount,
      'child_count': instance.childCount,
      'is_active': instance.isActive,
      'do_notify': instance.doNotify,
      'do_notify_created': instance.doNotifyCreated,
      'keep_history': instance.keepSection,
      'deleted_section': instance.deletedSection,
    };
