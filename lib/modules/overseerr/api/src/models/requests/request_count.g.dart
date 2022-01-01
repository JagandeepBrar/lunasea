// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverseerrRequestCount _$OverseerrRequestCountFromJson(
    Map<String, dynamic> json) {
  return OverseerrRequestCount(
    pending: json['pending'] as int?,
    approved: json['approved'] as int?,
    processing: json['processing'] as int?,
    available: json['available'] as int?,
  );
}

Map<String, dynamic> _$OverseerrRequestCountToJson(
    OverseerrRequestCount instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pending', instance.pending);
  writeNotNull('approved', instance.approved);
  writeNotNull('processing', instance.processing);
  writeNotNull('available', instance.available);
  return val;
}
