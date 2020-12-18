import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsConfigurationQuickActionsRouter extends LunaPageRouter {
    SettingsConfigurationQuickActionsRouter() : super('/settings/configuration/quickactions');

    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationQuickActionsRoute());
}

class _SettingsConfigurationQuickActionsRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationQuickActionsRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationQuickActionsRoute> {
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
                onPressed: () async => LunaDialogs().textPreview(context, 'Help', _helpMessage),
            )
        ],
    );

    Widget get _body => LSListView(
        children: [
            _actionTile('Search', LunaDatabaseValue.QUICK_ACTIONS_SEARCH),
            LSDivider(),
            _actionTile('Lidarr', LunaDatabaseValue.QUICK_ACTIONS_LIDARR),
            _actionTile('Radarr', LunaDatabaseValue.QUICK_ACTIONS_RADARR),
            _actionTile('Sonarr', LunaDatabaseValue.QUICK_ACTIONS_SONARR),
            LSDivider(),
            _actionTile('NZBGet', LunaDatabaseValue.QUICK_ACTIONS_NZBGET),
            _actionTile('SABnzbd', LunaDatabaseValue.QUICK_ACTIONS_SABNZBD),
            LSDivider(),
            _actionTile('Tautulli', LunaDatabaseValue.QUICK_ACTIONS_TAUTULLI),
        ],
    );

    Widget _actionTile(String title, LunaDatabaseValue action) => LSCardTile(
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
