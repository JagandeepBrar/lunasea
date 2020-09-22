import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesSonarrRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/sonarr';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsModulesSonarrRoute()),
        transitionType: LunaRouter.transitionType,
    );

    @override
    State<SettingsModulesSonarrRoute> createState() => _State();
}

class _State extends State<SettingsModulesSonarrRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'Sonarr',
        actions: [
            LSIconButton(
                icon: Icons.brush,
                onPressed: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationSonarrRoute.ROUTE_NAME),
            ),
        ]
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._configuration,
                LSDivider(),
                SettingsModulesSonarrTestConnectionTile(),
            ],
        ),
    );

    List<Widget> get _configuration => [
        SettingsModulesSonarrEnabledTile(),
        LSDivider(),
        SettingsModulesSonarrHostTile(),
        SettingsModulesSonarrAPIKeyTile(),
        SettingsModulesSonarrCustomHeadersTile(),
    ];
}
