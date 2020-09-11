import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliGraphHelper {
    static const double GRAPH_SIZE = 225.0;
    static const DEFAULT_MAX_TITLE_LENGTH = 5;
    
    TautulliGraphHelper._();

    static BarChartAlignment chartAlignment() => BarChartAlignment.spaceEvenly;

    static FlGridData gridData() => FlGridData(show: false);

    static FlBorderData borderData() => FlBorderData(
        show: true,
        border: Border.all(color: Colors.white12),
    );

    static FlTitlesData titlesData(TautulliGraphData data, {
        int maxTitleLength = DEFAULT_MAX_TITLE_LENGTH,
        bool titleOverFlowShowEllipsis = true,
    }) => FlTitlesData(
        leftTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
            showTitles: true,
            margin: 8.0,
            reservedSize: 8.0,
            getTitles: (value) => data.categories[value.truncate()].length > maxTitleLength+1
                ? [
                    data.categories[value.truncate()].substring(0, maxTitleLength).toUpperCase(),
                    if(titleOverFlowShowEllipsis) Constants.TEXT_ELLIPSIS,
                ].join()
                : data.categories[value.truncate()].toUpperCase(),
            textStyle: TextStyle(
                color: Colors.white30,
                fontSize: Constants.UI_FONT_SIZE_GRAPH_LEGEND,
            ),
        ),
    );
}
