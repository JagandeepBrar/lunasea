import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLibrariesRouter extends TautulliPageRouter {
  TautulliLibrariesRouter() : super('/tautulli/libraries');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget>
    with LunaScrollControllerMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> loadCallback() async {
    context.read<TautulliState>().resetLibrariesTable();
    await context.read<TautulliState>().librariesTable;
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Libraries',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      onRefresh: loadCallback,
      key: _refreshKey,
      child: Selector<TautulliState, Future<TautulliLibrariesTable>>(
        selector: (_, state) => state.librariesTable,
        builder: (context, future, _) => FutureBuilder(
          future: future,
          builder: (context, AsyncSnapshot<TautulliLibrariesTable> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting)
                LunaLogger().error(
                  'Unable to fetch Tautulli libraries table',
                  snapshot.error,
                  snapshot.stackTrace,
                );
              return LunaMessage.error(onTap: _refreshKey.currentState.show);
            }
            if (snapshot.hasData) return _libraries(snapshot.data);
            return LunaLoader();
          },
        ),
      ),
    );
  }

  Widget _libraries(TautulliLibrariesTable libraries) {
    if ((libraries?.libraries?.length ?? 0) == 0)
      return LunaMessage(
        text: 'No Libraries Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState?.show,
      );
    return LunaListViewBuilder(
      controller: scrollController,
      itemCount: libraries.libraries.length,
      itemBuilder: (context, index) =>
          TautulliLibrariesLibraryTile(library: libraries.libraries[index]),
    );
  }
}
