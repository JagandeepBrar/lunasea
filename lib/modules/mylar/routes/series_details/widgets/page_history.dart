import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesDetailsHistoryPage extends StatefulWidget {
  const MylarSeriesDetailsHistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MylarSeriesDetailsHistoryPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.SONARR,
      body: _body(),
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async =>
          context.read<MylarSeriesDetailsState>().fetchHistory(context),
      child: FutureBuilder(
        future: context.select<MylarSeriesDetailsState,
            Future<List<MylarHistoryRecord>>?>((s) => s.history),
        builder: (context, AsyncSnapshot<List<MylarHistoryRecord>> snapshot) {
          if (snapshot.hasError) {
            LunaLogger().error(
              'Unable to fetch Mylar series history: ${context.read<MylarSeriesDetailsState>().series.id}',
              snapshot.error,
              snapshot.stackTrace,
            );
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) return _list(snapshot.data);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(List<MylarHistoryRecord>? history) {
    if ((history?.length ?? 0) == 0)
      return LunaMessage(
        text: 'mylar.NoHistoryFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    return LunaListViewBuilder(
      controller: MylarSeriesDetailsNavigationBar.scrollControllers[2],
      itemCount: history!.length,
      itemBuilder: (context, index) => MylarHistoryTile(
        history: history[index],
        type: MylarHistoryTileType.SERIES,
      ),
    );
  }
}
