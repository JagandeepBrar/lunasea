import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsRouter extends TautulliPageRouter {
  TautulliLogsRouter() : super('/tautulli/logs');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}

class _Widget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
          onTap: () async => TautulliLogsLoginsRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'Newsletters',
          body: const [TextSpan(text: 'Tautulli Newsletter Logs')],
          trailing: LunaIconButton(
            icon: Icons.email_rounded,
            color: LunaColours().byListIndex(1),
          ),
          onTap: () async =>
              TautulliLogsNewslettersRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'Notifications',
          body: const [TextSpan(text: 'Tautulli Notification Logs')],
          trailing: LunaIconButton(
            icon: Icons.notifications_rounded,
            color: LunaColours().byListIndex(2),
          ),
          onTap: () async =>
              TautulliLogsNotificationsRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'Plex Media Scanner',
          body: const [TextSpan(text: 'Plex Media Scanner Logs')],
          trailing: LunaIconButton(
            icon: Icons.scanner_rounded,
            color: LunaColours().byListIndex(3),
          ),
          onTap: () async =>
              TautulliLogsPlexMediaScannerRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'Plex Media Server',
          body: const [TextSpan(text: 'Plex Media Server Logs')],
          trailing: LunaIconButton(
            icon: LunaBrandIcons.plex,
            color: LunaColours().byListIndex(4),
          ),
          onTap: () async =>
              TautulliLogsPlexMediaServerRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'Tautulli',
          body: const [TextSpan(text: 'Tautulli Logs')],
          trailing: LunaIconButton(
            icon: LunaBrandIcons.tautulli,
            color: LunaColours().byListIndex(5),
          ),
          onTap: () async => TautulliLogsTautulliRouter().navigateTo(context),
        ),
      ],
    );
  }
}
