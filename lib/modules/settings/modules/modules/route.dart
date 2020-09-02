import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';

class SettingsModulesRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules';

    SettingsModulesRoute({
        Key key,
    }): super(key: key);

    @override
    State<SettingsModulesRoute> createState() => _State();
}

class _State extends State<SettingsModulesRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            body: _body,
        );
    }

    Widget get _appBar => LSAppBar(
        title: 'Modules',
        actions: [
            SettingsModulesEnabledProfileButton(),
        ],
    );

    Widget get _body => LSListView(
        children: [
            ..._general,
            LSDivider(),
            ..._automation,
            LSDivider(),
            ..._clients,
            LSDivider(),
            ..._monitoring,
        ],
    );

    List<Widget> get _general => [
        _tileFromModuleMap(SearchConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesSearchRoute.ROUTE_NAME)),
        _tileFromModuleMap(WakeOnLANConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesWakeOnLANRoute.ROUTE_NAME)),
    ];

    List<Widget> get _automation => [
        _tileFromModuleMap(LidarrConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesLidarrRoute.ROUTE_NAME)),
        _tileFromModuleMap(RadarrConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesRadarrRoute.ROUTE_NAME)),
        _tileFromModuleMap(SonarrConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesSonarrRoute.ROUTE_NAME)),
    ];

    List<Widget> get _clients => [
        _tileFromModuleMap(NZBGetConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesNZBGetRoute.ROUTE_NAME)),
        _tileFromModuleMap(SABnzbdConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesSABnzbdRoute.ROUTE_NAME)),
    ];

    List<Widget> get _monitoring => [
        _tileFromModuleMap(TautulliConstants.MODULE_MAP, () async => Navigator.of(context).pushNamed(SettingsModulesTautulliRoute.ROUTE_NAME)),
    ];

    Widget _tileFromModuleMap(ModuleMap map, Function onTap) => LSCardTile(
        title: LSTitle(text: map.name),
        subtitle: LSSubtitle(text: map.settingsDescription),
        trailing: LSIconButton(icon: map.icon),
        onTap: onTap,
    );
}
