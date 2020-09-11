import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliGraphsPlayCountByDayOfWeekGraph extends StatelessWidget {
    @override
    Widget build(BuildContext context) => Selector<TautulliLocalState, Future<TautulliGraphData>>(
        selector: (_, state) => state.playCountByDayOfWeekGraph,
        builder: (context, future, _) => FutureBuilder(
            future: future,
            builder: (context, AsyncSnapshot<TautulliGraphData> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        Logger.error(
                            'TautulliGraphsPlayCountByDayOfWeekGraph',
                            '_body',
                            'Unable to fetch Tautulli graph data: getPlaysByDayOfWeek',
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
                    child: BarChart(
                        BarChartData(
                            alignment: TautulliGraphHelper.chartAlignment(),
                            gridData: TautulliGraphHelper.gridData(),
                            titlesData: TautulliGraphHelper.titlesData(data, maxTitleLength: 3, titleOverFlowShowEllipsis: false),
                            borderData: TautulliGraphHelper.borderData(),
                            barGroups: TautulliBarGraphHelper.barGroups(context, data),
                            barTouchData: TautulliBarGraphHelper.barTouchData(context, data),
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
