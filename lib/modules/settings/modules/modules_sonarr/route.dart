import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSonarrRouter {
    static const ROUTE_NAME = '/settings/modules/sonarr';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsModulesSonarrRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsModulesSonarrRouter._();
}

class _SettingsModulesSonarrRoute extends StatefulWidget {
    @override
    State<_SettingsModulesSonarrRoute> createState() => _State();
}

class _State extends State<_SettingsModulesSonarrRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Sonarr',
        actions: [
            LSIconButton(
                icon: Icons.brush,
                onPressed: () async => SettingsCustomizationSonarrRouter.navigateTo(context),
            ),
        ]
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._configuration,
                SettingsModulesSonarrTestConnectionTile(),
            ],
        ),
    );

    List<Widget> get _configuration => [
        SettingsModulesSonarrEnabledTile(),
        SettingsModulesSonarrHostTile(),
        SettingsModulesSonarrAPIKeyTile(),
        SettingsModulesSonarrCustomHeadersTile(),
        SettingsModulesSonarrEnableVersion3Tile(),
    ];
}
