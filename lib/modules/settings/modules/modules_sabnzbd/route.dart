import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSABnzbdRouter {
    static const ROUTE_NAME = '/settings/modules/sabnzbd';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsModulesSABnzbdRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsModulesSABnzbdRouter._();
}

class _SettingsModulesSABnzbdRoute extends StatefulWidget {
    @override
    State<_SettingsModulesSABnzbdRoute> createState() => _State();
}

class _State extends State<_SettingsModulesSABnzbdRoute> {
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
        title: 'SABnzbd',
        actions: [
            LSIconButton(
                icon: Icons.brush,
                onPressed: () async => SettingsCustomizationSABnzbdRouter.navigateTo(context),
            ),
        ]
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._configuration,
                SettingsModulesSABnzbdTestConnectionTile(),
            ],
        ),
    );

    List<Widget> get _configuration => [
        SettingsModulesSABnzbdEnabledTile(),
        SettingsModulesSABnzbdHostTile(),
        SettingsModulesSABnzbdAPIKeyTile(),
        SettingsModulesSABnzbdCustomHeadersTile(),
    ];
}
