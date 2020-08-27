import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SettingsModulesLunaSeaQuickActions extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/lunasea/quick_actions';
    
    @override
    State<SettingsModulesLunaSeaQuickActions> createState() => _State();
}

class _State extends State<SettingsModulesLunaSeaQuickActions> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Quick Actions');

    Widget get _body => LSListView(
        children: [
            LSHeader(
                text: 'Modules',
                subtitle: 'Only four quick actions will appear, and are added in the order below. Enabling more than four modules will have no effect.',
            ),
            _tile(title: 'Search', action: LunaSeaDatabaseValue.QUICK_ACTIONS_SEARCH),
            LSDivider(),
            _tile(title: 'Lidarr', action: LunaSeaDatabaseValue.QUICK_ACTIONS_LIDARR),
            _tile(title: 'Radarr', action: LunaSeaDatabaseValue.QUICK_ACTIONS_RADARR),
            _tile(title: 'Sonarr', action: LunaSeaDatabaseValue.QUICK_ACTIONS_SONARR),
            LSDivider(),
            _tile(title: 'NZBGet', action: LunaSeaDatabaseValue.QUICK_ACTIONS_NZBGET),
            _tile(title: 'SABnzbd', action: LunaSeaDatabaseValue.QUICK_ACTIONS_SABNZBD),
            LSDivider(),
            _tile(title: 'Tautulli', action: LunaSeaDatabaseValue.QUICK_ACTIONS_TAUTULLI),
        ],
    );

    Widget _tile({
        @required String title,
        @required LunaSeaDatabaseValue action,
    }) => LSCardTile(
        title: LSTitle(text: title),
        trailing: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [action.key]),
            builder: (context, box, _) => Switch(
                value: action.data,
                onChanged: (value) {
                    action.put(value);
                    HomescreenActions.setShortcutItems();
                }
            ),
        ),
    );
}
