// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manual_import_rejection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrManualImportRejection _$RadarrManualImportRejectionFromJson(
    Map<String, dynamic> json) {
  return RadarrManualImportRejection(
    reason: json['reason'] as String?,
    type: json['type'] as String?,
  );
}

Map<String, dynamic> _$RadarrManualImportRejectionToJson(
    RadarrManualImportRejection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('reason', instance.reason);
  writeNotNull('type', instance.type);
  return val;
}
