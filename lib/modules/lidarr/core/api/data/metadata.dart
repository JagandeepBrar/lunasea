import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'metadata.g.dart';

@HiveType(typeId: 10, adapterName: 'LidarrMetadataProfileAdapter')
class LidarrMetadataProfile {
    @HiveField(0)
    int id;
    @HiveField(1)
    String name;

    LidarrMetadataProfile({
        @required this.id,
        @required this.name,
    });
}
