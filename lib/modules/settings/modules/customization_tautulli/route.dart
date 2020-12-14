import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationTautulliRouter {
    static const ROUTE_NAME = '/settings/customization/tautulli';

    static Future<void> navigateTo(BuildContext context, [List parameters]) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsCustomizationTautulliRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsCustomizationTautulliRouter._();
}

class _SettingsCustomizationTautulliRoute extends StatefulWidget {
    @override
    State<_SettingsCustomizationTautulliRoute> createState() => _State();
}

class _State extends State<_SettingsCustomizationTautulliRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Tautulli',
        actions: [
            LSIconButton(
                icon: Icons.settings,
                onPressed: () async => SettingsModulesTautulliRouter.navigateTo(context),
            ),
        ]
    );

    Widget get _body => LSListView(
        children: [
            ..._defaultPages,
            ..._activity,
            ..._statistics,
        ],
    );

    List<Widget> get _defaultPages => <Widget>[
        LSHeader(
            text: 'Default Pages',
            subtitle: 'Choose the default page when opening routes with navigation bars',
        ),
        SettingsCustomizationTautulliDefaultPageHomeTile(),
        SettingsCustomizationTautulliDefaultPageGraphsTile(),
        SettingsCustomizationTautulliDefaultPageLibrariesDetailsTile(),
        SettingsCustomizationTautulliDefaultPageMediaDetailsTile(),
        SettingsCustomizationTautulliDefaultPageUserDetailsTile(),
    ];

    List<Widget> get _activity => <Widget>[
        LSHeader(
            text: 'Activity',
            subtitle: 'Customizable options related to Tautulli activity',
        ),
        SettingsCustomizationTautulliDefaultTerminationMessageTile(),
        SettingsCustomizationTautulliRefreshRateTile(),
    ];

    List<Widget> get _statistics => <Widget>[
        LSHeader(
            text: 'Statistics',
            subtitle: 'Customizable options related to Tautulli statistics',
        ),
        SettingsCustomizationTautulliStatisticsItemCountTile(),
    ];
}
