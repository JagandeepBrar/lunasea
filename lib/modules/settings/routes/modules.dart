import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';

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
            title: LSTitle(text: Constants.APPLICATION_NAME),
            subtitle: LSSubtitle(text: 'Configure Global Options'),
            trailing: LSIconButton(icon: CustomIcons.code),
            onTap: () async => Navigator.of(context).pushNamed(SettingsModulesLunaSea.ROUTE_NAME),
        ),
        _tileFromModuleMap(HomeConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesHome.ROUTE_NAME)),
        if(ModuleFlags.SEARCH) _tileFromModuleMap(SearchConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesSearch.ROUTE_NAME)),
        if(ModuleFlags.WAKE_ON_LAN) _tileFromModuleMap(WakeOnLANConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesWakeOnLAN.ROUTE_NAME)),
    ];

    List<Widget> get _automation => [
        LSHeader(
            text: 'Automation',
            subtitle: 'Configure and customize automation modules',
        ),
        if(ModuleFlags.LIDARR) _tileFromModuleMap(LidarrConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesLidarr.ROUTE_NAME)),
        if(ModuleFlags.RADARR) _tileFromModuleMap(RadarrConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesRadarr.ROUTE_NAME)),
        if(ModuleFlags.SONARR) _tileFromModuleMap(SonarrConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesSonarr.ROUTE_NAME)),
    ];

    List<Widget> get _clients => [
        LSHeader(
            text: 'Clients',
            subtitle: 'Configure and customize client modules',
        ),
        if(ModuleFlags.NZBGET) _tileFromModuleMap(NZBGetConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesNZBGet.ROUTE_NAME)),
        if(ModuleFlags.SABNZBD) _tileFromModuleMap(SABnzbdConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesSABnzbd.ROUTE_NAME)),
    ];

    List<Widget> get _monitoring => [
        LSHeader(
            text: 'Monitoring',
            subtitle: 'Configure and customize monitoring modules',
        ),
        if(ModuleFlags.TAUTULLI) _tileFromModuleMap(TautulliConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesTautulli.ROUTE_NAME)),
    ];

    Widget _tileFromModuleMap(ModuleMap map, Function onTap) => LSCardTile(
        title: LSTitle(text: map.name),
        subtitle: LSSubtitle(text: map.settingsDescription),
        trailing: LSIconButton(icon: map.icon),
        onTap: onTap,
    );
}
