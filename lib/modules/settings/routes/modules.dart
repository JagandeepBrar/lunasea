import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModules extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules';
    
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsModules> with AutomaticKeepAliveClientMixin {
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            body: _body,
        );
    }

    Widget get _body => LSListView(
        children: <Widget>[
            ..._general,
            if(ModuleFlags.AUTOMATION) ..._automation,
            if(ModuleFlags.CLIENTS) ..._clients,
            if(ModuleFlags.MONITORING) ..._monitoring,
        ],
    );

    List<Widget> get _general => [
        LSHeader(
            text: 'General',
            subtitle: 'Configure and customize general modules in LunaSea',
        ),
        LSCardTile(
            title: LSTitle(text: 'LunaSea'),
            subtitle: LSSubtitle(text: 'Configure Global Options'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.code,
                color: LSColors.list(0),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesLunaSea.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: 'Configure the Home Screen'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.home,
                color: LSColors.list(1),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesHome.ROUTE_NAME),
        ),
        if(ModuleFlags.SEARCH) LSCardTile(
            title: LSTitle(text: 'Search'),
            subtitle: LSSubtitle(text: 'Configure Search'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: Icons.search,
                color: LSColors.list(2),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesSearch.ROUTE_NAME),
        ),
        if(ModuleFlags.WAKE_ON_LAN) LSCardTile(
            title: LSTitle(text: Constants.MODULE_MAP['wake_on_lan']['name']),
            subtitle: LSSubtitle(text: 'Configure Wake on LAN'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: Constants.MODULE_MAP['wake_on_lan']['icon'],
                color: LSColors.list(3),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesWakeOnLAN.ROUTE_NAME),
        ),
    ];

    List<Widget> get _automation => [
        LSHeader(
            text: 'Automation',
            subtitle: 'Configure and customize automation modules',
        ),
        if(ModuleFlags.LIDARR) LSCardTile(
            title: LSTitle(text: 'Lidarr'),
            subtitle: LSSubtitle(text: 'Configure Lidarr'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.music,
                color: LSColors.list(4),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesLidarr.ROUTE_NAME),
        ),
        if(ModuleFlags.RADARR) LSCardTile(
            title: LSTitle(text: 'Radarr'),
            subtitle: LSSubtitle(text: 'Configure Radarr'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.movies,
                color: LSColors.list(5),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesRadarr.ROUTE_NAME),
        ),
        if(ModuleFlags.SONARR) LSCardTile(
            title: LSTitle(text: 'Sonarr'),
            subtitle: LSSubtitle(text: 'Configure Sonarr'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.television,
                color: LSColors.list(6),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesSonarr.ROUTE_NAME),
        ),
    ];

    List<Widget> get _clients => [
        LSHeader(
            text: 'Clients',
            subtitle: 'Configure and customize client modules',
        ),
        if(ModuleFlags.NZBGET) LSCardTile(
            title: LSTitle(text: 'NZBGet'),
            subtitle: LSSubtitle(text: 'Configure NZBGet'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.nzbget,
                color: LSColors.list(7),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesNZBGet.ROUTE_NAME),
        ),
        if(ModuleFlags.SABNZBD) LSCardTile(
            title: LSTitle(text: 'SABnzbd'),
            subtitle: LSSubtitle(text: 'Configure SABnzbd'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.sabnzbd,
                color: LSColors.list(8),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesSABnzbd.ROUTE_NAME),
        ),
    ];

    List<Widget> get _monitoring => [
        LSHeader(
            text: 'Monitoring',
            subtitle: 'Configure and customize monitoring modules',
        ),
        if(ModuleFlags.TAUTULLI) LSCardTile(
            title: LSTitle(text: 'Tautulli'),
            subtitle: LSSubtitle(text: 'Configure Tautulli'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.monitoring,
                color: LSColors.list(9),
            ),
            //onTap: () async => Navigator.of(context).pushNamed(SettingsModulesTautulli.ROUTE_NAME),
        ),
    ];
}
