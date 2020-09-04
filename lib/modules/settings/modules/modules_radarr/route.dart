import 'package:fluro_fork/fluro_fork.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsModulesRadarrRoute extends StatefulWidget {
    static const ROUTE_NAME = '/settings/modules/radarr';
    static String route() => ROUTE_NAME;

    static void defineRoute(Router router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => SettingsModulesRadarrRoute()),
        transitionType: LunaRouter.transitionType,
    );

    @override
    State<SettingsModulesRadarrRoute> createState() => _State();
}

class _State extends State<SettingsModulesRadarrRoute> {
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
                icon: Icons.brush,
                onPressed: () async => SettingsRouter.router.navigateTo(context, SettingsCustomizationRadarrRoute.ROUTE_NAME),
            ),
        ]
    );

    Widget get _body => ValueListenableBuilder(
        valueListenable: Database.profilesBox.listenable(),
        builder: (context, box, _) => LSListView(
            children: [
                ..._mandatory,
                LSDivider(),
                SettingsModulesRadarrTestConnectionTile(),
                ..._advanced,
            ],
        ),
    );

    List<Widget> get _mandatory => [
        LSHeader(
            text: 'Mandatory',
            subtitle: 'Configuration that is required for functionality',
        ),
        SettingsModulesRadarrEnabledTile(),
        SettingsModulesRadarrHostTile(),
        SettingsModulesRadarrAPIKeyTile(),
    ];

    List<Widget> get _advanced => [
        LSHeader(
            text: 'Advanced',
            subtitle: 'Options for non-standard networking configurations',
        ),
        SettingsModulesRadarrCustomHeadersTile(),
        SettingsModulesRadarrStrictTLSTile(),
    ];
}
