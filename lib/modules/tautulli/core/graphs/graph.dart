import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
        border: Border.all(color: LunaColours.white10),
      );

  FlTitlesData titlesData(
    TautulliGraphData data, {
    int maxTitleLength = DEFAULT_MAX_TITLE_LENGTH,
    bool titleOverFlowShowEllipsis = true,
  }) =>
      FlTitlesData(
        leftTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          margin: 8.0,
          reservedSize: 8.0,
          getTitles: (value) =>
              data.categories[value.truncate()].length > maxTitleLength + 1
                  ? [
                      data.categories[value.truncate()]
                          .substring(
                              0,
                              min(maxTitleLength,
                                  data.categories[value.truncate()].length))
                          .toUpperCase(),
                      if (titleOverFlowShowEllipsis) LunaUI.TEXT_ELLIPSIS,
                    ].join()
                  : data.categories[value.truncate()].toUpperCase(),
          getTextStyles: (_, __) => const TextStyle(
            color: LunaColours.grey,
            fontSize: LunaUI.FONT_SIZE_GRAPH_LEGEND,
          ),
        ),
      );

  Widget createLegend(List<TautulliSeriesData> data) {
    return SizedBox(
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
                      color: LunaColours().byGraphLayer(index),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  padding: const EdgeInsets.only(right: 6.0),
                ),
                Text(
                  data[index].name,
                  style: TextStyle(
                    fontSize: LunaUI.FONT_SIZE_GRAPH_LEGEND,
                    color: LunaColours().byGraphLayer(index),
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
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
      child: const SizedBox(
        height: GRAPH_HEIGHT + LEGEND_HEIGHT,
        child: LunaLoader(),
      ),
    );
  }

  Widget errorContainer(BuildContext context) {
    return LunaCard(
      context: context,
      child: Container(
        height: GRAPH_HEIGHT + LEGEND_HEIGHT,
        alignment: Alignment.center,
        child: const LunaIconButton(
          icon: LunaIcons.ERROR,
          iconSize: LunaUI.ICON_SIZE * 2,
          color: LunaColours.red,
        ),
      ),
    );
  }
}
