import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationSonarrRouter {
    static const ROUTE_NAME = '/settings/customization/sonarr';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsCustomizationSonarrRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsCustomizationSonarrRouter._();
}

class _SettingsCustomizationSonarrRoute extends StatefulWidget {
    @override
    State<_SettingsCustomizationSonarrRoute> createState() => _State();
}

class _State extends State<_SettingsCustomizationSonarrRoute> {
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
        title: 'Sonarr',
        actions: [
            LSIconButton(
                icon: Icons.settings,
                onPressed: () async => SettingsModulesSonarrRouter.navigateTo(context),
            ),
        ]
    );

    Widget get _body => LSListView(
        children: [
            ..._defaultPages,
            ..._defaultSorting,
        ],
    );

    List<Widget> get _defaultPages => [
        LSHeader(
            text: 'Default Pages',
            subtitle: 'Choose the default page when opening routes with navigation bars',
        ),
        SettingsCustomizationSonarrDefaultPageHomeTile(),
        SettingsCustomizationSonarrDefaultPageSeriesDetailsTile(),
    ];

    List<Widget> get _defaultSorting => [
        LSHeader(
            text: 'Default Sorting',
            subtitle: 'Choose the default sorting type for sortable lists',
        ),
        SettingsCustomizationSonarrDefaultSortingReleasesTile(),
        SettingsCustomizationSonarrDefaultSortingSeriesTile(),
    ];
}
