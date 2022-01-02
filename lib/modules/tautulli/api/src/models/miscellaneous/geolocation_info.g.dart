// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geolocation_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliGeolocationInfo _$TautulliGeolocationInfoFromJson(
    Map<String, dynamic> json) {
  return TautulliGeolocationInfo(
    code: TautulliUtilities.ensureStringFromJson(json['code']),
    country: TautulliUtilities.ensureStringFromJson(json['country']),
    region: TautulliUtilities.ensureStringFromJson(json['region']),
    city: TautulliUtilities.ensureStringFromJson(json['city']),
    postalCode: TautulliUtilities.ensureStringFromJson(json['postal_code']),
    timezone: TautulliUtilities.ensureStringFromJson(json['timezone']),
    latitude: TautulliUtilities.ensureDoubleFromJson(json['latitude']),
    longitude: TautulliUtilities.ensureDoubleFromJson(json['longitude']),
    accuracy: TautulliUtilities.ensureDoubleFromJson(json['accuracy']),
    continent: TautulliUtilities.ensureStringFromJson(json['continent']),
  );
}

Map<String, dynamic> _$TautulliGeolocationInfoToJson(
        TautulliGeolocationInfo instance) =>
    <String, dynamic>{
      'code': instance.code,
      'country': instance.country,
      'region': instance.region,
      'city': instance.city,
      'postal_code': instance.postalCode,
      'timezone': instance.timezone,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'accuracy': instance.accuracy,
      'continent': instance.continent,
    };
