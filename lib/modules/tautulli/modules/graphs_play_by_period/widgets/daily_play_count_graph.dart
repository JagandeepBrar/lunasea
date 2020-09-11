
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliGraphsDailyPlayCountGraph extends StatelessWidget {
    @override
    Widget build(BuildContext context) => Selector<TautulliLocalState, Future<TautulliGraphData>>(
        selector: (_, state) => state.dailyPlayCountGraph,
        builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<TautulliGraphData> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        Logger.error(
                            'TautulliGraphsDailyPlayCountGraph',
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
                height: TautulliGraphHelper.GRAPH_SIZE,
                child: Padding(
                    child: LineChart(
                        LineChartData(
                            gridData: TautulliGraphHelper.gridData(),
                            titlesData: TautulliLineGraphHelper.titlesData(data),
                            borderData: TautulliGraphHelper.borderData(),
                            lineBarsData: TautulliLineGraphHelper.lineBarsData(data),
                            lineTouchData: TautulliLineGraphHelper.lineTouchData(context, data),
                        ),
                    ),
                    padding: EdgeInsets.all(14.0),
                ),
            ),
        );
    }

    Widget get _loading => LSCard(
        child: Container(
            height: TautulliGraphHelper.GRAPH_SIZE,
            child: LSLoader(),
        ),
    );

    Widget get _error => LSCard(
        child: Container(
            height: TautulliGraphHelper.GRAPH_SIZE,
            alignment: Alignment.center,
            child: LSIconButton(
                icon: Icons.error,
                iconSize: 60.0,
                color: Colors.white12,
            ),
        ),
    );
}
