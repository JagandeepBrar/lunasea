import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationTautulliRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/tautulli';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsCustomizationTautulliRoute()),
        transitionType: LunaRouter.transitionType,
    );

    @override
    State<SettingsCustomizationTautulliRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationTautulliRoute> {
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
        title: 'Tautulli',
        actions: [
            LSIconButton(
                icon: Icons.settings,
                onPressed: () async => SettingsRouter.router.navigateTo(context, SettingsModulesTautulliRoute.route()),
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
