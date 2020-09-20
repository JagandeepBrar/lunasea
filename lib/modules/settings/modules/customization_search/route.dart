import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationSearchRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/customization/search';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsCustomizationSearchRoute()),
        transitionType: LunaRouter.transitionType,
    );

    @override
    State<SettingsCustomizationSearchRoute> createState() => _State();
}

class _State extends State<SettingsCustomizationSearchRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'Search',
        actions: [
            LSIconButton(
                icon: Icons.settings,
                onPressed: () async => SettingsRouter.router.navigateTo(context, SettingsModulesSearchRoute.route()),
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
            text: 'Categories',
            subtitle: 'Customizable options related to the category lists',
        ),
        SettingsCustomizationSearchHideAdultCategoriesTile(),
    ];
}
