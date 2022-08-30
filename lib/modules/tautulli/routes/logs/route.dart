import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/router/routes/tautulli.dart';

class LogsRoute extends StatefulWidget {
  const LogsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LogsRoute> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
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
        LunaBlock(
          title: 'Logins',
          body: const [TextSpan(text: 'Tautulli Login Logs')],
          trailing: LunaIconButton(
            icon: Icons.vpn_key_rounded,
            color: LunaColours().byListIndex(0),
          ),
          onTap: TautulliRoutes.LOGS_LOGINS.go,
        ),
        LunaBlock(
          title: 'Newsletters',
          body: const [TextSpan(text: 'Tautulli Newsletter Logs')],
          trailing: LunaIconButton(
            icon: Icons.email_rounded,
            color: LunaColours().byListIndex(1),
          ),
          onTap: TautulliRoutes.LOGS_NEWSLETTERS.go,
        ),
        LunaBlock(
          title: 'Notifications',
          body: const [TextSpan(text: 'Tautulli Notification Logs')],
          trailing: LunaIconButton(
            icon: Icons.notifications_rounded,
            color: LunaColours().byListIndex(2),
          ),
          onTap: TautulliRoutes.LOGS_NOTIFICATIONS.go,
        ),
        LunaBlock(
          title: 'Plex Media Scanner',
          body: const [TextSpan(text: 'Plex Media Scanner Logs')],
          trailing: LunaIconButton(
            icon: Icons.scanner_rounded,
            color: LunaColours().byListIndex(3),
          ),
          onTap: TautulliRoutes.LOGS_PLEX_MEDIA_SCANNER.go,
        ),
        LunaBlock(
          title: 'Plex Media Server',
          body: const [TextSpan(text: 'Plex Media Server Logs')],
          trailing: LunaIconButton(
            icon: LunaIcons.PLEX,
            iconSize: LunaUI.ICON_SIZE - 2.0,
            color: LunaColours().byListIndex(4),
          ),
          onTap: TautulliRoutes.LOGS_PLEX_MEDIA_SERVER.go,
        ),
        LunaBlock(
          title: 'Tautulli',
          body: const [TextSpan(text: 'Tautulli Logs')],
          trailing: LunaIconButton(
            icon: LunaIcons.TAUTULLI,
            color: LunaColours().byListIndex(5),
          ),
          onTap: TautulliRoutes.LOGS_TAUTULLI.go,
        ),
      ],
    );
  }
}
