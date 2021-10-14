// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonarrSeriesImage _$SonarrSeriesImageFromJson(Map<String, dynamic> json) =>
    SonarrSeriesImage(
      coverType: json['coverType'] as String?,
      url: json['url'] as String?,
      remoteUrl: json['remoteUrl'] as String?,
    );

Map<String, dynamic> _$SonarrSeriesImageToJson(SonarrSeriesImage instance) {
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
