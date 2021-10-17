// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrImage _$SonarrImageFromJson(Map<String, dynamic> json) => SonarrImage(
      coverType: json['coverType'] as String?,
      url: json['url'] as String?,
      remoteUrl: json['remoteUrl'] as String?,
    );

Map<String, dynamic> _$SonarrImageToJson(SonarrImage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('coverType', instance.coverType);
  writeNotNull('url', instance.url);
  writeNotNull('remoteUrl', instance.remoteUrl);
  return val;
}
