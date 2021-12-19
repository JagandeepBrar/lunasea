import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLineGraphHelper {
  TautulliLineGraphHelper._();

  static FlTitlesData titlesData(TautulliGraphData data) => FlTitlesData(
        leftTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          margin: 8.0,
          reservedSize: 8.0,
          getTitles: (value) =>
              DateTime.tryParse((data.categories[value.truncate()])) != null
                  ? DateFormat('dd')
                      .format(
                          DateTime.parse((data.categories[value.truncate()])))
                      ?.toString()
                  : '??',
          getTextStyles: (_, __) => const TextStyle(
            color: Colors.white30,
            fontSize: LunaUI.FONT_SIZE_GRAPH_LEGEND,
          ),
        ),
      );

  static List<LineChartBarData> lineBarsData(TautulliGraphData data) =>
      List<LineChartBarData>.generate(
        data.series.length,
        (sIndex) => LineChartBarData(
          isCurved: true,
          isStrokeCapRound: true,
          barWidth: 3.0,
          colors: [LunaColours().byGraphLayer(sIndex)],
          spots: List<FlSpot>.generate(
            data.series[sIndex].data.length,
            (dIndex) => FlSpot(
                dIndex.toDouble(), data.series[sIndex].data[dIndex].toDouble()),
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [LunaColours().byGraphLayer(sIndex).withOpacity(0.20)],
          ),
          dotData: FlDotData(
            show: true,
            getDotPainter: (FlSpot spot, double xPercentage,
                    LineChartBarData bar, int index) =>
                FlDotCirclePainter(
              radius: 2.50,
              strokeColor: bar.colors[0],
              color: bar.colors[0],
            ),
          ),
        ),
      );

  static LineTouchData lineTouchData(
    BuildContext context,
    TautulliGraphData data,
  ) {
    return LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor:
            LunaTheme.isAMOLEDTheme ? Colors.black : LunaColours.primary,
        tooltipRoundedRadius: LunaUI.BORDER_RADIUS,
        tooltipPadding: const EdgeInsets.all(8.0),
        maxContentWidth: MediaQuery.of(context).size.width / 1.25,
        fitInsideVertically: true,
        fitInsideHorizontally: true,
        getTooltipItems: (List<LineBarSpot> spots) {
          return List<LineTooltipItem>.generate(
            spots.length,
            (index) {
              String name = data.series[index].name;
              int value = data.series[index].data[spots[index].spotIndex];
              return LineTooltipItem(
                [
                  '$name: ',
                  context.read<TautulliState>().graphYAxis ==
                          TautulliGraphYAxis.PLAYS
                      ? '${value ?? 0}'
                      : Duration(seconds: value ?? 0).lunaTimestampWords,
                ].join().trim(),
                const TextStyle(
                  color: LunaColours.grey,
                  fontSize: LunaUI.FONT_SIZE_SUBHEADER,
                ),
              );
            },
          );
        },
      ),
      getTouchedSpotIndicator: (bar, data) =>
          List<TouchedSpotIndicatorData>.generate(
        data.length,
        (index) => TouchedSpotIndicatorData(
          FlLine(
            strokeWidth: 3.0,
            color: bar.colors[0].withOpacity(0.50),
          ),
          FlDotData(
            show: true,
            getDotPainter: (FlSpot spot, double xPercentage,
                    LineChartBarData bar, int index) =>
                FlDotCirclePainter(
              radius: 5.0,
              strokeColor: bar.colors[0],
              color: bar.colors[0],
            ),
          ),
        ),
      ),
    );
  }
}
