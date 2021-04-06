import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliMoreRoute extends StatefulWidget {
    TautulliMoreRoute({
        Key key,
    }): super(key: key);

    @override
    State<TautulliMoreRoute> createState() => _State();
}

class _State extends State<TautulliMoreRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return  LunaScaffold(
            scaffoldKey: _scaffoldKey,
            body: _body,
        );
    }

    Widget get _body {
        return LunaListView(
            controller: TautulliNavigationBar.scrollControllers[3],
            children: [
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Check for Updates'),
                    subtitle: LunaText.subtitle(text: 'Tautulli & Plex Updates'),
                    trailing: LunaIconButton(
                        icon: Icons.system_update_rounded,
                        color: LunaColours.list(0),
                    ),
                    onTap: () async => TautulliCheckForUpdatesRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Graphs'),
                    subtitle: LunaText.subtitle(text: 'Play Count & Duration Graphs'),
                    trailing: LunaIconButton(
                        icon: Icons.insert_chart_rounded,
                        color: LunaColours.list(1),
                    ),
                    onTap: () async => TautulliGraphsRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Libraries'),
                    subtitle: LunaText.subtitle(text: 'Plex Library Information'),
                    trailing: LunaIconButton(
                        icon: Icons.video_library_rounded,
                        color: LunaColours.list(2),
                    ),
                    onTap: () async => TautulliLibrariesRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Logs'),
                    subtitle: LunaText.subtitle(text: 'Tautulli & Plex Logs'),
                    trailing: LunaIconButton(
                        icon: Icons.developer_mode_rounded,
                        color: LunaColours.list(3),
                    ),
                    onTap: () async => TautulliLogsRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Recently Added'),
                    subtitle: LunaText.subtitle(text: 'Recently Added Content to Plex'),
                    trailing: LunaIconButton(
                        icon: Icons.recent_actors_rounded,
                        color: LunaColours.list(4),
                    ),
                    onTap: () async => TautulliRecentlyAddedRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Search'),
                    subtitle: LunaText.subtitle(text: 'Search Your Libraries'),
                    trailing: LunaIconButton(
                        icon: Icons.search_rounded,
                        color: LunaColours.list(5),
                    ),
                    onTap: () async => TautulliSearchRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Statistics'),
                    subtitle: LunaText.subtitle(text: 'User & Library Statistics'),
                    trailing: LunaIconButton(
                        icon: Icons.format_list_numbered_rounded,
                        color: LunaColours.list(6),
                    ),
                    onTap: () async => TautulliStatisticsRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Synced Items'),
                    subtitle: LunaText.subtitle(text: 'Synced Content on Devices'),
                    trailing: LunaIconButton(
                        icon: Icons.sync_rounded,
                        color: LunaColours.list(7),
                    ),
                    onTap: () async => TautulliSyncedItemsRouter().navigateTo(context),
                ),
            ],
        );
    }
}
