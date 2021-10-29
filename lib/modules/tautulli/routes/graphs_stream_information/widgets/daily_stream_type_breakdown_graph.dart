import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliGraphsDailyStreamTypeBreakdownGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Selector<TautulliState, Future<TautulliGraphData>>(
        selector: (_, state) => state.dailyStreamTypeBreakdownGraph,
        builder: (context, future, _) => FutureBuilder(
          future: future,
          builder: (context, AsyncSnapshot<TautulliGraphData> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                LunaLogger().error(
                    'Unable to fetch Tautulli graph data: getPlaysByDate',
                    snapshot.error,
                    snapshot.stackTrace);
              }
              return TautulliGraphHelper().errorContainer(context);
            }
            if (snapshot.hasData) return _graph(context, snapshot.data);
            return TautulliGraphHelper().loadingContainer(context);
          },
        ),
      );

  Widget _graph(BuildContext context, TautulliGraphData data) {
    return LunaCard(
      context: context,
      child: Column(
        children: [
          SizedBox(
            height: TautulliGraphHelper.GRAPH_HEIGHT,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              child: LineChart(
                LineChartData(
                  gridData: TautulliGraphHelper().gridData(),
                  titlesData: TautulliLineGraphHelper.titlesData(data),
                  borderData: TautulliGraphHelper().borderData(),
                  lineBarsData: TautulliLineGraphHelper.lineBarsData(data),
                  lineTouchData:
                      TautulliLineGraphHelper.lineTouchData(context, data),
                ),
              ),
              padding: const EdgeInsets.all(14.0),
            ),
          ),
          TautulliGraphHelper().createLegend(data.series),
        ],
      ),
    );
  }
}
