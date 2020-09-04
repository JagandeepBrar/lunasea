import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesNZBGetRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/nzbget';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsModulesNZBGetRoute()),
        transitionType: LunaRouter.transitionType,
    );

    @override
    State<SettingsModulesNZBGetRoute> createState() => _State();
}

class _State extends State<SettingsModulesNZBGetRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LSAppBar(
        title: 'NZBGet',
        actions: [
            LSIconButton(
                icon: Icons.brush,
                onPressed: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationNZBGetRoute.ROUTE_NAME),
            ),
        ]
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._mandatory,
                LSDivider(),
                SettingsModulesNZBGetTestConnectionTile(),
                ..._advanced,
            ],
        ),
    );

    List<Widget> get _mandatory => [
        LSHeader(
            text: 'Mandatory',
            subtitle: 'Configuration that is required for functionality',
        ),
        SettingsModulesNZBGetEnabledTile(),
        SettingsModulesNZBGetHostTile(),
        SettingsModulesNZBGetUsernameTile(),
        SettingsModulesNZBGetPasswordTile(),

    ];

    List<Widget> get _advanced => [
        LSHeader(
            text: 'Advanced',
            subtitle: 'Options for non-standard networking configurations',
        ),
        SettingsModulesNZBGetCustomHeadersTile(),
        SettingsModulesNZBGetStrictTLSTile(),
    ];
}
