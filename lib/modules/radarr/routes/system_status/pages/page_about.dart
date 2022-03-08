import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrSystemStatusAboutPage extends StatefulWidget {
  final ScrollController scrollController;

  const RadarrSystemStatusAboutPage({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrSystemStatusAboutPage>
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
      body: _body(),
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: () async =>
          context.read<RadarrSystemStatusState>().fetchStatus(context),
      child: FutureBuilder(
        future: context.watch<RadarrSystemStatusState>().status,
        builder: (context, AsyncSnapshot<RadarrSystemStatus> snapshot) {
          if (snapshot.hasError) {
            LunaLogger().error('Unable to fetch Radarr system status',
                snapshot.error, snapshot.stackTrace);
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) return _list(snapshot.data!);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(RadarrSystemStatus status) {
    return LunaListView(
      controller: RadarrSystemStatusNavigationBar.scrollControllers[0],
      children: [
        LunaTableCard(
          content: [
            LunaTableContent(title: 'Version', body: status.lunaVersion),
            if (status.lunaIsDocker)
              LunaTableContent(
                title: 'Package',
                body: status.lunaPackageVersion,
              ),
            LunaTableContent(title: '.NET Core', body: status.lunaNetCore),
            LunaTableContent(title: 'Migration', body: status.lunaDBMigration),
            LunaTableContent(
                title: 'AppData', body: status.lunaAppDataDirectory),
            LunaTableContent(
                title: 'Startup', body: status.lunaStartupDirectory),
            LunaTableContent(title: 'mode', body: status.lunaMode),
            LunaTableContent(title: 'uptime', body: status.lunaUptime),
          ],
        ),
      ],
    );
  }
}
