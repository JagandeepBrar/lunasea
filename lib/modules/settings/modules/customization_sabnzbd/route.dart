import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationSABnzbdRouter {
    static const ROUTE_NAME = '/settings/customization/sabnzbd';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsCustomizationSABnzbdRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsCustomizationSABnzbdRouter._();
}

class _SettingsCustomizationSABnzbdRoute extends StatefulWidget {
    @override
    State<_SettingsCustomizationSABnzbdRoute> createState() => _State();
}

class _State extends State<_SettingsCustomizationSABnzbdRoute> {
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
                icon: Icons.settings,
                onPressed: () async => SettingsModulesSABnzbdRouter.navigateTo(context),
            ),
        ]
    );

    Widget get _body => LSListView(
        children: [
            LSHeader(
                text: 'Default Pages',
                subtitle: 'Choose the default page when opening routes with navigation bars',
            ),
            SettingsCustomizationSABnzbdDefaultPageTile(),
        ],
    );
}
