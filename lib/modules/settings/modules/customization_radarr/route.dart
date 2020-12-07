import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationRadarrRouter {
    static const ROUTE_NAME = '/settings/customization/radarr';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsCustomizationRadarrRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsCustomizationRadarrRouter._();
}

class _SettingsCustomizationRadarrRoute extends StatefulWidget {
    @override
    State<_SettingsCustomizationRadarrRoute> createState() => _State();
}

class _State extends State<_SettingsCustomizationRadarrRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Radarr',
        actions: [
            LSIconButton(
                icon: Icons.settings,
                onPressed: () async => SettingsModulesRadarrRouter.navigateTo(context),
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
