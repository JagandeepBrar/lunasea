import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesLidarrRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/lidarr';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsModulesLidarrRoute()),
        transitionType: LunaRouter.transitionType,
    );

    @override
    State<SettingsModulesLidarrRoute> createState() => _State();
}

class _State extends State<SettingsModulesLidarrRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'Lidarr',
        actions: [
            LSIconButton(
                icon: Icons.brush,
                onPressed: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationLidarrRoute.ROUTE_NAME),
            ),
        ]
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._configuration,
                LSDivider(),
                SettingsModulesLidarrTestConnectionTile(),
            ],
        ),
    );

    List<Widget> get _configuration => [
        SettingsModulesLidarrEnabledTile(),
        LSDivider(),
        SettingsModulesLidarrHostTile(),
        SettingsModulesLidarrAPIKeyTile(),
        SettingsModulesLidarrCustomHeadersTile(),
    ];
}
