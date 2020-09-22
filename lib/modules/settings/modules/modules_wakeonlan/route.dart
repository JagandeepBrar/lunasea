import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesWakeOnLANRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/wakeonlan';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsModulesWakeOnLANRoute()),
        transitionType: LunaRouter.transitionType,
    );

    @override
    State<SettingsModulesWakeOnLANRoute> createState() => _State();
}

class _State extends State<SettingsModulesWakeOnLANRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(title: 'Wake on LAN');

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
        LSDivider(),
        SettingsModulesWakeOnLANBroadcastAddressTile(),
        SettingsModulesWakeOnLANMACAddressTile(),
    ];
}
