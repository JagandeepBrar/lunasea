import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';

class SettingsModulesRouter {
    static const ROUTE_NAME = '/settings/modules';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsModulesRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsModulesRouter._();
}

class _SettingsModulesRoute extends StatefulWidget {
    @override
    State<_SettingsModulesRoute> createState() => _State();
}

class _State extends State<_SettingsModulesRoute> with AutomaticKeepAliveClientMixin {
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

    Widget get _appBar => LunaAppBar(
        context: context,
        popUntil: '/settings',
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
        _tileFromModuleMap(SearchConstants.MODULE_MAP, () async => SettingsModulesSearchRouter.navigateTo(context)),
        _tileFromModuleMap(WakeOnLANConstants.MODULE_MAP, () async => SettingsModulesWakeOnLANRouter.navigateTo(context)),
    ];

    List<Widget> get _automation => [
        _tileFromModuleMap(LidarrConstants.MODULE_MAP, () async => SettingsModulesLidarrRouter.navigateTo(context)),
        _tileFromModuleMap(RadarrConstants.MODULE_MAP, () async => SettingsModulesRadarrRouter.navigateTo(context)),
        _tileFromModuleMap(SonarrConstants.MODULE_MAP, () async => SettingsModulesSonarrRouter.navigateTo(context)),
    ];

    List<Widget> get _clients => [
        _tileFromModuleMap(NZBGetConstants.MODULE_MAP, () async => SettingsModulesNZBGetRouter.navigateTo(context)),
        _tileFromModuleMap(SABnzbdConstants.MODULE_MAP, () async => SettingsModulesSABnzbdRouter.navigateTo(context)),
    ];

    List<Widget> get _monitoring => [
        _tileFromModuleMap(TautulliConstants.MODULE_MAP, () async => SettingsModulesTautulliRouter.navigateTo(context)),
    ];

    Widget _tileFromModuleMap(LunaModuleMap map, Function onTap) => LSCardTile(
        title: LSTitle(text: map.name),
        subtitle: LSSubtitle(text: map.settingsDescription),
        trailing: LSIconButton(icon: map.icon),
        onTap: onTap,
    );
}
