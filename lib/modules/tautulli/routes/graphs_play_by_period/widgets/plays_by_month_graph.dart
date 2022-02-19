import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliGraphsPlaysByMonthGraph extends StatelessWidget {
  const TautulliGraphsPlaysByMonthGraph({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Selector<TautulliState, Future<TautulliGraphData>?>(
        selector: (_, state) => state.playsByMonthGraph,
        builder: (context, future, _) => FutureBuilder(
          future: future,
          builder: (context, AsyncSnapshot<TautulliGraphData> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                LunaLogger().error(
                    'Unable to fetch Tautulli graph data: getPlaysByMonth',
                    snapshot.error,
                    snapshot.stackTrace);
              }
              return TautulliGraphHelper().errorContainer(context);
            }
            if (snapshot.hasData) return _graph(context, snapshot.data!);
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
                  titlesData: TautulliGraphHelper().titlesData(data,
                      maxTitleLength: 3, titleOverFlowShowEllipsis: false),
                  borderData: TautulliGraphHelper().borderData(),
                  barGroups: TautulliBarGraphHelper.barGroups(context, data),
                  barTouchData:
                      TautulliBarGraphHelper.barTouchData(context, data),
                ),
              ),
              padding: LunaUI.MARGIN_DEFAULT,
            ),
          ),
          TautulliGraphHelper().createLegend(data.series!),
        ],
      ),
    );
  }
}
