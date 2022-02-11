import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrMissingRoute extends StatefulWidget {
  const ReadarrMissingRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ReadarrMissingRoute> createState() => _State();
}

class _State extends State<ReadarrMissingRoute>
    with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> loadCallback() async {
    ReadarrState _state = Provider.of<ReadarrState>(context, listen: false);
    _state.fetchMissing();
    await _state.missing;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.READARR,
      hideDrawer: true,
      body: _body(),
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: Selector<ReadarrState,
          Tuple2<Future<Map<int, ReadarrAuthor>>?, Future<ReadarrMissing>?>>(
        selector: (_, state) => Tuple2(state.authors, state.missing),
        builder: (context, tuple, _) => FutureBuilder(
          future: Future.wait([tuple.item1!, tuple.item2!]),
          builder: (context, AsyncSnapshot<List<Object>> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                LunaLogger().error(
                  'Unable to fetch Readarr missing episodes',
                  snapshot.error,
                  snapshot.stackTrace,
                );
              }
              return LunaMessage.error(onTap: _refreshKey.currentState!.show);
            }
            if (snapshot.hasData)
              return _episodes(
                snapshot.data![0] as Map<int, ReadarrAuthor>,
                snapshot.data![1] as ReadarrMissing,
              );
            return const LunaLoader();
          },
        ),
      ),
    );
  }

  Widget _episodes(Map<int, ReadarrAuthor> series, ReadarrMissing missing) {
    if ((missing.records?.length ?? 0) == 0)
      return LunaMessage(
        text: 'readarr.NoEpisodesFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState?.show,
      );
    return LunaListViewBuilder(
      controller: ReadarrNavigationBar.scrollControllers[2],
      itemCount: missing.records!.length,
      itemExtent: ReadarrMissingTile.itemExtent,
      itemBuilder: (context, index) => ReadarrMissingTile(
        record: missing.records![index],
        series: series[missing.records![index].authorId!],
      ),
    );
  }
}
