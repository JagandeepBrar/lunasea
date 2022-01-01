// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quality_revision.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrQualityRevision _$RadarrQualityRevisionFromJson(
    Map<String, dynamic> json) {
  return RadarrQualityRevision(
    version: json['version'] as int?,
    real: json['real'] as int?,
    isRepack: json['isRepack'] as bool?,
  );
}

Map<String, dynamic> _$RadarrQualityRevisionToJson(
    RadarrQualityRevision instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('version', instance.version);
  writeNotNull('real', instance.real);
  writeNotNull('isRepack', instance.isRepack);
  return val;
}
