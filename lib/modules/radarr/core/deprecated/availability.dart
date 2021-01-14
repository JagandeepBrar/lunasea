import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'availability.g.dart';

@HiveType(typeId: 7, adapterName: 'RadarrAvailabilityAdapter')
class RadarrAvailability extends HiveObject {
    @HiveField(0)
    String id;
    @HiveField(1)
    String name;

    factory RadarrAvailability.empty() => RadarrAvailability(
        id: '',
        name: '',
    );

    RadarrAvailability({
        @required this.id,
        @required this.name,
    });
}
