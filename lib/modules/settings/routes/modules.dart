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
        LSHeader(text: 'General'),
        LSCardTile(
            title: LSTitle(text: 'Home'),
            subtitle: LSSubtitle(text: 'Configure home screen'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.home,
                color: LSColors.list(0),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesHome.ROUTE_NAME),
        ),
        if(ModuleFlags.SEARCH) LSCardTile(
            title: LSTitle(text: 'Search'),
            subtitle: LSSubtitle(text: 'Configure newznab indexers'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: Icons.search,
                color: LSColors.list(1),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesSearch.ROUTE_NAME),
        ),
    ];

    List<Widget> get _automation => [
        LSHeader(text: 'Automation'),
        if(ModuleFlags.LIDARR) LSCardTile(
            title: LSTitle(text: 'Lidarr'),
            subtitle: LSSubtitle(text: 'Configure Lidarr'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.music,
                color: LSColors.list(2),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesLidarr.ROUTE_NAME),
        ),
        if(ModuleFlags.RADARR) LSCardTile(
            title: LSTitle(text: 'Radarr'),
            subtitle: LSSubtitle(text: 'Configure Radarr'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.movies,
                color: LSColors.list(3),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesRadarr.ROUTE_NAME),
        ),
        if(ModuleFlags.SONARR) LSCardTile(
            title: LSTitle(text: 'Sonarr'),
            subtitle: LSSubtitle(text: 'Configure Sonarr'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.television,
                color: LSColors.list(4),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesSonarr.ROUTE_NAME),
        ),
    ];

    List<Widget> get _clients => [
        LSHeader(text: 'Clients'),
        if(ModuleFlags.NZBGET) LSCardTile(
            title: LSTitle(text: 'NZBGet'),
            subtitle: LSSubtitle(text: 'Configure NZBGet'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.nzbget,
                color: LSColors.list(5),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesNZBGet.ROUTE_NAME),
        ),
        if(ModuleFlags.SABNZBD) LSCardTile(
            title: LSTitle(text: 'SABnzbd'),
            subtitle: LSSubtitle(text: 'Configure SABnzbd'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.sabnzbd,
                color: LSColors.list(6),
            ),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesSABnzbd.ROUTE_NAME),
        ),
    ];

    List<Widget> get _monitoring => [
        LSHeader(text: 'Monitoring'),
        if(ModuleFlags.TAUTULLI) LSCardTile(
            title: LSTitle(text: 'Tautulli'),
            subtitle: LSSubtitle(text: 'Configure Tautulli'),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            leading: LSIconButton(
                icon: CustomIcons.monitoring,
                color: LSColors.list(7),
            ),
            //onTap: () async => Navigator.of(context).pushNamed(SettingsModulesTautulli.ROUTE_NAME),
        ),
    ];
}
