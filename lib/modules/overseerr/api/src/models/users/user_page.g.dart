// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverseerrUserPage _$OverseerrUserPageFromJson(Map<String, dynamic> json) {
  return OverseerrUserPage(
    pageInfo: json['pageInfo'] == null
        ? null
        : OverseerrPageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => OverseerrUser.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OverseerrUserPageToJson(OverseerrUserPage instance) {
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
