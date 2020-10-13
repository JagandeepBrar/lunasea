import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

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
            getTitles: (value) => DateTime.tryParse((data.categories[value.truncate()])) != null
                ? DateFormat('dd').format(DateTime.parse((data.categories[value.truncate()])))?.toString()
                : '??',
            textStyle: TextStyle(
                color: Colors.white30,
                fontSize: Constants.UI_FONT_SIZE_GRAPH_LEGEND,
            ),
        ),
    );

    static List<LineChartBarData> lineBarsData(TautulliGraphData data) => List<LineChartBarData>.generate(
        data.series.length,
        (sIndex) => LineChartBarData(
            isCurved: true,
            isStrokeCapRound: true,
            barWidth: 3.0,
            colors: [LunaColours.graph(sIndex)],
            spots: List<FlSpot>.generate(
                data.series[sIndex].data.length,
                (dIndex) => FlSpot(dIndex.toDouble(), data.series[sIndex].data[dIndex].toDouble()),
            ),
            belowBarData: BarAreaData(
                show: true,
                colors: [LunaColours.graph(sIndex).withOpacity(0.20)],
            ),
            dotData: FlDotData(
                show: true,
                getDotPainter: (FlSpot spot, double xPercentage, LineChartBarData bar, int index) => FlDotCirclePainter(
                    radius: 2.50,
                    strokeColor: bar.colors[0],
                    color: bar.colors[0],
                ),
            ),
        ),
    );

    static LineTouchData lineTouchData(BuildContext context, TautulliGraphData data) => LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: LunaSeaDatabaseValue.THEME_AMOLED.data ? Colors.black : LunaColours.primary,
            tooltipRoundedRadius: Constants.UI_BORDER_RADIUS,
            tooltipPadding: EdgeInsets.all(8.0),
            maxContentWidth: MediaQuery.of(context).size.width/1.25,
            fitInsideVertically: true,
            fitInsideHorizontally: true,
            getTooltipItems: (List<LineBarSpot> spots) => List<LineTooltipItem>.generate(
                spots.length,
                (index) => LineTooltipItem(
                    [
                        '${data.series[spots[index].barIndex].name}: ',
                        context.read<TautulliState>().graphYAxis == TautulliGraphYAxis.PLAYS
                            ? '${spots[index]?.y?.truncate() ?? 0}'
                            : '${Duration(seconds: spots[index]?.y?.truncate() ?? 0).lsDuration_fullTimestamp()}',
                    ].join().trim(),
                    TextStyle(
                        color: Colors.white70,
                        fontSize: Constants.UI_FONT_SIZE_SUBHEADER,
                    ),
                ),
            ),
        ),
        getTouchedSpotIndicator: (bar, data) => List<TouchedSpotIndicatorData>.generate(
            data.length,
            (index) => TouchedSpotIndicatorData(
                FlLine(
                    strokeWidth: 3.0,
                    color: bar.colors[0].withOpacity(0.50),
                ),
                FlDotData(
                    show: true,
                    getDotPainter: (FlSpot spot, double xPercentage, LineChartBarData bar, int index) => FlDotCirclePainter(
                        radius: 5.0,
                        strokeColor: bar.colors[0],
                        color: bar.colors[0],
                    ),
                ),
            ),
        ),
    );
}
