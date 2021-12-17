import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMoreRoute extends StatefulWidget {
  const TautulliMoreRoute({
    Key key,
  }) : super(key: key);

  @override
  State<TautulliMoreRoute> createState() => _State();
}

class _State extends State<TautulliMoreRoute>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body,
    );
  }

  Widget get _body {
    return LunaListView(
      controller: TautulliNavigationBar.scrollControllers[3],
      children: [
        LunaBlock(
          title: 'Check for Updates',
          body: const [TextSpan(text: 'Tautulli & Plex Updates')],
          trailing: LunaIconButton(
            icon: Icons.system_update_rounded,
            color: LunaColours().byListIndex(0),
          ),
          onTap: () async =>
              TautulliCheckForUpdatesRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'Graphs',
          body: const [TextSpan(text: 'Play Count & Duration Graphs')],
          trailing: LunaIconButton(
            icon: Icons.insert_chart_rounded,
            color: LunaColours().byListIndex(1),
          ),
          onTap: () async => TautulliGraphsRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'Libraries',
          body: const [TextSpan(text: 'Plex Library Information')],
          trailing: LunaIconButton(
            icon: Icons.video_library_rounded,
            color: LunaColours().byListIndex(2),
          ),
          onTap: () async => TautulliLibrariesRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'Logs',
          body: const [TextSpan(text: 'Tautulli & Plex Logs')],
          trailing: LunaIconButton(
            icon: Icons.developer_mode_rounded,
            color: LunaColours().byListIndex(3),
          ),
          onTap: () async => TautulliLogsRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'Recently Added',
          body: const [TextSpan(text: 'Recently Added Content to Plex')],
          trailing: LunaIconButton(
            icon: Icons.recent_actors_rounded,
            color: LunaColours().byListIndex(4),
          ),
          onTap: () async => TautulliRecentlyAddedRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'Search',
          body: const [TextSpan(text: 'Search Your Libraries')],
          trailing: LunaIconButton(
            icon: Icons.search_rounded,
            color: LunaColours().byListIndex(5),
          ),
          onTap: () async => TautulliSearchRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'Statistics',
          body: const [TextSpan(text: 'User & Library Statistics')],
          trailing: LunaIconButton(
            icon: Icons.format_list_numbered_rounded,
            color: LunaColours().byListIndex(6),
          ),
          onTap: () async => TautulliStatisticsRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'Synced Items',
          body: const [TextSpan(text: 'Synced Content on Devices')],
          trailing: LunaIconButton(
            icon: Icons.sync_rounded,
            color: LunaColours().byListIndex(7),
          ),
          onTap: () async => TautulliSyncedItemsRouter().navigateTo(context),
        ),
      ],
    );
  }
}
