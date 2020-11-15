import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesRadarrRouter {
    static const ROUTE_NAME = '/settings/modules/radarr';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsModulesRadarrRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsModulesRadarrRouter._();
}

class _SettingsModulesRadarrRoute extends StatefulWidget {
    @override
    State<_SettingsModulesRadarrRoute> createState() => _State();
}

class _State extends State<_SettingsModulesRadarrRoute> {
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
        title: 'Radarr',
        actions: [
            LSIconButton(
                icon: Icons.brush,
                onPressed: () async => SettingsCustomizationRadarrRouter.navigateTo(context),
            ),
        ]
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._configuration,
                SettingsModulesRadarrTestConnectionTile(),
            ],
        ),
    );

    List<Widget> get _configuration => [
        SettingsModulesRadarrEnabledTile(),
        SettingsModulesRadarrHostTile(),
        SettingsModulesRadarrAPIKeyTile(),
        SettingsModulesRadarrCustomHeadersTile(),
    ];
}
