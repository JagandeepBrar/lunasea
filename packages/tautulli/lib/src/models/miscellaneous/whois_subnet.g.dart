// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whois_subnet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TautulliWHOISSubnet _$TautulliWHOISSubnetFromJson(Map<String, dynamic> json) {
  return TautulliWHOISSubnet(
    cidr: TautulliUtilities.ensureStringFromJson(json['cidr']),
    name: TautulliUtilities.ensureStringFromJson(json['name']),
    handle: TautulliUtilities.ensureStringFromJson(json['handle']),
    range: TautulliUtilities.ensureStringFromJson(json['range']),
    description: TautulliUtilities.ensureStringFromJson(json['description']),
    country: TautulliUtilities.ensureStringFromJson(json['country']),
    state: TautulliUtilities.ensureStringFromJson(json['state']),
    city: TautulliUtilities.ensureStringFromJson(json['city']),
    address: TautulliUtilities.ensureStringFromJson(json['address']),
    postalCode: TautulliUtilities.ensureStringFromJson(json['postal_code']),
    emails: TautulliUtilities.ensureStringListFromJson(json['emails']),
    created: TautulliUtilities.ensureStringFromJson(json['created']),
    updated: TautulliUtilities.ensureStringFromJson(json['updated']),
  );
}

Map<String, dynamic> _$TautulliWHOISSubnetToJson(
        TautulliWHOISSubnet instance) =>
    <String, dynamic>{
      'cidr': instance.cidr,
      'name': instance.name,
      'handle': instance.handle,
      'range': instance.range,
      'description': instance.description,
      'country': instance.country,
      'state': instance.state,
      'city': instance.city,
      'address': instance.address,
      'postal_code': instance.postalCode,
      'emails': instance.emails,
      'created': instance.created,
      'updated': instance.updated,
    };
