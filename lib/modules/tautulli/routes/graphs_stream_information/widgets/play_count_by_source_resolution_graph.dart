import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliGraphsPlayCountBySourceResolutionGraph extends StatelessWidget {
  const TautulliGraphsPlayCountBySourceResolutionGraph({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Selector<TautulliState, Future<TautulliGraphData>>(
        selector: (_, state) => state.playCountBySourceResolutionGraph,
        builder: (context, future, _) => FutureBuilder(
          future: future,
          builder: (context, AsyncSnapshot<TautulliGraphData> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                LunaLogger().error(
                    'Unable to fetch Tautulli graph data: getPlaysBySourceResolution',
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
              child: BarChart(
                BarChartData(
                  alignment: TautulliGraphHelper().chartAlignment(),
                  gridData: TautulliGraphHelper().gridData(),
                  titlesData: TautulliGraphHelper().titlesData(data),
                  borderData: TautulliGraphHelper().borderData(),
                  barGroups: TautulliBarGraphHelper.barGroups(context, data),
                  barTouchData:
                      TautulliBarGraphHelper.barTouchData(context, data),
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
