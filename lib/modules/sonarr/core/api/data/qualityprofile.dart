import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'qualityprofile.g.dart';

@HiveType(typeId: 2, adapterName: 'SonarrQualityProfileAdapter')
class SonarrQualityProfile extends HiveObject {
    @HiveField(0)
    int id;
    @HiveField(1)
    String name;

    factory SonarrQualityProfile.empty() => SonarrQualityProfile(
        id: -1,
        name: '',
    );

    SonarrQualityProfile({
        @required this.id,
        @required this.name,
    });
}
