import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/router/routes/tautulli.dart';

class TautulliMoreRoute extends StatefulWidget {
  const TautulliMoreRoute({
    Key? key,
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
      module: LunaModule.TAUTULLI,
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
          onTap: TautulliRoutes.CHECK_FOR_UPDATES.go,
        ),
        LunaBlock(
          title: 'Graphs',
          body: const [TextSpan(text: 'Play Count & Duration Graphs')],
          trailing: LunaIconButton(
            icon: Icons.insert_chart_rounded,
            color: LunaColours().byListIndex(1),
          ),
          onTap: TautulliRoutes.GRAPHS.go,
        ),
        LunaBlock(
          title: 'Libraries',
          body: const [TextSpan(text: 'Plex Library Information')],
          trailing: LunaIconButton(
            icon: Icons.video_library_rounded,
            color: LunaColours().byListIndex(2),
          ),
          onTap: TautulliRoutes.LIBRARIES.go,
        ),
        LunaBlock(
          title: 'Logs',
          body: const [TextSpan(text: 'Tautulli & Plex Logs')],
          trailing: LunaIconButton(
            icon: Icons.developer_mode_rounded,
            color: LunaColours().byListIndex(3),
          ),
          onTap: TautulliRoutes.LOGS.go,
        ),
        LunaBlock(
          title: 'Recently Added',
          body: const [TextSpan(text: 'Recently Added Content to Plex')],
          trailing: LunaIconButton(
            icon: Icons.recent_actors_rounded,
            color: LunaColours().byListIndex(4),
          ),
          onTap: TautulliRoutes.RECENTLY_ADDED.go,
        ),
        LunaBlock(
          title: 'Search',
          body: const [TextSpan(text: 'Search Your Libraries')],
          trailing: LunaIconButton(
            icon: Icons.search_rounded,
            color: LunaColours().byListIndex(5),
          ),
          onTap: TautulliRoutes.SEARCH.go,
        ),
        LunaBlock(
          title: 'Statistics',
          body: const [TextSpan(text: 'User & Library Statistics')],
          trailing: LunaIconButton(
            icon: Icons.format_list_numbered_rounded,
            color: LunaColours().byListIndex(6),
          ),
          onTap: TautulliRoutes.STATISTICS.go,
        ),
        LunaBlock(
          title: 'Synced Items',
          body: const [TextSpan(text: 'Synced Content on Devices')],
          trailing: LunaIconButton(
            icon: Icons.sync_rounded,
            color: LunaColours().byListIndex(7),
          ),
          onTap: TautulliRoutes.SYNCED_ITEMS.go,
        ),
      ],
    );
  }
}
