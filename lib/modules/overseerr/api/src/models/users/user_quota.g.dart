// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_quota.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverseerrUserQuota _$OverseerrUserQuotaFromJson(Map<String, dynamic> json) {
  return OverseerrUserQuota(
    movie: json['movie'] == null
        ? null
        : OverseerrQuota.fromJson(json['movie'] as Map<String, dynamic>),
    tv: json['tv'] == null
        ? null
        : OverseerrQuota.fromJson(json['tv'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OverseerrUserQuotaToJson(OverseerrUserQuota instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('movie', instance.movie?.toJson());
  writeNotNull('tv', instance.tv?.toJson());
  return val;
}
