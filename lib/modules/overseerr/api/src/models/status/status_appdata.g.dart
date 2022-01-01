// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_appdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverseerrStatusAppData _$OverseerrStatusAppDataFromJson(
    Map<String, dynamic> json) {
  return OverseerrStatusAppData(
    appData: json['appData'] as bool?,
    appDataPath: json['appDataPath'] as String?,
  );
}

Map<String, dynamic> _$OverseerrStatusAppDataToJson(
    OverseerrStatusAppData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('appData', instance.appData);
  writeNotNull('appDataPath', instance.appDataPath);
  return val;
}
