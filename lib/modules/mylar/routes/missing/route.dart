import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarMissingRoute extends StatefulWidget {
  const MylarMissingRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<MylarMissingRoute> createState() => _State();
}

class _State extends State<MylarMissingRoute>
    with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> loadCallback() async {
    MylarState _state = Provider.of<MylarState>(context, listen: false);
    _state.fetchMissing();
    await _state.missing;
  }

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
      onRefresh: loadCallback,
      child: Selector<MylarState,
          Tuple2<Future<Map<int, MylarSeries>>?, Future<MylarMissing>?>>(
        selector: (_, state) => Tuple2(state.series, state.missing),
        builder: (context, tuple, _) => FutureBuilder(
          future: Future.wait([tuple.item1!, tuple.item2!]),
          builder: (context, AsyncSnapshot<List<Object>> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                LunaLogger().error(
                  'Unable to fetch Mylar missing episodes',
                  snapshot.error,
                  snapshot.stackTrace,
                );
              }
              return LunaMessage.error(onTap: _refreshKey.currentState!.show);
            }
            if (snapshot.hasData)
              return _episodes(
                snapshot.data![0] as Map<int, MylarSeries>,
                snapshot.data![1] as MylarMissing,
              );
            return const LunaLoader();
          },
        ),
      ),
    );
  }

  Widget _episodes(Map<int, MylarSeries> series, MylarMissing missing) {
    if ((missing.records?.length ?? 0) == 0)
      return LunaMessage(
        text: 'mylar.NoEpisodesFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState?.show,
      );
    return LunaListViewBuilder(
      controller: MylarNavigationBar.scrollControllers[2],
      itemCount: missing.records!.length,
      itemExtent: MylarMissingTile.itemExtent,
      itemBuilder: (context, index) => MylarMissingTile(
        record: missing.records![index],
        series: series[missing.records![index].seriesId!],
      ),
    );
  }
}
