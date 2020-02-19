import 'package:flutter/material.dart';
import 'package:lunasea/core/database.dart';
import 'package:lunasea/widgets.dart';

class LSDrawer extends StatelessWidget {
    final String page;

    LSDrawer({
        @required this.page,
    });

    @override
    Widget build(BuildContext context) {
        return ValueListenableBuilder(
            valueListenable: Database.getLunaSeaBox().listenable(keys: ['profile']),
            builder: (context, box, widget) {
                ProfileHiveObject profile = Database.getProfilesBox().get(box.get('profile'));
                return Drawer(
                    child: ListView(
                        children: _getDrawerEntries(context, profile),
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
                        physics: ClampingScrollPhysics(),
                    ),
                );
            }
        );
    }

    List<Widget> _getDrawerEntries(BuildContext context, ProfileHiveObject profile) {
        return <Widget>[
            DrawerHeader(
                child: null,
                decoration: BoxDecoration(
                    color: LSColors.accent,
                ),
            ),
            _buildEntry(
                context: context,
                icon: CustomIcons.home,
                title: 'Home',
                route: '/',
            ),
            _buildEntry(
                context: context,
                icon: CustomIcons.settings,
                title: 'Settings',
                route: '/settings',
                justPush: true,
            ),
            LSDivider(padding: 18.0),
            if(profile.anyAutomationEnabled) ExpansionTile(
                leading: Icon(CustomIcons.layers),
                title: Text('Automation'),
                initiallyExpanded: true,
                children: <Widget>[
                    if(profile.lidarrEnabled) _buildEntry(
                        context: context,
                        icon: CustomIcons.music,
                        title: 'Lidarr',
                        route: '/lidarr',
                        padLeft: true,
                    ),
                    if(profile.radarrEnabled) _buildEntry(
                        context: context,
                        icon: CustomIcons.movies,
                        title: 'Radarr',
                        route: '/radarr',
                        padLeft: true,
                    ),
                    if(profile.sonarrEnabled) _buildEntry(
                        context: context,
                        icon: CustomIcons.television,
                        title: 'Sonarr',
                        route: '/sonarr',
                        padLeft: true,
                    ),
                ],
            ),
            if(profile.anyClientsEnabled) ExpansionTile(
                leading: Icon(CustomIcons.clients),
                title: Text('Clients'),
                initiallyExpanded: true,
                children: <Widget>[
                    if(profile.nzbgetEnabled) _buildEntry(
                        context: context,
                        icon: CustomIcons.nzbget,
                        title: 'NZBGet',
                        route: '/nzbget',
                        padLeft: true,
                    ),
                    if(profile.sabnzbdEnabled) _buildEntry(
                        context: context,
                        icon: CustomIcons.sabnzbd,
                        title: 'SABnzbd',
                        route: '/sabnzbd',
                        padLeft: true,
                    ),
                ],
            ),
        ];
    }

    Widget _buildEntry({
        @required BuildContext context,
        @required IconData icon,
        @required String title,
        @required String route,
        bool justPush = false,
        bool padLeft = false,
    }) {
        bool currentPage = page == title.toLowerCase();
        return ListTile(
            leading: LSIcon(
                icon: icon,
                color: currentPage ? LSColors.accent : Colors.white,
            ),
            title: Text(
                title,
                style: TextStyle(
                    color: currentPage ? LSColors.accent : Colors.white,
                ),
            ),
            onTap: () async {
                Navigator.of(context).pop();
                if(!currentPage) {
                    justPush
                        ? await Navigator.of(context).pushNamed(route)
                        : await Navigator.of(context).pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
                }
            },
            contentPadding: padLeft
                ? EdgeInsets.fromLTRB(42.0, 0.0, 0.0, 0.0)
                : EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
        );
    }
}