import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsConfigurationQuickActionsRouter extends LunaPageRouter {
    static const ROUTE_NAME = '/settings/configuration/quickactions';

    Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        ROUTE_NAME,
    );

    String route(List parameters) => ROUTE_NAME;
    
    void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _Widget()),
        transitionType: LunaRouter.transitionType,
    );
}

class _Widget extends StatefulWidget {
    @override
    State<_Widget> createState() => _State();
}

class _State extends State<_Widget> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final _helpMessage = [
        'Quick actions allow you to quickly jump into modules directly from the home screen or launcher on your device by long pressing ${Constants.APPLICATION_NAME}\'s icon.',
        'A limited number of quick actions can be set at a time, and enabling more than your launcher can support will have no effect.'
    ].join('\n\n');

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Quick Actions',
        actions: [
            LSIconButton(
                icon: Icons.help_outline,
                onPressed: () async => LunaDialogs.textPreview(context, 'Help', _helpMessage),
            )
        ],
    );

    Widget get _body => LSListView(
        children: [
            _actionTile('Search', LunaSeaDatabaseValue.QUICK_ACTIONS_SEARCH),
            LSDivider(),
            _actionTile('Lidarr', LunaSeaDatabaseValue.QUICK_ACTIONS_LIDARR),
            _actionTile('Radarr', LunaSeaDatabaseValue.QUICK_ACTIONS_RADARR),
            _actionTile('Sonarr', LunaSeaDatabaseValue.QUICK_ACTIONS_SONARR),
            LSDivider(),
            _actionTile('NZBGet', LunaSeaDatabaseValue.QUICK_ACTIONS_NZBGET),
            _actionTile('SABnzbd', LunaSeaDatabaseValue.QUICK_ACTIONS_SABNZBD),
            LSDivider(),
            _actionTile('Tautulli', LunaSeaDatabaseValue.QUICK_ACTIONS_TAUTULLI),
        ],
    );

    Widget _actionTile(String title, LunaSeaDatabaseValue action) => LSCardTile(
        title: LSTitle(text: title),
        trailing: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [action.key]),
            builder: (context, box, _) => Switch(
                value: action.data,
                onChanged: (value) {
                    action.put(value);
                    LunaQuickActions.setShortcutItems();
                }
            ),
        ),
    );
}
