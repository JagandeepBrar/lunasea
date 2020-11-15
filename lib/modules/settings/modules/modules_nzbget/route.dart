import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesNZBGetRouter {
    static const ROUTE_NAME = '/settings/modules/nzbget';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsModulesNZBGetRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsModulesNZBGetRouter._();
}

class _SettingsModulesNZBGetRoute extends StatefulWidget {
    @override
    State<_SettingsModulesNZBGetRoute> createState() => _State();
}

class _State extends State<_SettingsModulesNZBGetRoute> {
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
        title: 'NZBGet',
        actions: [
            LSIconButton(
                icon: Icons.brush,
                onPressed: () async => SettingsCustomizationNZBGetRouter.navigateTo(context),
            ),
        ]
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._configuration,
                SettingsModulesNZBGetTestConnectionTile(),
            ],
        ),
    );

    List<Widget> get _configuration => [
        SettingsModulesNZBGetEnabledTile(),
        SettingsModulesNZBGetHostTile(),
        SettingsModulesNZBGetUsernameTile(),
        SettingsModulesNZBGetPasswordTile(),
        SettingsModulesNZBGetCustomHeadersTile(),
    ];
}
