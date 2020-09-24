import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationSonarrRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/sonarr';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsCustomizationSonarrRoute()),
        transitionType: LunaRouter.transitionType,
    );

    @override
    State<SettingsCustomizationSonarrRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationSonarrRoute> {
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
                icon: Icons.settings,
                onPressed: () async => SettingsRouter.router.navigateTo(context, SettingsModulesSonarrRoute.route()),
            ),
        ]
    );

    Widget get _body => LSListView(
        children: [
            LSHeader(
                text: 'Default Pages',
                subtitle: 'Choose the default page when opening routes with navigation bars',
            ),
            SettingsCustomizationSonarrDefaultPageHomeTile(),
            SettingsCustomizationSonarrDefaultPageSeriesDetailsTile(),
        ],
    );
}
