import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrMissingRoute extends StatefulWidget {
  const SonarrMissingRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SonarrMissingRoute> createState() => _State();
}

class _State extends State<SonarrMissingRoute>
    with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> loadCallback() async {
    SonarrState _state = Provider.of<SonarrState>(context, listen: false);
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
      child: Selector<SonarrState,
          Tuple2<Future<Map<int, SonarrSeries>>?, Future<SonarrMissing>?>>(
        selector: (_, state) => Tuple2(state.series, state.missing),
        builder: (context, tuple, _) => FutureBuilder(
          future: Future.wait([tuple.item1!, tuple.item2!]),
          builder: (context, AsyncSnapshot<List<Object>> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                LunaLogger().error(
                  'Unable to fetch Sonarr missing episodes',
                  snapshot.error,
                  snapshot.stackTrace,
                );
              }
              return LunaMessage.error(onTap: _refreshKey.currentState!.show);
            }
            if (snapshot.hasData)
              return _episodes(
                snapshot.data![0] as Map<int, SonarrSeries>,
                snapshot.data![1] as SonarrMissing,
              );
            return const LunaLoader();
          },
        ),
      ),
    );
  }

  Widget _episodes(Map<int, SonarrSeries> series, SonarrMissing missing) {
    if ((missing.records?.length ?? 0) == 0)
      return LunaMessage(
        text: 'sonarr.NoEpisodesFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState?.show,
      );
    return LunaListViewBuilder(
      controller: SonarrNavigationBar.scrollControllers[2],
      itemCount: missing.records!.length,
      itemExtent: SonarrMissingTile.itemExtent,
      itemBuilder: (context, index) => SonarrMissingTile(
        record: missing.records![index],
        series: series[missing.records![index].seriesId!],
      ),
    );
  }
}
