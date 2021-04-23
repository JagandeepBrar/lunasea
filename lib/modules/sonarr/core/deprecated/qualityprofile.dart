import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'qualityprofile.g.dart';

@HiveType(typeId: 2, adapterName: 'DeprecatedSonarrQualityProfileAdapter')
class DeprecatedSonarrQualityProfile extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;

  factory DeprecatedSonarrQualityProfile.empty() =>
      DeprecatedSonarrQualityProfile(
        id: -1,
        name: '',
      );

  DeprecatedSonarrQualityProfile({
    @required this.id,
    @required this.name,
  });
}
