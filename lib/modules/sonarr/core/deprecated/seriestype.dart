import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'seriestype.g.dart';

@HiveType(typeId: 4, adapterName: 'DeprecatedSonarrSeriesTypeAdapter')
class DeprecatedSonarrSeriesType extends HiveObject {
  @HiveField(0)
  String? type;

  factory DeprecatedSonarrSeriesType.empty() => DeprecatedSonarrSeriesType(
        type: '',
      );

  DeprecatedSonarrSeriesType({
    required this.type,
  });
}
