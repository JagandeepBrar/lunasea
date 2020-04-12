import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

part 'seriestype.g.dart';

@HiveType(typeId: 4, adapterName: 'SonarrSeriesTypeAdapter')
class SonarrSeriesType extends HiveObject {
    @HiveField(0)
    String type;

    factory SonarrSeriesType.empty() => SonarrSeriesType(
        type: '',
    );

    SonarrSeriesType({
        @required this.type,
    });
}
