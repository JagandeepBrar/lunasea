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

class _State extends State<_SettingsConfigurationQuickActionsRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            scrollControllers: [scrollController],
            title: 'Quick Actions',
            actions: [
                LunaIconButton(
                    icon: Icons.help_outline,
                    onPressed: () async => LunaDialogs().textPreview(
                        context,
                        'Quick Actions',
                        [
                            'Quick actions allow you to quickly jump into modules directly from the home screen or launcher on your device by long pressing ${Constants.APPLICATION_NAME}\'s icon.',
                            'A limited number of quick actions can be set at a time, and enabling more than your launcher can support will have no effect.'
                        ].join('\n\n'),
                    ),
                )
            ],
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                _actionTile('Search', LunaDatabaseValue.QUICK_ACTIONS_SEARCH),
                LunaDivider(),
                _actionTile('Lidarr', LunaDatabaseValue.QUICK_ACTIONS_LIDARR),
                _actionTile('Radarr', LunaDatabaseValue.QUICK_ACTIONS_RADARR),
                _actionTile('Sonarr', LunaDatabaseValue.QUICK_ACTIONS_SONARR),
                LunaDivider(),
                _actionTile('NZBGet', LunaDatabaseValue.QUICK_ACTIONS_NZBGET),
                _actionTile('SABnzbd', LunaDatabaseValue.QUICK_ACTIONS_SABNZBD),
                LunaDivider(),
                _actionTile('Tautulli', LunaDatabaseValue.QUICK_ACTIONS_TAUTULLI),
            ],
        );
    }

    Widget _actionTile(String title, LunaDatabaseValue action) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: title),
            trailing: ValueListenableBuilder(
                valueListenable: Database.lunaSeaBox.listenable(keys: [action.key]),
                builder: (context, _, __) => LunaSwitch(
                    value: action.data,
                    onChanged: (value) {
                        action.put(value);
                        LunaQuickActions().setShortcutItems();
                    }
                ),
            ),
        );
    }
}
