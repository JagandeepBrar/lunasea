import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationRadarrRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/radarr';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsCustomizationRadarrRoute()),
        transitionType: LunaRouter.transitionType,
    );

    @override
    State<SettingsCustomizationRadarrRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationRadarrRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'Radarr',
        actions: [
            LSIconButton(
                icon: Icons.settings,
                onPressed: () async => SettingsRouter.router.navigateTo(context, SettingsModulesRadarrRoute.route()),
            ),
        ]
    );

    Widget get _body => LSListView(
        children: [
            LSHeader(
                text: 'Default Pages',
                subtitle: 'Choose the default page when opening routes with navigation bars',
            ),
            SettingsCustomizationRadarrDefaultPageTile(),
        ],
    );
}
