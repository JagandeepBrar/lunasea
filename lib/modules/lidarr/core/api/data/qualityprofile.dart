import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'qualityprofile.g.dart';

@HiveType(typeId: 9, adapterName: 'LidarrQualityProfileAdapter')
class LidarrQualityProfile {
    @HiveField(0)
    int id;
    @HiveField(1)
    String name;

    LidarrQualityProfile({
        @required this.id,
        @required this.name,
    });
}
