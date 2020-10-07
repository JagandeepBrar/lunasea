import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationQuickActionsRouter {
    static const ROUTE_NAME = '/settings/customization/quickactions';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsCustomizationQuickActionsRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsCustomizationQuickActionsRouter._();
}

class _SettingsCustomizationQuickActionsRoute extends StatefulWidget {
    @override
    State<_SettingsCustomizationQuickActionsRoute> createState() => _State();
}

class _State extends State<_SettingsCustomizationQuickActionsRoute> {
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
        title: 'Quick Actions',
    );

    Widget get _body => LSListView(
        children: [
            LSHeader(
                text: 'Modules',
                subtitle: 'Only four quick actions will appear, and are added in the order below. Enabling more than four modules will have no effect.',
            ),
            SettingsCustomizationQuickActionTile(
                title: 'Search',
                action: LunaSeaDatabaseValue.QUICK_ACTIONS_SEARCH,
            ),
            LSDivider(),
            SettingsCustomizationQuickActionTile(
                title: 'Lidarr',
                action: LunaSeaDatabaseValue.QUICK_ACTIONS_LIDARR,
            ),
            SettingsCustomizationQuickActionTile(
                title: 'Radarr',
                action: LunaSeaDatabaseValue.QUICK_ACTIONS_RADARR,
            ),
            SettingsCustomizationQuickActionTile(
                title: 'Sonarr',
                action: LunaSeaDatabaseValue.QUICK_ACTIONS_SONARR,
            ),
            LSDivider(),
            SettingsCustomizationQuickActionTile(
                title: 'NZBGet',
                action: LunaSeaDatabaseValue.QUICK_ACTIONS_NZBGET,
            ),
            SettingsCustomizationQuickActionTile(
                title: 'SABnzbd',
                action: LunaSeaDatabaseValue.QUICK_ACTIONS_SABNZBD,
            ),
            LSDivider(),
            SettingsCustomizationQuickActionTile(
                title: 'Tautulli',
                action: LunaSeaDatabaseValue.QUICK_ACTIONS_TAUTULLI,
            ),
        ],
    );
}
