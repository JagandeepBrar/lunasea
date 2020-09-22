import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSABnzbdRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/sabnzbd';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsModulesSABnzbdRoute()),
        transitionType: LunaRouter.transitionType,
    );

    @override
    State<SettingsModulesSABnzbdRoute> createState() => _State();
}

class _State extends State<SettingsModulesSABnzbdRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'SABnzbd',
        actions: [
            LSIconButton(
                icon: Icons.brush,
                onPressed: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationSABnzbdRoute.ROUTE_NAME),
            ),
        ]
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._configuration,
                LSDivider(),
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
