// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_format_specifications.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadarrCustomFormatSpecifications _$RadarrCustomFormatSpecificationsFromJson(
    Map<String, dynamic> json) {
  return RadarrCustomFormatSpecifications(
    name: json['name'] as String?,
    implementation: json['implementation'] as String?,
    implementationName: json['implementationName'] as String?,
    infoLink: json['infoLink'] as String?,
    negate: json['negate'] as bool?,
    required: json['required'] as bool?,
    fields: (json['fields'] as List<dynamic>?)
        ?.map((e) => e as Map<String, dynamic>)
        .toList(),
  );
}

Map<String, dynamic> _$RadarrCustomFormatSpecificationsToJson(
    RadarrCustomFormatSpecifications instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('implementation', instance.implementation);
  writeNotNull('implementationName', instance.implementationName);
  writeNotNull('infoLink', instance.infoLink);
  writeNotNull('negate', instance.negate);
  writeNotNull('required', instance.required);
  writeNotNull('fields', instance.fields);
  return val;
}
