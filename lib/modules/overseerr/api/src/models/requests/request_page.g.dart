// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverseerrRequestPage _$OverseerrRequestPageFromJson(Map<String, dynamic> json) {
  return OverseerrRequestPage(
    pageInfo: json['pageInfo'] == null
        ? null
        : OverseerrPageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => OverseerrRequest.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OverseerrRequestPageToJson(
    OverseerrRequestPage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pageInfo', instance.pageInfo?.toJson());
  writeNotNull('results', instance.results?.map((e) => e.toJson()).toList());
  return val;
}
