import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliGraphsPlayCountByDateGraph extends StatelessWidget {
    static const double _height = 250.0;

    @override
    Widget build(BuildContext context) => Selector<TautulliLocalState, Future<TautulliGraphData>>(
        selector: (_, state) => state.playCountByDateGraph,
        builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<TautulliGraphData> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        Logger.error(
                            'TautulliGraphsPlayCountByDateGraph',
                            '_body',
                            'Unable to fetch Tautulli graph data: getPlaysByDate',
                            snapshot.error,
                            StackTrace.current,
                            uploadToSentry: !(snapshot.error is DioError),
                        );
                    }
                    return _error;
                }
                if(snapshot.hasData) return _graph(context, snapshot.data);
                return _loading;
            },
        ),
    );


    Widget _graph(BuildContext context, TautulliGraphData data) {
        return LSCard(
            child: Container(
                height: _height,
                child: Padding(
                    child: LineChart(
                        LineChartData(
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(
                                leftTitles: SideTitles(showTitles: false),
                                rightTitles: SideTitles(showTitles: false),
                                topTitles: SideTitles(showTitles: false),
                                bottomTitles: SideTitles(
                                    showTitles: true,
                                    margin: 26.0,
                                    rotateAngle: -90.0,
                                    getTitles: (value) => DateTime.tryParse((data.categories[value.truncate()])) != null
                                        ? DateFormat('MM/dd').format(DateTime.parse((data.categories[value.truncate()])))?.toString()
                                        : '??/??',
                                    textStyle: TextStyle(
                                        color: Colors.white30,
                                        fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                    ),
                                ),
                            ),
                            borderData: FlBorderData(
                                show: true,
                                border: Border.all(color: Colors.white12),
                            ),
                            lineBarsData: List<LineChartBarData>.generate(
                                data.series.length,
                                (sIndex) => LineChartBarData(
                                    isCurved: true,
                                    isStrokeCapRound: true,
                                    barWidth: 3.0,
                                    colors: [LSColors.list(sIndex)],
                                    spots: List<FlSpot>.generate(
                                        data.series[sIndex].data.length,
                                        (dIndex) => FlSpot(dIndex.toDouble(), data.series[sIndex].data[dIndex].toDouble()),
                                    ),
                                    belowBarData: BarAreaData(
                                        show: true,
                                        colors: [LSColors.list(sIndex).withOpacity(0.20)],
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
                            ),
                            lineTouchData: LineTouchData(
                                enabled: true,
                                touchTooltipData: LineTouchTooltipData(
                                    tooltipBgColor: LunaSeaDatabaseValue.THEME_AMOLED.data ? Colors.black : LSColors.primary,
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
                                                Provider.of<TautulliState>(context, listen: false).graphYAxis == TautulliGraphYAxis.PLAYS
                                                    ? '${spots[index]?.y?.truncate() ?? 0}'
                                                    : '${Duration(seconds: spots[index]?.y?.truncate() ?? 0).lsDuration_fullTimestamp()}',
                                            ].join().trim(),
                                            TextStyle(
                                                color: LSColors.list(index),
                                                fontWeight: FontWeight.w600,
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
                            ),
                        ),
                    ),
                    padding: EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 2.0),
                ),
            ),
        );
    }

    Widget get _loading => LSCard(
        child: Container(
            height: _height,
            child: LSLoader(),
        ),
    );

    Widget get _error => LSCard(
        child: Container(
            height: _height,
            alignment: Alignment.center,
            child: LSIconButton(
                icon: Icons.error,
                iconSize: 60.0,
                color: Colors.white12,
            ),
        ),
    );
}
