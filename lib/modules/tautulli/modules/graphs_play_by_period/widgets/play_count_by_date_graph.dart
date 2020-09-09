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
        int _hAxisInterval = (largestValue(data)-1) ~/ 4;
        return LSCard(
            child: Container(
                height: _height,
                child: Padding(
                    child: LineChart(
                        LineChartData(
                            gridData: FlGridData(
                                horizontalInterval: _hAxisInterval <= 1 ? 1 : _hAxisInterval.toDouble(),
                                getDrawingHorizontalLine: (value) => FlLine(
                                    color: Colors.white12,
                                    strokeWidth: 1.0,
                                ),
                            ),
                            titlesData: FlTitlesData(
                                leftTitles: SideTitles(showTitles: false),
                                rightTitles: SideTitles(showTitles: false),
                                topTitles: SideTitles(showTitles: false),
                                bottomTitles: SideTitles(
                                    showTitles: true,
                                    margin: 30.0,
                                    rotateAngle: -90.0,
                                    getTitles: (value) => DateTime.tryParse((data.categories[value.truncate()])) != null
                                        ? DateFormat('MM/dd').format(DateTime.parse((data.categories[value.truncate()])))?.toString()
                                        : '??/??',
                                    textStyle: TextStyle(
                                        color: Colors.white30,
                                    ),
                                ),
                            ),
                            borderData: FlBorderData(
                                show: true,
                                border: Border(
                                    bottom: BorderSide(color: Colors.transparent),
                                    left: BorderSide(color: Colors.transparent),
                                    right: BorderSide(color: Colors.transparent),
                                    top: BorderSide(color: Colors.transparent),
                                ),
                            ),
                            lineBarsData: List<LineChartBarData>.generate(
                                data.series.length,
                                (sIndex) => LineChartBarData(
                                    spots: List<FlSpot>.generate(
                                        data.series[sIndex].data.length,
                                        (dIndex) => FlSpot(dIndex.toDouble(), data.series[sIndex].data[dIndex].toDouble()),
                                    ),
                                    colors: [_color(data.series[sIndex].name)],
                                    isCurved: true,
                                    belowBarData: BarAreaData(
                                        show: true,
                                        colors: [_color(data.series[sIndex].name).withOpacity(0.20)],
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
                                    getTooltipItems: (List<LineBarSpot> spots) => List<LineTooltipItem>.generate(
                                        spots.length,
                                        (index) => LineTooltipItem(
                                            [
                                                '${_nameFromIndex(spots[index].barIndex)}: ',
                                                Provider.of<TautulliState>(context, listen: false).graphYAxis == TautulliGraphYAxis.PLAYS
                                                    ? '${spots[index]?.y?.truncate() ?? 0}'
                                                    : '${Duration(seconds: spots[index]?.y?.truncate() ?? 0).lsDuration_fullTimestamp()}',
                                            ].join(),
                                            TextStyle(
                                                color: spots[index].bar.colors[0],
                                                fontWeight: FontWeight.w600,
                                            ),
                                        ),
                                    ),
                                    fitInsideVertically: true,
                                    fitInsideHorizontally: true,
                                ),
                            ),
                        ),
                    ),
                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 6.0),
                ),
            ),
        );
    }

    Color _color(String name) {
        switch(name.toLowerCase()) {
            case 'tv': return LSColors.orange;
            case 'movies': return Colors.white;
            case 'music': return LSColors.red;
            default: return LSColors.accent;
        }
    }

    String _nameFromIndex(int index) {
        switch(index) {
            case 0: return 'Television';
            case 1: return 'Movies';
            case 2: return 'Music';
            default: return 'Unknown';
        }
    }

    int largestValue(TautulliGraphData data) {
        int _value = 0;
        data.series.forEach((series) => series.data.forEach((data) {
            if(data > _value) _value = data;
        }));
        return _value;
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
