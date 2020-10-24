import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationSearchRouter {
    static const ROUTE_NAME = '/settings/customization/search';

    static Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        route(),
    );

    static String route() => ROUTE_NAME;
    
    static void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _SettingsCustomizationSearchRoute()),
        transitionType: LunaRouter.transitionType,
    );

    SettingsCustomizationSearchRouter._();
}

class _SettingsCustomizationSearchRoute extends StatefulWidget {
    @override
    State<_SettingsCustomizationSearchRoute> createState() => _State();
}

class _State extends State<_SettingsCustomizationSearchRoute> {
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
        title: 'Search',
        actions: [
            LSIconButton(
                icon: Icons.settings,
                onPressed: () async => SettingsModulesSearchRouter.navigateTo(context),
            ),
        ]
    );

    Widget get _body => LSListView(
        children: [
            ..._categories,
        ],
    );

    List<Widget> get _categories => [
        LSHeader(
            text: 'Filtering',
            subtitle: 'Customizable options related to the filtering categories',
        ),
        SettingsCustomizationSearchHideAdultCategoriesTile(),
    ];
}
