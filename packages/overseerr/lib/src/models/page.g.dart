// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverseerrPageInfo _$OverseerrPageInfoFromJson(Map<String, dynamic> json) {
  return OverseerrPageInfo(
    pages: json['pages'] as int?,
    pageSize: json['pageSize'] as int?,
    results: json['results'] as int?,
    page: json['page'] as int?,
  );
}

Map<String, dynamic> _$OverseerrPageInfoToJson(OverseerrPageInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pages', instance.pages);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('results', instance.results);
  writeNotNull('page', instance.page);
  return val;
}
