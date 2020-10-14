import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliGraphHelper {
    static const GRAPH_HEIGHT = 225.0;
    static const LEGEND_HEIGHT = 26.0;
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
            getTextStyles: (_) => TextStyle(
                color: Colors.white30,
                fontSize: Constants.UI_FONT_SIZE_GRAPH_LEGEND,
            ),
        ),
    );

    static Widget createLegend(List<TautulliSeriesData> data) => Container(
        child: Row(
            children: List.generate(
                data.length,
                (index) => Padding(
                    child: Row(
                        children: [
                            Padding(
                                child: Container(
                                    height: Constants.UI_FONT_SIZE_GRAPH_LEGEND,
                                    width: Constants.UI_FONT_SIZE_GRAPH_LEGEND,
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
                                    fontSize: Constants.UI_FONT_SIZE_GRAPH_LEGEND,
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

    static Widget get loadingContainer => LSCard(
        child: Container(
            height: GRAPH_HEIGHT+LEGEND_HEIGHT,
            child: LSLoader(),
        ),
    );

    static Widget get errorContainer => LSCard(
        child: Container(
            height: GRAPH_HEIGHT+LEGEND_HEIGHT,
            alignment: Alignment.center,
            child: LSIconButton(
                icon: Icons.error,
                iconSize: 60.0,
                color: Colors.white12,
            ),
        ),
    );
}
