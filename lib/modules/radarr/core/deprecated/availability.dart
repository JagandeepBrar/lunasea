import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'availability.g.dart';

@HiveType(typeId: 7, adapterName: 'DeprecatedRadarrAvailabilityAdapter')
class DeprecatedRadarrAvailability extends HiveObject {
    @HiveField(0)
    String id;
    @HiveField(1)
    String name;

    factory DeprecatedRadarrAvailability.empty() => DeprecatedRadarrAvailability(
        id: '',
        name: '',
    );

    DeprecatedRadarrAvailability({
        @required this.id,
        @required this.name,
    });
}
