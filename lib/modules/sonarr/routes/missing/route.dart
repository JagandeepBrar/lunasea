import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrMissingRoute extends StatefulWidget {
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
    _state.resetMissing();
    await _state.missing;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body(),
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: Selector<SonarrState, Future<SonarrMissing>>(
        selector: (_, state) => state.missing,
        builder: (context, future, _) => FutureBuilder(
          future: future,
          builder: (context, AsyncSnapshot<SonarrMissing> snapshot) {
            if (snapshot.hasError) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                LunaLogger().error('Unable to fetch Sonarr missing episodes',
                    snapshot.error, snapshot.stackTrace);
              }
              return LunaMessage.error(onTap: _refreshKey.currentState?.show);
            }
            if (snapshot.hasData) return _episodes(snapshot.data);
            return const LunaLoader();
          },
        ),
      ),
    );
  }

  Widget _episodes(SonarrMissing missing) {
    if ((missing?.records?.length ?? 0) == 0)
      return LunaMessage(
        text: 'No Episodes Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState?.show,
      );
    return LunaListView(
      controller: SonarrNavigationBar.scrollControllers[2],
      children: List.generate(
        missing.records.length,
        (index) => SonarrMissingTile(record: missing.records[index]),
      ),
    );
  }
}
