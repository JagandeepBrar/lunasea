import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsRouter extends TautulliPageRouter {
    TautulliLogsRouter() : super('/tautulli/logs');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _TautulliLogsRoute());
}

class _TautulliLogsRoute extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<_TautulliLogsRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    
    @override
    Widget build(BuildContext context) {
        return  LunaScaffold(
            scaffoldKey: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Logs',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Logins'),
                    subtitle: LunaText.subtitle(text: 'Tautulli Login Logs'),
                    trailing: LunaIconButton(
                        icon: Icons.vpn_key_rounded,
                        color: LunaColours().byListIndex(0),
                    ),
                    onTap: () async => TautulliLogsLoginsRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Newsletters'),
                    subtitle: LunaText.subtitle(text: 'Tautulli Newsletter Logs'),
                    trailing: LunaIconButton(
                        icon: Icons.email_rounded,
                        color: LunaColours().byListIndex(1),
                    ),
                    onTap: () async => TautulliLogsNewslettersRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Notifications'),
                    subtitle: LunaText.subtitle(text: 'Tautulli Notification Logs'),
                    trailing: LunaIconButton(
                        icon: Icons.notifications_rounded,
                        color: LunaColours().byListIndex(2),
                    ),
                    onTap: () async => TautulliLogsNotificationsRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Plex Media Scanner'),
                    subtitle: LunaText.subtitle(text: 'Plex Media Scanner Logs'),
                    trailing: LunaIconButton(
                        icon: Icons.scanner_rounded,
                        color: LunaColours().byListIndex(3),
                    ),
                    onTap: () async => TautulliLogsPlexMediaScannerRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Plex Media Server'),
                    subtitle: LunaText.subtitle(text: 'Plex Media Server Logs'),
                    trailing: LunaIconButton(
                        icon: LunaIcons.plex,
                        color: LunaColours().byListIndex(4),
                    ),
                    onTap: () async => TautulliLogsPlexMediaServerRouter().navigateTo(context),
                ),
                LunaListTile(
                    context: context,
                    title: LunaText.title(text: 'Tautulli'),
                    subtitle: LunaText.subtitle(text: 'Tautulli Logs'),
                    trailing: LunaIconButton(
                        icon: LunaIcons.tautulli,
                        color: LunaColours().byListIndex(5),
                    ),
                    onTap: () async => TautulliLogsTautulliRouter().navigateTo(context),
                ),
            ],
        );
    }
}
