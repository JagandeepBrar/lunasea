import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliGraphHelper {
    static const GRAPH_HEIGHT = 225.0;
    static const LEGEND_HEIGHT = 26.0;
    static const DEFAULT_MAX_TITLE_LENGTH = 5;
    
    BarChartAlignment chartAlignment() => BarChartAlignment.spaceEvenly;

    FlGridData gridData() => FlGridData(show: false);

    FlBorderData borderData() => FlBorderData(
        show: true,
        border: Border.all(color: Colors.white12),
    );

    FlTitlesData titlesData(TautulliGraphData data, {
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
                    data.categories[value.truncate()].substring(0, min(maxTitleLength, data.categories[value.truncate()].length)).toUpperCase(),
                    if(titleOverFlowShowEllipsis) LunaUI.TEXT_ELLIPSIS,
                ].join()
                : data.categories[value.truncate()].toUpperCase(),
            getTextStyles: (_) => TextStyle(
                color: Colors.white30,
                fontSize: LunaUI.FONT_SIZE_GRAPH_LEGEND,
            ),
        ),
    );

    Widget createLegend(List<TautulliSeriesData> data) {
        return Container(
            child: Row(
                children: List.generate(
                    data.length,
                    (index) => Padding(
                        child: Row(
                            children: [
                                Padding(
                                    child: Container(
                                        height: LunaUI.FONT_SIZE_GRAPH_LEGEND,
                                        width: LunaUI.FONT_SIZE_GRAPH_LEGEND,
                                        decoration: BoxDecoration(
                                            color: LunaColours.graph(index),
                                            borderRadius: BorderRadius.circular(8.0),
                                        ),
                                    ),
                                    padding: EdgeInsets.only(right: 6.0),
                                ),
                                Text(
                                    data[index].name,
                                    style: TextStyle(
                                        fontSize: LunaUI.FONT_SIZE_GRAPH_LEGEND,
                                        color: LunaColours.graph(index),
                                    ),
                                ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                    ),
                ),
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
            ),
            height: LEGEND_HEIGHT,
        );
    }

    Widget loadingContainer(BuildContext context) {
        return LunaCard(
            context: context,
            child: Container(
                height: GRAPH_HEIGHT+LEGEND_HEIGHT,
                child: LunaLoader(),
            ),
        );
    }

    Widget errorContainer(BuildContext context) {
        return LunaCard(
            context: context,
            child: Container(
                height: GRAPH_HEIGHT+LEGEND_HEIGHT,
                alignment: Alignment.center,
                child: LunaIconButton(
                    icon: Icons.error,
                    iconSize: 60.0,
                    color: Colors.white12,
                ),
            ),
        );
    }
}
