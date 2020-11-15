import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesWakeOnLANRouter {
    static const ROUTE_NAME = '/settings/modules/wakeonlan';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsModulesWakeOnLANRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsModulesWakeOnLANRouter._();
}

class _SettingsModulesWakeOnLANRoute extends StatefulWidget {
    @override
    State<_SettingsModulesWakeOnLANRoute> createState() => _State();
}

class _State extends State<_SettingsModulesWakeOnLANRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        popUntil: '/settings',
        title: 'Wake on LAN',
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._configuration,
            ],
        ),
    );

    List<Widget> get _configuration => [
        SettingsModulesWakeOnLANEnabledTile(),
        SettingsModulesWakeOnLANBroadcastAddressTile(),
        SettingsModulesWakeOnLANMACAddressTile(),
    ];
}
