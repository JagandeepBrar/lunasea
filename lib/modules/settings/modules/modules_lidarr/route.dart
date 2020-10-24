import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesLidarrRouter {
    static const ROUTE_NAME = '/settings/modules/lidarr';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsModulesLidarrRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsModulesLidarrRouter._();
}

class _SettingsModulesLidarrRoute extends StatefulWidget {
    @override
    State<_SettingsModulesLidarrRoute> createState() => _State();
}

class _State extends State<_SettingsModulesLidarrRoute> {
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
        title: 'Lidarr',
        actions: [
            LSIconButton(
                icon: Icons.brush,
                onPressed: () async => SettingsCustomizationLidarrRouter.navigateTo(context),
            ),
        ]
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._configuration,
                SettingsModulesLidarrTestConnectionTile(),
            ],
        ),
    );

    List<Widget> get _configuration => [
        SettingsModulesLidarrEnabledTile(),
        SettingsModulesLidarrHostTile(),
        SettingsModulesLidarrAPIKeyTile(),
        SettingsModulesLidarrCustomHeadersTile(),
    ];
}
