import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'qualityprofile.g.dart';

@HiveType(typeId: 6, adapterName: 'RadarrQualityProfileAdapter')
class RadarrQualityProfile extends HiveObject {
    @HiveField(0)
    int id;
    @HiveField(1)
    String name;

    factory RadarrQualityProfile.empty() => RadarrQualityProfile(
        id: -1,
        name: '',
    );

    RadarrQualityProfile({
        @required this.id,
        @required this.name,
    });
}
