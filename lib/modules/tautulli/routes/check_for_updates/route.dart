import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class CheckForUpdatesRoute extends StatefulWidget {
  const CheckForUpdatesRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CheckForUpdatesRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TautulliCheckForUpdatesState(context),
      builder: (context, _) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar() as PreferredSizeWidget?,
        body: _body(context),
      ),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Check for Updates',
      scrollControllers: [scrollController],
    );
  }

  Widget _body(BuildContext context) {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async =>
          context.read<TautulliCheckForUpdatesState>().fetchAllUpdates(context),
      child: FutureBuilder(
        future: Future.wait([
          context.watch<TautulliCheckForUpdatesState>().plexMediaServer!,
          context.watch<TautulliCheckForUpdatesState>().tautulli!,
        ]),
        builder: (context, AsyncSnapshot<List<Object>> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              LunaLogger().error(
                'Unable to fetch updates',
                snapshot.error,
                snapshot.stackTrace,
              );
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData)
            return _list(snapshot.data![0] as TautulliPMSUpdate,
                snapshot.data![1] as TautulliUpdateCheck);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(TautulliPMSUpdate pms, TautulliUpdateCheck tautulli) {
    return LunaListView(
      controller: scrollController,
      children: [
        TautulliCheckForUpdatesPMSTile(update: pms),
        TautulliCheckForUpdatesTautulliTile(update: tautulli),
      ],
    );
  }
}
