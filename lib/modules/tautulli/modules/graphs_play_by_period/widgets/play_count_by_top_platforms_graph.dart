import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliGraphsPlayCountByTopPlatformsGraph extends StatelessWidget {
    static const double _height = 225.0;

    @override
    Widget build(BuildContext context) => Selector<TautulliLocalState, Future<TautulliGraphData>>(
        selector: (_, state) => state.playCountByTopPlatformsGraph,
        builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<TautulliGraphData> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        Logger.error(
                            'TautulliGraphsPlayCountByTopPlatformsGraph',
                            '_body',
                            'Unable to fetch Tautulli graph data: getPlaysByTopTenPlatforms',
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
                    child: BarChart(
                        BarChartData(
                            alignment: BarChartAlignment.spaceEvenly,
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(
                                leftTitles: SideTitles(showTitles: false),
                                rightTitles: SideTitles(showTitles: false),
                                topTitles: SideTitles(showTitles: false),
                                bottomTitles: SideTitles(
                                    showTitles: true,
                                    margin: 8.0,
                                    reservedSize: 8.0,
                                    getTitles: (value) => data.categories[value.truncate()].length > 6
                                        ? data.categories[value.truncate()].substring(0, 6).toUpperCase() + Constants.TEXT_ELLIPSIS
                                        : data.categories[value.truncate()].toUpperCase(),
                                    textStyle: TextStyle(
                                        color: Colors.white30,
                                        fontSize: Constants.UI_FONT_SIZE_GRAPH_LEGEND,
                                    ),
                                ),
                            ),
                            borderData: FlBorderData(
                                show: true,
                                border: Border.all(color: Colors.white12),
                            ),
                            barGroups: List<BarChartGroupData>.generate(
                                data.categories.take(7).length,
                                (cIndex) => BarChartGroupData(
                                    x: cIndex,
                                    barRods: List<BarChartRodData>.generate(
                                        data.series.length,
                                        (sIndex) => BarChartRodData(
                                            width: 10.0,
                                            y: data.series[sIndex].data[cIndex].toDouble(),
                                            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
                                            color: LSColors.graph(sIndex),
                                        ),
                                    ),
                                ),
                            ),
                            barTouchData: BarTouchData(
                                enabled: true,
                                touchTooltipData: BarTouchTooltipData(
                                    tooltipBgColor: LunaSeaDatabaseValue.THEME_AMOLED.data ? Colors.black : LSColors.primary,
                                    tooltipRoundedRadius: Constants.UI_BORDER_RADIUS,
                                    tooltipPadding: EdgeInsets.all(8.0),
                                    maxContentWidth: MediaQuery.of(context).size.width/1.25,
                                    fitInsideVertically: true,
                                    fitInsideHorizontally: true,
                                    getTooltipItem: (group, gIndex, rod, rIndex) => BarTooltipItem(
                                        [
                                            '${data.categories[gIndex]}\n\n',
                                            '${data.series[rIndex].name}: ',
                                            Provider.of<TautulliState>(context, listen: false).graphYAxis == TautulliGraphYAxis.PLAYS
                                                ? '${data.series[rIndex].data[gIndex] ?? 0}'
                                                : '${Duration(seconds: data.series[rIndex].data[gIndex] ?? 0).lsDuration_fullTimestamp()}',
                                        ].join().trim(),
                                        TextStyle(
                                            color: Colors.white70,
                                            fontSize: Constants.UI_FONT_SIZE_SUBHEADER,
                                        ),
                                    ),
                                ),
                            ),
                        ),
                    ),
                    padding: EdgeInsets.all(14.0),
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
